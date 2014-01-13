//
//  RPLAppDelegate.m
//  RPLCustomTabBarViewControllerExample
//
//  Created by user on 09.01.14.
//  Copyright (c) 2014 RPL. All rights reserved.
//

#import "RPLAppDelegate.h"
#import "RPLTabBarViewController.h"
#import "RPLViewController.h"

@interface RPLAppDelegate()

@property (nonatomic, strong)   RPLTabBarViewController   *tabBarViewController;

@end


@implementation RPLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RPLTabBarViewController *tabBarViewController=[[RPLTabBarViewController alloc] init];
    tabBarViewController.tabBarHeight=100.f;
    self.tabBarViewController=tabBarViewController;
    
    RPLViewController *vc1=RPLViewController.new;
    vc1.view.backgroundColor=[UIColor greenColor];
    UINavigationController *nc=[[UINavigationController alloc] initWithRootViewController:vc1];
    
    UIViewController *vc2=UIViewController.new;
    vc2.view.backgroundColor=[UIColor yellowColor];
    
    UIViewController *vc3=UIViewController.new;
    vc3.view.backgroundColor=[UIColor purpleColor];
    
    self.tabBarViewController.viewControllers=[NSMutableArray arrayWithArray:@[nc,vc2,vc3]];
    
    
    // Override point for customization after application launch.
	self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
	self.window.rootViewController = self.tabBarViewController;
	[self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
