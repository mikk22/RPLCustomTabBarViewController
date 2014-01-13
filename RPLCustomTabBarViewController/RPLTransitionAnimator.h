//
//  RPLTransitionAnimator.h
//  RPLCustomTabBarViewController
//
//  Created by user on 06.12.13.
//  Copyright (c) 2013 mikk.22. All rights reserved.
//

#import <Foundation/Foundation.h>

// Default Push animation duration
static const float kPushAnimationDuration = 0.35;

@interface RPLTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign, getter = isPresenting) BOOL presenting;

-(id)initWithAnimationControllerForOperation:(UINavigationControllerOperation)operation;

@end
