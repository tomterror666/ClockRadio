//
//  StationTuneinDetails.m
//  ClockRadio
//
//  Created by Andre Heß on 02/07/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "StationTuneinDetails.h"

@interface StationTuneinDetails ()

@property (nonatomic, strong) NSMutableArray *fileURLStrings;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, assign) NSUInteger numberOfEntries;

@end

@implementation StationTuneinDetails

- (id)initWithDict:(NSDictionary *)dict {
	self = [super init];
	if (self != nil) {
		self.numberOfEntries = [[dict valueForKeyPath:@"playlist.numberofentries"] integerValue];
		self.titles = [NSMutableArray new];
		self.fileURLStrings = [NSMutableArray new];
		for (NSUInteger counter = 1; counter <= self.numberOfEntries; counter++) {
			NSString *fileURLKeyName = [NSString stringWithFormat:@"playlist.File%ld", (long)counter];
			NSString *titleKeyName = [NSString stringWithFormat:@"playlist.Title%ld", (long)counter];
			[self.fileURLStrings addObject:[dict valueForKeyPath:fileURLKeyName]];
			[self.titles addObject:[dict valueForKeyPath:titleKeyName]];
		}
	}
	return self;
}

@end
