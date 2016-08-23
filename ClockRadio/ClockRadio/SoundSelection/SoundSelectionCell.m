//
//  SoundSelectionCell.m
//  ClockRadio
//
//  Created by Andre Heß on 22/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "SoundSelectionCell.h"
#import "Sound.h"

@interface SoundSelectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *soundNameLabel;
@end

@implementation SoundSelectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

	self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

- (void)updateWithSound:(Sound *)sound {
	self.soundNameLabel.text = sound.soundName;
}

@end
