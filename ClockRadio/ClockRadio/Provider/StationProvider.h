//
//  StationProvider.h
//  ClockRadio
//
//  Created by Andre Heß on 29/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Station;

typedef void(^LoadingStationsCompletion)(id stations, NSError *error);

@interface StationProvider : NSObject

+ (id)sharedProvider;

- (void)loadStationsWithCompletion:(LoadingStationsCompletion)completion;

- (NSInteger)numberOfRadioStations;

- (Station *)radioStationAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)tuneinBase;

- (NSString *)tuneinBaseM3U;

- (NSString *)tuneinBaseXSPF;

@end
