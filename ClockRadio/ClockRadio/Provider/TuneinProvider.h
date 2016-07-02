//
//  TuneinProvider.h
//  ClockRadio
//
//  Created by Andre Heß on 02/07/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StationTuneinDetails;
typedef void(^LoadTuneinDataCompletion)(StationTuneinDetails *tuneinData, NSError *error);

@interface TuneinProvider : NSObject

@property (nonatomic, strong, readonly) StationTuneinDetails *tuneinDetails;

+ (id)sharedProvider;

- (void)loadTuneinDataWithStationId:(NSString *)stationId forTuneinBase:(NSString *)base withCompletion:(LoadTuneinDataCompletion)completion;

@end
