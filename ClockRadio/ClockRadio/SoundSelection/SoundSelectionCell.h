//
//  SoundSelectionCell.h
//  ClockRadio
//
//  Created by Andre Heß on 22/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Sound;

@interface SoundSelectionCell : UITableViewCell

- (void)updateWithSound:(Sound *)sound;

@end
