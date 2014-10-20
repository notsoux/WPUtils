//
//  ComponentTimer.h
//  georunning
//
//  Created by William Pompei on 02/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComponentTimer : NSObject

#pragma mark - setup block
-( void)setupStartTimerBlock:( void( ^)( void))block;

-( void)setupStopTimerBlock:( void( ^)( NSTimeInterval start, NSTimeInterval stop, NSTimeInterval elapsed))block;

-( void)setupRunningTimerBlock:( void( ^)( NSTimeInterval elapsed))block;

#pragma mark - timer management
-( void)startTimer:( NSTimeInterval) interval;

-( void)stopTimer;

-( void)runTimer:( NSTimer *)timer;

-( NSTimeInterval)getValue;

@end
