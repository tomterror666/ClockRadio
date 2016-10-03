//
//  MockedConfiguration.h
//  ClockRadio
//
//  Created by Andre Heß on 02/10/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sound;

@interface MockedConfiguration : NSObject

- (void)mockEmptyConfiguration;
- (void)mockCurrentSelectedRadioStationURL:(NSURL *)currentSelectedRadioStationURL;
- (void)mockCurrentSelectedRadioStationURLString:(NSString *)currentSelectedRadioStationURLString;
- (void)mockCurrentRadioStationSelected:(BOOL)currentRadioStationSelected;
- (void)mockCurrentAlarmDate:(NSDate *)currentAlarmDate;
- (void)mockCurrentAlarmDateSelected:(BOOL)currentAlarmDateSelected;
- (void)mockPlayImmediately:(BOOL)playImmediately;
- (void)mockCurrentSelectedSound:(Sound *)sound;

@end
