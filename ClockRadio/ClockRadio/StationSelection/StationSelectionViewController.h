//
//  StationSelectionViewController.h
//  RadioStationSelection
//
//  Created by Andre Hess on 29.11.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StationSelectionViewController;
@class Station;
@class STKAudioPlayer;

@protocol StationSelectionDelegate <NSObject>

- (void)stationSelectionViewControllerDidCancel:(StationSelectionViewController *)controller;

- (void)stationSelectionViewController:(StationSelectionViewController *)controller didFinsishWithStation:(Station *)station;

@end

@interface StationSelectionViewController : UIViewController

@property (nonatomic, assign) id<StationSelectionDelegate> delegate;
@property (nonatomic, strong) STKAudioPlayer *audioPlayer;

@end
