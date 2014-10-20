//
//  ComponentLocation.h
//  georunning
//
//  Created by William Pompei on 02/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ComponentLocation : NSObject

-( void)locationFoundBlock:( void( ^)( CLLocation *))block;
-( void)locationErrorBlock:( void( ^)( NSError *))block;
-( void)locationPauseBlock:( void( ^)( void))block;

-( void)locationResumeBlock:( void( ^)( void))block;

-( void)locationFinishDereferredBlock:( void( ^)( NSError *))block;

- (void)startStandardUpdatesUsingAccuracy:( CLLocationAccuracy)accuracy
                           distanceFilter:( int)CLLocationAccuracy;

-( void)stopStandardUpdates;

extern NSString * const __kNotificationGeorunningComponentLocation;

@end
