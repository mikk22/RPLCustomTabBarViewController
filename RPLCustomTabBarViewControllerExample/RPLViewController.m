//
//  MIKViewController.m
//  MIKCustomTabBarViewControllerExample
//
//  Created by user on 06.12.13.
//  Copyright (c) 2013 mikk.22. All rights reserved.
//

#import "RPLViewController.h"

@interface RPLViewController ()

@end

@implementation RPLViewController

- (void)viewDidLoad
{
    //NSLog(@"DID_LOAD");
    [super viewDidLoad];
    if([UIViewController instancesRespondToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout=UIRectEdgeNone;
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor blackColor];
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 addTarget:self action:@selector(tap1) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"PUSH" forState:UIControlStateNormal];
    button1.frame=CGRectMake(0., 25.f, 100.f, 50.f);
    [self.view addSubview:button1];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //NSLog(@"WILL_APPEAR");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tap1
{
    UIViewController *vc=UIViewController.new;
    vc.view.backgroundColor=[UIColor redColor];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
