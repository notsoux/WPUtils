//
//  ComponentLocation.m
//  georunning
//
//  Created by William Pompei on 02/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import "ComponentLocation.h"

@interface ComponentLocation()< CLLocationManagerDelegate>{
   CLLocationManager *locationManager;
   void( ^ locationFoundBlock)( CLLocation *);
   void( ^ locationErrorBlock)( NSError *);
   
   void( ^ locationPauseBlock)( void);
   void( ^ locationResumeBlock)( void);
   void( ^ locatioFinishDereferredBlock)( NSError *);
}

@end
@implementation ComponentLocation

#define THREESHOLD_SECOND 2.0

NSString * const __kNotificationGeorunningComponentLocation = @"__kNotificationGeorunningComponentLocation";

#pragma mark -
-( void) dealloc{
   
}

#pragma mark - seup block
-( void)locationFoundBlock:( void( ^)( CLLocation *))block{
   locationFoundBlock = block;
}

-( void)locationErrorBlock:( void( ^)( NSError *))block{
   locationErrorBlock = block;
}

-( void)locationPauseBlock:( void( ^)( void))block{
   locationPauseBlock = block;
}

-( void)locationResumeBlock:( void( ^)( void))block{
   locationResumeBlock = block;
}

-( void)locationFinishDereferredBlock:( void( ^)( NSError *))block{
   locatioFinishDereferredBlock = block;
}

#pragma mark - location management

- (void)startStandardUpdatesUsingAccuracy:( CLLocationAccuracy)accuracy
                           distanceFilter:( int)CLLocationAccuracy{
   // Create the location manager if this object does not
   // already have one.
   if (nil == locationManager)
      locationManager = [[CLLocationManager alloc] init];
   
   locationManager.delegate = self;
   locationManager.desiredAccuracy = accuracy;
   
   // Set a movement threshold for new events.
   //locationManager.distanceFilter = CLLocationAccuracy; // meters
   
   [locationManager startUpdatingLocation];
}

-( void)stopStandardUpdates{
   [locationManager stopUpdatingLocation];
}

#pragma mark - delegate
// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
   // If it's a relatively recent event, turn off updates to save power.
   CLLocation* location = [locations lastObject];
   NSDate* eventDate = location.timestamp;
   NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
   if (abs(howRecent) < THREESHOLD_SECOND) {
      // If the event is recent, do something with it.
      /*
      NSLog(@"latitude %+.6f, longitude %+.6f\n",
            location.coordinate.latitude,
            location.coordinate.longitude);
       */
      if( locationFoundBlock){
         locationFoundBlock( location);
      }
      [[NSNotificationCenter defaultCenter] postNotificationName: __kNotificationGeorunningComponentLocation object: location];
   }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
   if( locationErrorBlock){
      locationErrorBlock( error);
   }
}

/*
 *  Discussion:
 *    Invoked when location updates are automatically paused.
 */
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager{
   if( locationPauseBlock){
      locationPauseBlock();
   }
}
/*
 *  Discussion:
 *    Invoked when location updates are automatically resumed.
 *
 *    In the event that your application is terminated while suspended, you will
 *	  not receive this notification.
 */
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager{
   if( locationResumeBlock){
      locationResumeBlock();
   }
}

/*
 *  locationManager:didFinishDeferredUpdatesWithError:
 *
 *  Discussion:
 *    Invoked when deferred updates will no longer be delivered. Stopping
 *    location, disallowing deferred updates, and meeting a specified criterion
 *    are all possible reasons for finishing deferred updates.
 *
 *    An error will be returned if deferred updates end before the specified
 *    criteria are met (see CLError).
 */
- (void)locationManager:(CLLocationManager *)manager
didFinishDeferredUpdatesWithError:(NSError *)error{
   if( locatioFinishDereferredBlock){
      locatioFinishDereferredBlock( error);
   }
}


@end
