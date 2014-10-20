//
//  LayoutUtils.h
//  georunning
//
//  Created by William Pompei on 01/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LayoutUtil : NSObject

+( void)addChild:( UIViewController *)childViewController
inPlaceholderView:( UIView *)placeholderView
        toParent:( UIViewController *)parentViewController
      usingSetup:( void ( ^)(void))setup
andAnimationBlock:( void( ^)(void))animation
    withDuration:( NSTimeInterval)duration;

@end
