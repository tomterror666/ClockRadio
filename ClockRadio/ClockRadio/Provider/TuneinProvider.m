//
//  TuneinProvider.m
//  ClockRadio
//
//  Created by Andre Heß on 02/07/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "TuneinProvider.h"
#import "ApiClient.h"
#import "StationTuneinDetails.h"
#import "OGIniFileSerialization.h"

@interface TuneinProvider ()

@property (nonatomic, strong) ApiClient *apiClient;
@property (nonatomic, strong) StationTuneinDetails *tuneinDetails;

@end

@implementation TuneinProvider

+ (id)sharedProvider {
	static TuneinProvider *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [TuneinProvider new];
	});
	return sharedInstance;
}

- (id)init {
	self = [super init];
	if (self != nil) {
		self.apiClient = [[ApiClient alloc] initWithBasePath:@"http://yp.shoutcast.com"];
	}
	return self;
}

- (void)loadTuneinDataWithStationId:(NSString *)stationId forTuneinBase:(NSString *)base withCompletion:(LoadTuneinDataCompletion)completion {
	__weak typeof(self) weakSelf = self;
	NSString *requestPath = [NSString stringWithFormat:@"%@?id=%@", base, stationId];
	[self.apiClient getDataForPath:requestPath
					withParameters:nil
					withCompletion:^(id responseObject, NSError *error) {
						if (error != nil) {
							if (completion != NULL) {
								completion(nil, error);
							}
						} else {
							NSError *parseError = nil;
							NSDictionary *tuneinDict = [OGIniFileSerialization iniFromData:responseObject
																				  encoding:NSUTF8StringEncoding
																				   options:OGIniFileReadingOptionMergeDuplicateProperties
																	   separatorCharacters:nil
																		 commentCharacters:nil
																		  escapeCharacters:nil
																					 error:&parseError];
							weakSelf.tuneinDetails = [[StationTuneinDetails alloc] initWithDict:tuneinDict];
							if (completion != NULL) {
								completion(weakSelf.tuneinDetails, nil);
							}
						}
					}];
}

@end
