//
//  NotificationHandler.m
//  ClockRadio
//
//  Created by Andre Heß on 14/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "NotificationHandler.h"
#import "Configuration.h"

@implementation NotificationHandler

+ (void)handleLocalNotification:(UILocalNotification *)localNotification {
	localNotification.applicationIconBadgeNumber = 0;
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
	[Configuration currentConfiguration].playImmediately = YES;
}

@end
