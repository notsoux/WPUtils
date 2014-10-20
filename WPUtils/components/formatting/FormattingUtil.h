//
//  FormattingUtil.h
//  georunning
//
//  Created by William Pompei on 02/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FormattingUtil : NSObject

+( NSString *)formatTime:( NSTimeInterval) time;

+( NSString *)formatLocationIntoJsonString:( CLLocation *)location;

+( NSString *)formatDictIntoJsonString:( NSDictionary *)jsonDict;

@end
