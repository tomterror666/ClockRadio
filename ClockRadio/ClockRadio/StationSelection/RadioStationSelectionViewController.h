//
//  RadioStationSelectionViewController.h
//  ClockRadio
//
//  Created by Andre Heß on 18/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadioStationSelectionViewController;
@class Station;

static NSString *radioStationSelectionTableViewCellKey = @"com.tomterror.radioselection.tableviewcellkey";

@protocol RadioStationSelectionDelegate <NSObject>

//- (void)radioStationSelectionVC:(RadioStationSelectionViewController *)controller didFinishWithRadioStationURLString:(NSString *)radioStationURLString;
//- (void)radioStationSelectionVC:(RadioStationSelectionViewController *)controller didFinishWithRadioStationURL:(NSURL *)radioStationURL;
- (void)radioStationSelectionVC:(RadioStationSelectionViewController *)controller didFinishWithRadioStation:(Station *)station;

- (void)radioStationSelectionVCDidCancelSelecting:(RadioStationSelectionViewController *)controller;

@end

@interface RadioStationSelectionViewController : UIViewController

@property (nonatomic, assign) id<RadioStationSelectionDelegate> delegate;

@end
