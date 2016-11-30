//
//  Station.m
//  ClockRadio
//
//  Created by Andre Heß on 29/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "Station.h"

@interface Station ()

@property (nonatomic, copy) NSString *stationName;
@property (nonatomic, copy) NSString *stationId;
@property (nonatomic, assign) NSUInteger stationBitRate;
@property (nonatomic, copy) NSString *stationGenre;
@property (nonatomic, assign) NSUInteger stationsCurrentListners;
@property (nonatomic, copy) NSString *stationMediaType;

@end


@implementation Station

- (id)initWithDict:(NSDictionary *)dict {
	self = [super init];
	if (self != nil) {
		self.stationName = [dict objectForKey:StationNameKey];
		self.stationId = [dict objectForKey:StationIdKey];
		self.stationBitRate = [[dict objectForKey:StationBitRateKey] integerValue];
		self.stationGenre = [dict objectForKey:StationGenreKey];
		self.stationMediaType = [dict objectForKey:StationMediaTypeKey];
		self.stationsCurrentListners = [[dict objectForKey:StationsCurrentListnersKey] integerValue];
	}
	return self;
}

- (BOOL)isEqual:(id)object {
	if (![object isKindOfClass:[Station class]]) {
		return NO;
	}
	Station *other = (Station *)object;
	return [other.stationId isEqualToString:self.stationId];
}

@end
