//
//  RPLCustomTabBarViewController.m
//  RPLCustomTabBarViewControllerExample
//
//  Created by user on 06.12.13.
//  Copyright (c) 2013 mikk.22. All rights reserved.
//

#import "RPLCustomTabBarViewController.h"
#import "RPLTransitionAnimator.h"

typedef enum {
    RPLShowHideFromLeft,
    RPLShowHideFromRight
} RPLShowHideFrom;

@interface RPLCustomTabBarViewController () <UINavigationControllerDelegate>
{
    NSArray *prevViewControllers;
}

//controller content view
@property (nonatomic, strong)   UIView      *contentView;
//tabbar content view
//you can add here your own selection control
@property (nonatomic, strong)   UIView      *tabBarContentView;

//
-(void)_removeViewControllerFromHierarchy;
-(void)_addViewControllerToHierarchy:(UIViewController*)viewController;


@end

@implementation RPLCustomTabBarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    
    self.tabBarContentView=UIView.new;
    self.tabBarContentView.clipsToBounds=YES;
    self.tabBarContentView.backgroundColor=[UIColor clearColor];
    [self.view insertSubview:self.tabBarContentView aboveSubview:self.contentView];
}


#pragma mark - ViewController Life cycle

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    //if ((self.childViewControllers == nil || !self.childViewControllers.count))
    //    [self.selectedViewController viewWillAppear:animated];

    [self _layoutViews];
}
/*
- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
    //if ((self.childViewControllers == nil || !self.childViewControllers.count))
        [self.selectedViewController viewDidAppear:animated];
    
    //visible = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    
    //if ((self.childViewControllers == nil || !self.childViewControllers.count))
        [self.selectedViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    
    //if (![self respondsToSelector:@selector(addChildViewController:)])
        [self.selectedViewController viewDidDisappear:animated];
    
    //visible = NO;
}
*/

-(void)_layoutViews
{
    CGRect contentViewRect=self.view.bounds;
    contentViewRect.size.height-=self.tabBarHeight;
    self.contentView.frame=contentViewRect;
    
    self.tabBarContentView.frame=CGRectMake(0.f, CGRectGetHeight(self.view.bounds)-self.tabBarHeight, CGRectGetWidth(contentViewRect), self.tabBarHeight);
    self.selectedViewController.view.frame = self.contentView.bounds;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.selectedViewController.view.frame = self.contentView.bounds;
}





#pragma mark - Setters


- (void)setContentView:(UIView *)contentView
{
    if (_contentView != contentView)
    {
        [_contentView removeFromSuperview];
        _contentView = contentView;
        //_contentView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.tabBar.frame.origin.y);
        [self.view addSubview:_contentView];
        [self.view sendSubviewToBack:_contentView];
        [_contentView setNeedsDisplay];
        [self.view setNeedsLayout];
    }
}


- (void)setViewControllers:(NSMutableArray *)viewControllers
{
    _viewControllers = viewControllers;
    
//    // Add the view controllers as child view controllers, so they can find this controller
//    if([self respondsToSelector:@selector(addChildViewController:)]) {
//        for(UIViewController* vc in _viewControllers) {
//            [self addChildViewController:vc];
//        }
//    }
    
    // When setting the view controllers, the first vc is the selected one;
    if (viewControllers.count)
        [self setSelectedViewController:viewControllers[0]];
    
    // Load the tabs on the go
//    [self loadTabs];
}



- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    //UIViewController *previousSelectedViewController = _selectedViewController;
    NSInteger selectedIndex = [self.viewControllers indexOfObject:selectedViewController];
    
    if (_selectedViewController != selectedViewController /*&& selectedIndex != NSNotFound*/)
    {
        [self _removeViewControllerFromHierarchy];
        
        _selectedViewController = selectedViewController;
        _selectedIndex = selectedIndex;
        
        
        [self _addViewControllerToHierarchy:selectedViewController];
        
        if ([selectedViewController isKindOfClass:UINavigationController.class])
            ((UINavigationController*)selectedViewController).delegate = self;

        
        /*
        if ((self.childViewControllers == nil || !self.childViewControllers.count) && visible)
        {
			[previousSelectedViewController viewWillDisappear:NO];
			[selectedViewController viewWillAppear:NO];
		}
        
        [tabBarView setContentView:selectedViewController.view];
        
        if ((self.childViewControllers == nil || !self.childViewControllers.count) && visible)
        {
			[previousSelectedViewController viewDidDisappear:NO];
			[selectedViewController viewDidAppear:NO];
		}
        
        [tabBar setSelectedTab:(tabBar.tabs)[selectedIndex]];
        */
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    [self setSelectedViewController:[self.viewControllers objectAtIndex:selectedIndex]];
}





