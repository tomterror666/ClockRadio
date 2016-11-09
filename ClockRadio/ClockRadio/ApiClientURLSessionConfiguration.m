//
//  ApiClientURLSessionConfiguration.m
//  ClockRadio
//
//  Created by Andre Heß on 09/11/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "ApiClientURLSessionConfiguration.h"

static ApiClientURLSessionConfiguration *sharedURLSessionConfiguration = nil;

@implementation ApiClientURLSessionConfiguration

+ (id)sharedConfiguration {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedURLSessionConfiguration = (ApiClientURLSessionConfiguration *)[NSURLSessionConfiguration defaultSessionConfiguration];
	});
	return sharedURLSessionConfiguration;
}

@end
