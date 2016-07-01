//
//  ApiClient.h
//  ClockRadio
//
//  Created by Andre Heß on 29/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestCompletion)(id responseObject, NSError *error);

@interface ApiClient : NSObject

- (void)getDataForPath:(NSString *)path withParameters:(NSDictionary *)params withCompletion:(RequestCompletion)completion;

@end
