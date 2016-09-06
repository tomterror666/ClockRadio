//
//  AppDelegate.h
//  ClockRadio
//
//  Created by Andre Hess on 16.06.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+ (AppDelegate *)sharedAppDelegate;

@property (strong, nonatomic) UIWindow *window;

@end

