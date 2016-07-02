//
//  Configuration.h
//  ClockRadio
//
//  Created by Andre Heß on 18/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuration : NSObject

@property (nonatomic, strong) NSURL *currentSelectedRadioStationURL;
@property (nonatomic, strong) NSString *currentSelectedRadioStationURLString;
@property (nonatomic, assign, readonly) BOOL currentRadioStationSelected;
@property (nonatomic, strong) NSDate *currentAlarmDate;
@property (nonatomic, assign, readonly) BOOL currentAlarmDateSelected;

+ (Configuration *)currentConfiguration;

@end
