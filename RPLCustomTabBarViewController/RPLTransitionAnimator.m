//
//  RPLTransitionAnimator.m
//  RPLCustomTabBarViewController
//
//  Created by user on 06.12.13.
//  Copyright (c) 2013 mikk.22. All rights reserved.
//

#import "RPLTransitionAnimator.h"

@interface RPLTransitionAnimator()

@property (nonatomic)   UINavigationControllerOperation     navigationControllerOperation;

@end

@implementation RPLTransitionAnimator

-(id)init
{
    return [self initWithAnimationControllerForOperation:UINavigationControllerOperationPush];
}

-(id)initWithAnimationControllerForOperation:(UINavigationControllerOperation)operation
{
    self=[super init];
    if (self)
    {
        _navigationControllerOperation=operation;
    }
    
    return self;
}




- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return kPushAnimationDuration;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (self.presenting) {
        //ANIMATE VC ENTERING FROM THE RIGHT SIDE OF THE SCREEN
        [transitionContext.containerView addSubview:fromVC.view];
        [transitionContext.containerView addSubview:toVC.view];
        
        
        if (self.navigationControllerOperation==UINavigationControllerOperationPush)
        {
            fromVC.view.transform = CGAffineTransformIdentity;
            toVC.view.frame = CGRectMake(CGRectGetWidth(fromVC.view.bounds),
                                         0.f,
                                         CGRectGetWidth(toVC.view.bounds),
                                         CGRectGetHeight(transitionContext.containerView.bounds));
        } else
        if (self.navigationControllerOperation==UINavigationControllerOperationPop)
        {
            toVC.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(fromVC.view.bounds) * -1, 0);
            fromVC.view.transform = CGAffineTransformIdentity;
        }


        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             
                             //CGFloat directionVector;

                             if (self.navigationControllerOperation==UINavigationControllerOperationPush)
                             {
                                 fromVC.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(fromVC.view.bounds) * -1, 0);
                                 toVC.view.frame = CGRectMake(0,
                                                              0.f,
                                                              CGRectGetWidth(toVC.view.bounds),
                                                              CGRectGetHeight(transitionContext.containerView.bounds));
                             } else
                            if (self.navigationControllerOperation==UINavigationControllerOperationPop)
                             {
                                 toVC.view.transform = CGAffineTransformIdentity;
                                 fromVC.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(fromVC.view.bounds) * 1, 0);
                             }
                             
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                             fromVC.view.transform=CGAffineTransformIdentity;
                             toVC.view.transform=CGAffineTransformIdentity;
                         }];
    }else{
        //ANIMATE VC EXITING TO THE RIGHT SIDE OF THE SCREEN
    }
}

@end
