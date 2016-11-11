//
//  MockedConfiguration.m
//  ClockRadio
//
//  Created by Andre Heß on 02/10/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "MockedConfiguration.h"
#import <OCMock/OCMock.h>

#import "Configuration.h"
#import "Configuration+UITest.h"
#import "Sound.h"

@interface MockedConfiguration ()
@property (nonatomic, strong) Configuration *config;
@property (nonatomic, strong) id mockedConfig;
@end

@implementation MockedConfiguration

- (id)init {
	self = [super init];
	if (self != nil) {
		self.config = [Configuration currentConfiguration];
		self.mockedConfig = [OCMockObject partialMockForObject:self.config];
		[[[self.mockedConfig stub] andReturn:self.mockedConfig] currentConfiguration];
	}
	return self;
}

- (void)dealloc {
	[self.mockedConfig stopMocking];
}

#pragma mark -
#pragma mark Mocking
#pragma mark -

- (void)mockEmptyConfiguration {
	[self mockCurrentSelectedRadioStationURL:nil];
	[self mockCurrentSelectedRadioStationURLString:@""];
	[self mockCurrentRadioStationSelected:NO];
	[self mockCurrentAlarmDate:nil];
	[self mockCurrentAlarmDateSelected:NO];
	[self mockPlayImmediately:NO];
	[self mockCurrentSelectedSound:nil];
}

- (void)stopMocking {
	[self.mockedConfig stopMocking];
	[self.config finish];
}

- (void)mockCurrentSelectedRadioStationURL:(NSURL *)currentSelectedRadioStationURL {
	[[[self.mockedConfig stub] andReturn:currentSelectedRadioStationURL] currentSelectedRadioStationURL];
}

- (void)mockCurrentSelectedRadioStationURLString:(NSString *)currentSelectedRadioStationURLString {
	[[[self.mockedConfig stub] andReturn:currentSelectedRadioStationURLString] currentSelectedRadioStationURLString];
}

- (void)mockCurrentRadioStationSelected:(BOOL)currentRadioStationSelected {
	[[[self.mockedConfig stub] andReturnValue:OCMOCK_VALUE(currentRadioStationSelected)] currentRadioStationSelected];
}

- (void)mockCurrentAlarmDate:(NSDate *)currentAlarmDate {
	[[[self.mockedConfig stub] andReturn:currentAlarmDate] currentAlarmDate];
}

- (void)mockCurrentAlarmDateSelected:(BOOL)currentAlarmDateSelected {
	[[[self.mockedConfig stub] andReturnValue:OCMOCK_VALUE(currentAlarmDateSelected)] currentAlarmDateSelected];
}

- (void)mockPlayImmediately:(BOOL)playImmediately {
	[[[self.mockedConfig stub] andReturnValue:OCMOCK_VALUE(playImmediately)] shouldPlayImmediately];
}

- (void)mockCurrentSelectedSound:(Sound *)sound {
	[[[self.mockedConfig stub] andReturn:sound] currentSelectedSound];
}


@end
