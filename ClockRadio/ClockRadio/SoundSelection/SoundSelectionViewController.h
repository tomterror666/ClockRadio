//
//  SoundSelectionViewController.h
//  ClockRadio
//
//  Created by Andre Heß on 22/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SoundSelectionCellIdentifier @"com.tomterror.soundselection.tableviewcellkey"
@class Sound;

@class SoundSelectionViewController;

@protocol SoundSelectionDelegate <NSObject>

- (void)soundSelectionViewControllerDidCancel:(SoundSelectionViewController *)controller;

- (void)soundSelectionViewController:(SoundSelectionViewController *)controller didFinishWithSound:(Sound *)sound;

@end

@interface SoundSelectionViewController : UIViewController

@property (nonatomic, assign) id<SoundSelectionDelegate> delegate;

@end
