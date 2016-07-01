//
//  StationProvider.h
//  ClockRadio
//
//  Created by Andre Heß on 29/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Station;

typedef void(^LoadingStationsCompletion)(id stationsJson, NSError *error);

@interface StationProvider : NSObject

+ (id)sharedProvider;

- (void)loadStationsWithCompletion:(LoadingStationsCompletion)completion;

- (NSInteger)numberOfRadioStations;

- (Station *)radioStationAtIndexPath:(NSIndexPath *)indexPath;

@end
