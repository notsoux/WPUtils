//
//  ComponentMapViewController.h
//  georunning
//
//  Created by William Pompei on 01/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ComponentGUIMapViewController : UIViewController 

#pragma mark - helper
-( void)locationFoundHelperCenterOnUserLocation:( BOOL)center;

-( void)locationFoundBlock:( void( ^)( CLLocation *))block;

#pragma amrk - location management
-( void)start;
-( void)stop;

@end
