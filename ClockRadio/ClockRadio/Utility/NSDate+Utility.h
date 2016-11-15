//
//  NSDate+Utility.h
//  ClockRadio
//
//  Created by Andre Heß on 22/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utility)

@property (nonatomic, assign, readonly) NSInteger hours;
@property (nonatomic, assign, readonly) NSInteger minutes;
@property (nonatomic, assign, readonly) NSInteger seconds;
@property (nonatomic, assign, readonly) NSInteger year;
@property (nonatomic, assign, readonly) NSInteger month;
@property (nonatomic, assign, readonly) NSInteger day;


+ (NSDate *)normalizeSecondsOfDate:(NSDate *)date;

+ (NSDate *)normalizeMinutesOfDate:(NSDate *)date;

+ (NSDate *)normalizeHoursOfDate:(NSDate *)date;

- (NSString *)dateAndTimeString;

- (NSString *)dateString;
- (NSString *)dateStringInDatePickerFormat;

- (NSString *)timeString;

@end
