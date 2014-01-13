//
//  RPLCustomTabBarViewController.h
//  RPLCustomTabBarViewController
//
//  Created by user on 06.12.13.
//  Copyright (c) 2013 mikk.22. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPLCustomTabBarViewController : UIViewController

// View Controllers handled by the tab bar controller.
@property (nonatomic, strong) NSMutableArray *viewControllers;

// Current active view controller
@property (nonatomic, strong) UIViewController *selectedViewController;

// Current active view controller index
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign)   CGFloat     tabBarHeight;
@property (nonatomic, readonly) UIView      *tabBarContentView;

@property (nonatomic, readonly) UIView      *contentView;

@end
