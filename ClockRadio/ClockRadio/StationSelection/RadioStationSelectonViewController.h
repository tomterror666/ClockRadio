//
//  RadioStationSelectonViewController.h
//  ClockRadio
//
//  Created by Andre Heß on 18/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadioStationSelectonViewController;
@class Station;

static NSString *radioStationSelectionTableViewCellKey = @"com.tomterror.radioselection.tableviewcellkey";

@protocol RadioStationSelectionDelegate <NSObject>

//- (void)radioStationSelectionVC:(RadioStationSelectonViewController *)controller didFinishWithRadioStationURLString:(NSString *)radioStationURLString;
//- (void)radioStationSelectionVC:(RadioStationSelectonViewController *)controller didFinishWithRadioStationURL:(NSURL *)radioStationURL;
- (void)radioStationSelectionVC:(RadioStationSelectonViewController *)controller didFinishWithRadioStation:(Station *)station;

- (void)radioStationSelectionVCDidCancelSelecting:(RadioStationSelectonViewController *)controller;

@end

@interface RadioStationSelectonViewController : UIViewController

@property (nonatomic, assign) id<RadioStationSelectionDelegate> delegate;

@end
