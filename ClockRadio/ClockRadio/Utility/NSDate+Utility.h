//
//  NSDate+Utility.h
//  ClockRadio
//
//  Created by Andre Heß on 22/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utility)

+ (NSDate *)normalizeSecondsOfDate:(NSDate *)date;

+ (NSDate *)normalizeMinutesOfDate:(NSDate *)date;

+ (NSDate *)normalizeHoursOfDate:(NSDate *)date;

- (NSString *)dateAndTimeString;

- (NSString *)dateString;

- (NSString *)timeString;

@end
