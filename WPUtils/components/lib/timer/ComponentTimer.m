//
//  ComponentTimer.m
//  georunning
//
//  Created by William Pompei on 02/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import "ComponentTimer.h"

@interface ComponentTimer(){
   
   NSTimer *timer;
   
   NSTimeInterval startTimerValue;
   NSTimeInterval stopTimerValue;
   void( ^startTimerBlock)( void);
   void( ^stopTimerBlock)( NSTimeInterval start, NSTimeInterval stop, NSTimeInterval elapsed);
   void( ^runningTimerBlock)( NSTimeInterval elapsed);
}

@end
@implementation ComponentTimer

-( void)setupStartTimerBlock:( void( ^)( void))block{
   startTimerBlock = block;
}

-( void)setupStopTimerBlock:( void( ^)( NSTimeInterval start, NSTimeInterval stop, NSTimeInterval elapsed))block{
   stopTimerBlock = block;
}

-( void)setupRunningTimerBlock:( void( ^)( NSTimeInterval elapsed))block{
   runningTimerBlock = block;
}

#pragma mark -
-( void)startTimer:( NSTimeInterval) interval{
   timer = [NSTimer scheduledTimerWithTimeInterval: interval
                                            target: self
                                          selector: @selector( runTimer:)
                                          userInfo: nil
                                           repeats: YES];
   startTimerValue = [[NSDate date] timeIntervalSince1970];
   if( startTimerBlock){
      startTimerBlock();
   }
}

-( void)stopTimer{
   stopTimerValue = [[NSDate date] timeIntervalSince1970];
   if( stopTimerValue){
      NSTimeInterval elapsed = [self getValue];
      stopTimerBlock( startTimerValue, stopTimerValue, elapsed);
   }
   [timer invalidate];
   timer = nil;
}

-( void)runTimer:( NSTimer *)timer{
   if( runningTimerBlock){
      NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
      runningTimerBlock( current - startTimerValue);
   }
}

-( NSTimeInterval)getValue{
   return stopTimerValue - startTimerValue;
}
@end
