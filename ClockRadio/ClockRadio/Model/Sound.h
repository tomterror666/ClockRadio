//
//  Sound.h
//  ClockRadio
//
//  Created by Andre Heß on 23/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sound : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong, readonly) NSString *soundName;
@property (nonatomic, strong, readonly) NSURL *soundURL;
@property (nonatomic, strong, readonly) NSData *soundData;

- (id)initWithURL:(NSURL *)url;

@end
