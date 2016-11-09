//
//  ApiClientURLSessionConfiguration.h
//  ClockRadio
//
//  Created by Andre Heß on 09/11/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiClientURLSessionConfiguration : NSURLSessionConfiguration

+ (id)sharedConfiguration;

@end
