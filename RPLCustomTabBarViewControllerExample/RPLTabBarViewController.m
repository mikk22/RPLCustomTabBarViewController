//
//  MIKTabBarViewController.m
//  MIKCustomTabBarViewControllerExample
//
//  Created by user on 06.12.13.
//  Copyright (c) 2013 mikk.22. All rights reserved.
//

#import "RPLTabBarViewController.h"
#import "RPLViewController.h"

@interface RPLTabBarViewController ()

@end

@implementation RPLTabBarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 addTarget:self action:@selector(tap1) forControlEvents:UIControlEventTouchUpInside];
    button1.frame=CGRectMake(0., 25.f, 100.f, 50.f);
    button1.backgroundColor=[UIColor orangeColor];
    [self.tabBarContentView addSubview:button1];
    
    
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.backgroundColor=[UIColor orangeColor];
    [button2 addTarget:self action:@selector(tap2) forControlEvents:UIControlEventTouchUpInside];
    button2.frame=CGRectMake(200., 25.f, 100.f, 50.f);
    [self.tabBarContentView addSubview:button2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tap1
{
    //NSLog(@"FIRST");
    
    //UIViewController *vc=UIViewController.new;
    //vc.view.backgroundColor=[UIColor darkGrayColor];
    //self.selectedViewController=vc;
    
    self.selectedIndex=0;
}

-(void)tap2
{
    //NSLog(@"SECOND");
    
    //MIKViewController *vc=MIKViewController.new;
    //UINavigationController *nc=[[UINavigationController alloc] initWithRootViewController:vc];
    //vc.view.backgroundColor=[UIColor underPageBackgroundColor];
    //self.selectedViewController=nc;
    self.selectedIndex=1;
}

@end
