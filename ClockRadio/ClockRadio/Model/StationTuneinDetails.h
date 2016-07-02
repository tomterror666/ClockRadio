//
//  StationTuneinDetails.h
//  ClockRadio
//
//  Created by Andre Heß on 02/07/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StationTuneinDetails : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *fileURLStrings;
@property (nonatomic, strong, readonly) NSMutableArray *titles;
@property (nonatomic, assign, readonly) NSUInteger numberOfEntries;

- (id)initWithDict:(NSDictionary *)dict;

@end
