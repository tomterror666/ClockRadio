//
//  Configuration+UITest.m
//  ClockRadio
//
//  Created by Andre Hess on 11.11.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "Configuration+UITest.h"

extern Configuration *sharedConfiguration;
extern dispatch_once_t onceToken;

@implementation Configuration (UITest)

- (void)finish {
	sharedConfiguration = nil;
	onceToken = 0;
}

@end
