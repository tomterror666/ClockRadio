//
//  Station.h
//  ClockRadio
//
//  Created by Andre Heß on 29/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

#define StationNameKey				@"name"
#define StationIdKey				@"id"
#define StationBitRateKey			@"br"
#define StationGenreKey				@"genre"
#define StationMediaTypeKey			@"mt"
#define StationsCurrentListnersKey 	@"lc"

@interface Station : NSObject

@property (nonatomic, copy, readonly) NSString *stationName;
@property (nonatomic, copy, readonly) NSString *stationId;
@property (nonatomic, assign, readonly) NSUInteger stationBitRate;
@property (nonatomic, copy, readonly) NSString *stationGenre;
@property (nonatomic, assign, readonly) NSUInteger stationsCurrentListners;
@property (nonatomic, copy, readonly) NSString *stationMediaType;

- (id)initWithDict:(NSDictionary *)dict;

@end
