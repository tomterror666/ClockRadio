//
//  SoundSelectionCell.m
//  ClockRadio
//
//  Created by Andre Heß on 22/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "SoundSelectionCell.h"

@interface SoundSelectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *soundNameLabel;
@end

@implementation SoundSelectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

	self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

- (void)updateWithSoundName:(NSString *)soundName {
	self.soundNameLabel.text = soundName;
}

@end
