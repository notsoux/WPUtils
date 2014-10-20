//
//  FormattingUtil.m
//  georunning
//
//  Created by William Pompei on 02/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import "FormattingUtil.h"

@implementation FormattingUtil

+( NSString *)formatTime:( NSTimeInterval) time{
   unsigned int seconds = (unsigned int)round(time);
   NSString *string = [NSString stringWithFormat:@"%02u:%02u:%02u",
                       seconds / 3600, (seconds / 60) % 60, seconds % 60];
   return string;
}

+( NSString *)formatLocationIntoJsonString:( CLLocation *)location{
   NSString *latitudeAsString = [NSString stringWithFormat: @"%f", location.coordinate.latitude];
   NSString *longitudeAsString = [NSString stringWithFormat: @"%f", location.coordinate.longitude];
   NSDictionary *jsonDict = @{ @"latitude": latitudeAsString, @"longitude": longitudeAsString};
   
   NSError *error;
   NSData *jsonData = [NSJSONSerialization dataWithJSONObject: jsonDict
                                                      options:0 // Pass 0 if you don't care about the readability of the generated string
                                                        error:&error];
   NSString *jsonString;
   if (! jsonData) {
      NSLog(@"Got an error: %@", error);
      return nil;
   } else {
      jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
   }
   return jsonString;
}


+( NSString *)formatDictIntoJsonString:( NSDictionary *)jsonDict{   
   NSError *error;
   NSData *jsonData = [NSJSONSerialization dataWithJSONObject: jsonDict
                                                      options:0 // Pass 0 if you don't care about the readability of the generated string
                                                        error:&error];
   NSString *jsonString;
   if (! jsonData) {
      NSLog(@"Got an error: %@", error);
      return nil;
   } else {
      jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
   }
   return jsonString;
}





@end
