//
//  NavigationHelper.h
//  ClockRadio
//
//  Created by Andre Hess on 19.08.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MainViewController;

@interface NavigationHelper : NSObject

+ (id)sharedHelper;
+ (MainViewController *)mainController;
+ (UIViewController *)visiblePhoneViewController;
+ (void)popToMainViewControllerAnimated:(BOOL)animated;
+ (void)popToMainViewControllerAndPresentViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;
+ (void)popToMainViewControllerAndPresentViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
