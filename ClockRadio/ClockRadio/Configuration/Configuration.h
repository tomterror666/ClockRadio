//
//  Configuration.h
//  ClockRadio
//
//  Created by Andre Heß on 18/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Configuration;

static Configuration *sharedConfiguration = nil;
static dispatch_once_t onceToken;

@class Sound;

@interface Configuration : NSObject

@property (nonatomic, strong) NSURL *currentSelectedRadioStationURL;
@property (nonatomic, strong) NSString *currentSelectedRadioStationURLString;
@property (nonatomic, assign, readonly) BOOL currentRadioStationSelected;
@property (nonatomic, strong) NSDate *currentAlarmDate;
@property (nonatomic, assign, readonly) BOOL currentAlarmDateSelected;
@property (nonatomic, assign, getter=shouldPlayImmediately) BOOL playImmediately;
@property (nonatomic, strong) Sound *currentSelectedSound;

+ (Configuration *)currentConfiguration;

@end
