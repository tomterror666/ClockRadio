//
//  NotificationHandler.h
//  ClockRadio
//
//  Created by Andre Heß on 14/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NotificationHandler : NSObject

+ (void)handleLocalNotification:(UILocalNotification *)localNotification;

@end
