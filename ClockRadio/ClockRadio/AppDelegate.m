//
//  AppDelegate.m
//  ClockRadio
//
//  Created by Andre Hess on 16.06.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "AppDelegate.h"
#import "NotificationHandler.h"
#import "Mocktail.h"
#import "ApiClient.h"
#import "ApiClientURLSessionConfiguration.h"

@interface AppDelegate ()
@property (nonatomic, strong) Mocktail *mocktail;
@end

@implementation AppDelegate

+ (AppDelegate *)sharedAppDelegate {
	return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	if ([[[NSProcessInfo processInfo].environment objectForKey:@"KIF_UI_TEST"] isEqualToString:@"1"]) {
		[self initMocktails];
	}
	UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
	if (localNotification != nil) {
		[NotificationHandler handleLocalNotification:localNotification];
	}
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
	[NotificationHandler handleLocalNotification:notification];
}

- (void)initMocktails {
	NSBundle *mainBundle = [NSBundle mainBundle];
	NSString *mocktailPath = [[mainBundle pathForResource:nil ofType:@"tail"] stringByDeletingLastPathComponent];
	ApiClientURLSessionConfiguration *sessionConfig = [ApiClientURLSessionConfiguration sharedConfiguration];
	self.mocktail = [Mocktail startWithContentsOfDirectoryAtURL:[NSURL fileURLWithPath:mocktailPath] configuration:sessionConfig];
	[[ApiClient apiClients] makeObjectsPerformSelector:@selector(updateSessionManagerWithSessionConfiguration:) withObject:sessionConfig];
}

@end
