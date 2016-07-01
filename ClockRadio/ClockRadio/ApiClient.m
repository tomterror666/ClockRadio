//
//  ApiClient.m
//  ClockRadio
//
//  Created by Andre Heß on 29/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "ApiClient.h"
#import "AFNetworking.h"

static NSString *shoutCastAPIKey = @"shoutcastapikey";

@interface ApiClient ()

@property (nonatomic, copy) NSString *basePath;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation ApiClient

- (id)init {
	self = [super init];
	if (self != nil) {
		self.basePath = @"http://api.shoutcast.com/legacy/";
		self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.basePath]
												sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
		self.manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
		self.manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
	}
	return self;
}

- (void)getDataForPath:(NSString *)path withParameters:(NSDictionary *)params withCompletion:(RequestCompletion)completion {
	[self.manager GET:[self buildRequestPathWithPath:path]
		   parameters:params
			 progress:NULL
			  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
				  if (completion != NULL) {
					  completion(responseObject, nil);
				  }
			  }
			  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
				  if (completion != NULL) {
					  completion(nil, error);
				  }
			  }];
}


#pragma mark -
#pragma mark helper methods
#pragma mark -

- (NSString *)buildRequestPathWithPath:(NSString *)path {
	NSString *resultPath = nil;
	if ([path rangeOfString:@"?"].location != NSNotFound) {
		resultPath = [path stringByAppendingFormat:@"&f=json&k=%@", shoutCastAPIKey];
	} else if ([path hasPrefix:@"/"]) {
		resultPath = [[path substringToIndex:[path length] - 1] stringByAppendingFormat:@"?f=json&k=%@", shoutCastAPIKey];
	} else {
		resultPath = [path stringByAppendingFormat:@"?f=json&k=%@", shoutCastAPIKey];
	}
	return resultPath;
}

@end
