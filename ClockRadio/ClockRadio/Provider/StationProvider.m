//
//  StationProvider.m
//  ClockRadio
//
//  Created by Andre Heß on 29/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "StationProvider.h"
#import "ApiClient.h"
#import "Station.h"

@interface StationProvider ()

@property (nonatomic, strong) ApiClient *apiClient;

@end

@implementation StationProvider

+ (id)sharedProvider {
	static StationProvider *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [StationProvider new];
	});
	return sharedInstance;
}

- (id)init {
	self = [super init];
	if (self != nil) {
		self.apiClient = [ApiClient new];
	}
	return self;
}

#pragma mark -
#pragma mark station loading and data providing
#pragma mark -

- (void)loadStationsWithCompletion:(LoadingStationsCompletion)completion {
	[self.apiClient getDataForPath:@"Top500"
					withParameters:nil
					withCompletion:^(id responseObject, NSError *error) {
						NSError *erro = nil;
						NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject
																					 options:NSJSONReadingAllowFragments
																					   error:&error];
						NSLog(responseObject);
					}];
}

- (NSInteger)numberOfRadioStations {
	return 1;
}

- (Station *)radioStationAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

@end
