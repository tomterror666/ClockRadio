//
//  NSDate+Utility.m
//  ClockRadio
//
//  Created by Andre Heß on 22/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "NSDate+Utility.h"

@implementation NSDate (Utility)

+ (NSDate *)normalizeSecondsOfDate:(NSDate *)date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
	NSDateComponents *components = [calendar components:unitFlags fromDate:date];
	return [calendar dateFromComponents:components];
}

+ (NSDate *)normalizeMinutesOfDate:(NSDate *)date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour;
	NSDateComponents *components = [calendar components:unitFlags fromDate:date];
	return [calendar dateFromComponents:components];
}

+ (NSDate *)normalizeHoursOfDate:(NSDate *)date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
	NSDateComponents *components = [calendar components:unitFlags fromDate:date];
	return [calendar dateFromComponents:components];
}

- (NSString *)dateAndTimeString {
	NSDateFormatter *formatter = [NSDateFormatter new];
	formatter.dateFormat = @"dd.MM.yyyy - HH:mm:ss";
	return [formatter stringFromDate:self];
}

- (NSString *)dateString {
	NSDateFormatter *formatter = [NSDateFormatter new];
	formatter.dateFormat = @"dd.MM.yyyy";
	return [formatter stringFromDate:self];
}

- (NSString *)timeString {
	NSDateFormatter *formatter = [NSDateFormatter new];
	formatter.dateFormat = @"HH:mm:ss";
	return [formatter stringFromDate:self];
}

@end
