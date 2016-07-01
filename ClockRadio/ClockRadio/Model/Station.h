//
//  Station.h
//  ClockRadio
//
//  Created by Andre Heß on 29/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject

@property (nonatomic, strong) NSString *stationName;
@property (nonatomic, strong) NSString *stationDescription;
@property (nonatomic, strong) NSURL *stationURL;
@property (nonatomic, strong) NSURL *stationImageURL;

@end
