//
//  Configuration.m
//  ClockRadio
//
//  Created by Andre Heß on 18/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "Configuration.h"

static NSString *currentSelectedRadioStationURLStringKey = @"com.tomterror.currentConfig.selectedRadioURLString";
static NSString *currentSelectedRadioStationURLKey = @"com.tomterror.currentConfig.selectedRadioURL";

@interface Configuration ()
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation Configuration


+ (Configuration *)currentConfiguration {
	static Configuration *sharedConfiguration = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedConfiguration = [Configuration new];
	});
	return sharedConfiguration;
}

- (id)init {
	self = [super init];
	if (self != nil) {
		[self readCurrentConfig];
	}
	return self;
}

- (void)readCurrentConfig {
	self.userDefaults = [NSUserDefaults standardUserDefaults];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"current configuration: %@", [self.userDefaults dictionaryRepresentation]];
}

#pragma mark -
#pragma mark Property handling
#pragma mark -


- (NSURL *)currentSelectedRadioStationURL {
	return [self.userDefaults objectForKey:currentSelectedRadioStationURLKey];
}

- (void)setCurrentSelectedRadioStationURL:(NSURL *)currentSelectedRadioStationURL {
	[self.userDefaults setURL:currentSelectedRadioStationURL forKey:currentSelectedRadioStationURLKey];
}

- (NSString *)currentSelectedRadioStationURLString {
	return [self.userDefaults objectForKey:currentSelectedRadioStationURLStringKey];
}

- (void)setCurrentSelectedRadioStationURLString:(NSString *)currentSelectedRadioStationURLString {
	[self.userDefaults setObject:currentSelectedRadioStationURLString forKey:currentSelectedRadioStationURLStringKey];
}

- (BOOL)currentRadioStationSelected {
	return ([self.currentSelectedRadioStationURLString length] > 0) || ([[self.currentSelectedRadioStationURL absoluteString] length] > 0);
}

@end
