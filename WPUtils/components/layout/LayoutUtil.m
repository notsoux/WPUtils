//
//  LayoutUtils.m
//  georunning
//
//  Created by William Pompei on 01/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import "LayoutUtil.h"

@implementation LayoutUtil

+( void)addChild:( UIViewController *)childViewController
inPlaceholderView:( UIView *)placeholderView
        toParent:( UIViewController *)parentViewController
      usingSetup:( void ( ^)(void))setup
andAnimationBlock:( void( ^)(void))animation
    withDuration:( NSTimeInterval)duration{
   [parentViewController addChildViewController: childViewController];
   [placeholderView addSubview: childViewController.view];
   [childViewController didMoveToParentViewController: parentViewController];
   UIView *vcView = childViewController.view;
   vcView.translatesAutoresizingMaskIntoConstraints = NO;
   NSDictionary *views = NSDictionaryOfVariableBindings( vcView);
   
   [placeholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[vcView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
   [placeholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[vcView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
   
   if( setup){
      setup();
   }
   
   if( animation){
      [UIView animateWithDuration: duration animations:^{
         animation();
      }];
   }
}
@end