#pragma mark -



-(void)_removeViewControllerFromHierarchy
{
    if (self.selectedViewController)
    {
        //remove old viewController
        [self.selectedViewController willMoveToParentViewController:nil];
        [self.selectedViewController.view removeFromSuperview];
        [self.selectedViewController removeFromParentViewController];
    }
}


-(void)_addViewControllerToHierarchy:(UIViewController*)viewController
{
    [self addChildViewController:viewController];
    viewController.view.frame = self.contentView.bounds;
    viewController.view.autoresizesSubviews=YES;
    viewController.view.autoresizingMask=UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //[self.contentView addSubview:viewController.view];
    
    self.contentView=viewController.view;
    [viewController didMoveToParentViewController:self];
}


#pragma - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (!prevViewControllers)
        prevViewControllers = navigationController.viewControllers;
    
    
    // We detect is the view as been push or popped
    BOOL pushed;
    
    if (prevViewControllers.count <= navigationController.viewControllers.count)
        pushed = YES;
    else
        pushed = NO;
    
    // Logic to know when to show or hide the tab bar
    BOOL isPreviousHidden, isNextHidden;
    
    isPreviousHidden = [prevViewControllers.lastObject hidesBottomBarWhenPushed];
    isNextHidden = viewController.hidesBottomBarWhenPushed;
    
    prevViewControllers = navigationController.viewControllers;
    
    if (!isPreviousHidden && !isNextHidden)
        return;
    
    else if (!isPreviousHidden && isNextHidden)
        [self hideTabBar:(pushed ? RPLShowHideFromRight : RPLShowHideFromLeft) animated:animated];
    
    else if (isPreviousHidden && !isNextHidden)
        [self showTabBar:(pushed ? RPLShowHideFromRight : RPLShowHideFromLeft) animated:animated];
    
    else if (isPreviousHidden && isNextHidden)
        return;
}





- (void)showTabBar:(RPLShowHideFrom)showHideFrom animated:(BOOL)animated
{
    
    CGFloat directionVector;
    
    switch (showHideFrom) {
        case RPLShowHideFromLeft:
            directionVector = -1.0;
            break;
        case RPLShowHideFromRight:
            directionVector = 1.0;
            break;
        default:
            break;
    }
    
    self.tabBarContentView.hidden = NO;
    self.tabBarContentView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.view.bounds) * directionVector, 0);
    // when the tabbarview is resized we can see the view behind
    
    [UIView animateWithDuration:((animated) ? kPushAnimationDuration : 0) animations:^{
        self.tabBarContentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //self.tabBarContentView.isTabBarHidding = NO;
        [self.tabBarContentView setNeedsLayout];

        [self _layoutViews];
    }];
}

- (void)hideTabBar:(RPLShowHideFrom)showHideFrom animated:(BOOL)animated
{
    
    CGFloat directionVector;
    switch (showHideFrom) {
        case RPLShowHideFromLeft:
            directionVector = 1.0;
            break;
        case RPLShowHideFromRight:
            directionVector = -1.0;
            break;
        default:
            break;
    }
    
    self.contentView.frame=self.view.bounds;
    [UIView animateWithDuration:((animated) ? kPushAnimationDuration : 0) animations:^{
        self.tabBarContentView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(self.view.bounds) * directionVector, 0);
    } completion:^(BOOL finished)
    {
        self.tabBarContentView.hidden = YES;
        self.tabBarContentView.transform = CGAffineTransformIdentity;
        
    }];
}




#pragma mark - iOS7 -

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    
    RPLTransitionAnimator *animator = [[RPLTransitionAnimator alloc] initWithAnimationControllerForOperation:operation];
    animator.presenting = YES;
    return animator;
}


@end
