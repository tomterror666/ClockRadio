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
#import "XMLReader.h"

@interface StationProvider ()

@property (nonatomic, strong) ApiClient *apiClient;
@property (nonatomic, copy) NSString *tuneInBase;
@property (nonatomic, copy) NSString *tuneInBaseM3U;
@property (nonatomic, copy) NSString *tuneInBaseXSPF;
@property (nonatomic, strong) NSMutableArray *stations;

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
		self.apiClient = [[ApiClient alloc] initWithBasePath:StationProviderBasePath];
	}
	return self;
}

#pragma mark -
#pragma mark station loading and data providing
#pragma mark -

- (void)loadStationsWithCompletion:(LoadingStationsCompletion)completion {
	__weak typeof(self) weakSelf = self;
	[self.apiClient getDataForPath:@"Top500"
					withParameters:nil
					withCompletion:^(id responseObject, NSError *error) {
						if (error != nil) {
							if (completion != NULL) {
								completion(nil, error);
							}
						} else {
							NSError *parseError = nil;
							NSDictionary *dict = [XMLReader dictionaryForXMLData:responseObject
																		 options:XMLReaderOptionsProcessNamespaces
																		   error:&parseError];
							[weakSelf handelResponseDict:dict withCompletion:completion];
						}
					}];
}

- (void)handelResponseDict:(NSDictionary *)responseDict withCompletion:(LoadingStationsCompletion)completion {
	self.stations = [NSMutableArray new];
	self.tuneInBase = [responseDict valueForKeyPath:@"stationlist.tunein.base"];
	self.tuneInBaseM3U = [responseDict valueForKeyPath:@"stationlist.tunein.base-m3u"];
	self.tuneInBaseXSPF = [responseDict valueForKeyPath:@"stationlist.tunein.base-xspf"];
	NSArray *stationList = [responseDict valueForKeyPath:@"stationlist.station"];
	for (NSDictionary *stationDict in stationList) {
		Station *station = [[Station alloc] initWithDict:stationDict];
		[self.stations addObject:station];
	}
	if (completion != NULL) {
		completion(self.stations, nil);
	}
}

- (NSInteger)numberOfRadioStations {
	return [self.stations count];
}

- (Station *)radioStationAtIndexPath:(NSIndexPath *)indexPath {
	return [self.stations objectAtIndex:indexPath.row];
}


- (NSString *)tuneinBase {
	return self.tuneInBase;
}

- (NSString *)tuneinBaseM3U {
	return self.tuneInBaseM3U;
}

- (NSString *)tuneinBaseXSPF {
	return self.tuneInBaseXSPF;
}

- (void)getStationTuneinDataWithStationId:(NSString *)stationId {
	
}

- (void)getStationTuneinM3UDataWithStationId:(NSString *)stationId {
	
}

- (void)getStationTuneinXSPFDataWithStationId:(NSString *)stationId {
	
}

@end
