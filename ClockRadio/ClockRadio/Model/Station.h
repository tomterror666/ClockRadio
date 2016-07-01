//
//  Station.h
//  ClockRadio
//
//  Created by Andre Heß on 29/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject

@property (nonatomic, copy, readonly) NSString *stationName;
@property (nonatomic, copy, readonly) NSString *stationId;
@property (nonatomic, assign, readonly) NSUInteger stationBitRate;
@property (nonatomic, copy, readonly) NSString *stationGenre;
@property (nonatomic, assign, readonly) NSUInteger stationsCurrentListners;
@property (nonatomic, copy, readonly) NSString *stationMediaType;

- (id)initWithDict:(NSDictionary *)dict;

@end
