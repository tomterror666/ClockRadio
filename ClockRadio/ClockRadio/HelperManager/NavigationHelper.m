//
//  NavigationHelper.m
//  ClockRadio
//
//  Created by Andre Hess on 19.08.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "NavigationHelper.h"
#import "AppDelegate.h"
#import "MainViewController.h"

@implementation NavigationHelper

+ (id)sharedHelper {
	static NavigationHelper *_sharedHelper = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedHelper = [self new];
	});
	
	return _sharedHelper;
}

+ (MainViewController *)mainController {
	return (MainViewController *)[AppDelegate sharedAppDelegate].window.rootViewController;
}

+ (UIViewController *)visiblePhoneViewController {
	MainViewController *mainVC = [NavigationHelper mainController];
	UIViewController *resultVC = mainVC;
	while (resultVC.presentedViewController != nil) {
		resultVC = resultVC.presentedViewController;
	}
	return resultVC;
}


+ (void)popToMainViewControllerAnimated:(BOOL)animated {
	__block UIViewController *currentVC = [NavigationHelper visiblePhoneViewController];
	while (![currentVC isKindOfClass:[MainViewController class]]) {
		[currentVC dismissViewControllerAnimated:animated completion:NULL];
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeInterval:0.5 sinceDate:[NSDate date]]];
		currentVC = [NavigationHelper visiblePhoneViewController];
	}
}

+ (void)popToMainViewControllerAndPresentViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
	MainViewController *mainVC = [NavigationHelper mainController];
	UIViewController *presentedVC = [NavigationHelper visiblePhoneViewController];
	while (![presentedVC.presentingViewController isKindOfClass:[MainViewController class]]) {
		[presentedVC dismissViewControllerAnimated:animated completion:NULL];
	}
	__block UIViewController *blockPresentedVC = mainVC;
	[presentedVC dismissViewControllerAnimated:animated completion:^{
		for (UIViewController *controllerToPresent in viewControllers) {
			[blockPresentedVC presentViewController:controllerToPresent animated:animated completion:NULL];
			[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeInterval:0.5 sinceDate:[NSDate date]]];
			blockPresentedVC = blockPresentedVC.presentedViewController;
		}
	}];
}

+ (void)popToMainViewControllerAndPresentViewController:(UIViewController *)viewController animated:(BOOL)animated {
	MainViewController *mainVC = [NavigationHelper mainController];
	UIViewController *presentedVC = [NavigationHelper visiblePhoneViewController];
	while (![presentedVC.presentingViewController isKindOfClass:[MainViewController class]]) {
		[presentedVC dismissViewControllerAnimated:animated completion:NULL];
	}
	[presentedVC dismissViewControllerAnimated:animated completion:^{
		[mainVC presentViewController:viewController animated:animated completion:NULL];
	}];
}

@end
