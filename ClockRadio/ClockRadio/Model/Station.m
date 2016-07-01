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
		self.stationName = [dict objectForKey:@"name"];
		self.stationId = [dict objectForKey:@"id"];
		self.stationBitRate = [[dict objectForKey:@"br"] integerValue];
		self.stationGenre = [dict objectForKey:@"genre"];
		self.stationMediaType = [dict objectForKey:@"mt"];
		self.stationsCurrentListners = [[dict objectForKey:@"lc"] integerValue];
	}
	return self;
}

@end
