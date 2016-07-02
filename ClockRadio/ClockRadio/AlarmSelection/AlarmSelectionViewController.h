//
//  AlarmSelectionViewController.h
//  ClockRadio
//
//  Created by Andre Heß on 02/07/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlarmSelectionViewController;

@protocol AlarmSelectionDelegate <NSObject>

- (void)alarmSelectionVC:(AlarmSelectionViewController *)controller didFinishWithAlarmDate:(NSDate *)date;

- (void)alarmSelectonVCDidCancel:(AlarmSelectionViewController *)controller;

@end

@interface AlarmSelectionViewController : UIViewController

@property (nonatomic, assign) id<AlarmSelectionDelegate> delegate;

@end
