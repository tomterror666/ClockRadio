//
//  StationCell.m
//  RadioStationSelection
//
//  Created by Andre Hess on 25.11.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "StationCell.h"
#import "Station.h"

@interface StationCell ()
@property (weak, nonatomic) IBOutlet UIView *stationContentView;
@property (weak, nonatomic) IBOutlet UILabel *stationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stationGenereLabel;
@property (weak, nonatomic) IBOutlet UILabel *stationListenersLabel;
@property (weak, nonatomic) IBOutlet UIView *stationLED;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewLeadingConstraint;
@property (nonatomic, assign) CGFloat constraintConstant;
@end

@implementation StationCell

+ (CGSize)expectedCellSize {
	return CGSizeMake(280, 30);
}

+ (CGFloat)cellsLED_X {
	return 8;
}

+ (CGFloat)cellsLED_Length {
	return 10;
}

- (void)awakeFromNib {
    [super awakeFromNib];
	[self configureSubviews];
	
//	self.layer.borderColor = [UIColor blackColor].CGColor;
//	self.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	if (animated) {
		[UIView animateWithDuration:.25 animations:^{
			[super setSelected:selected];
			self.stationLED.backgroundColor = selected ? [UIColor redColor] : [UIColor colorWithRed:.6 green:.3 blue:.3 alpha:1];
		}];
	} else {
		[super setSelected:selected];
		self.stationLED.backgroundColor = selected ? [UIColor redColor] : [UIColor colorWithRed:.6 green:.3 blue:.3 alpha:1];
	}
}

- (void)updateConstraints {
	self.contentViewLeadingConstraint.constant = self.constraintConstant;
	[super updateConstraints];
}

#pragma mark -
#pragma mark Properties
#pragma mark -

- (CGFloat)contentHeight {
	return self.stationContentView.bounds.size.height;
}

- (CGFloat)contentWidth {
	return self.stationContentView.bounds.size.width;
}

- (CGFloat)LED_X {
	return self.stationLED.frame.origin.x + self.constraintConstant;
}

- (CGFloat)LED_Length {
	return self.stationLED.bounds.size.width;
}


#pragma mark -
#pragma mark Configuration
#pragma mark -

- (void)configureSubviews {
	[self configureLabels];
}

- (void)configureLabels {
	self.stationNameLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:12];
	self.stationGenereLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:10];
	self.stationListenersLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:10];
	self.stationNameLabel.textColor = [UIColor blueColor];
	self.stationGenereLabel.textColor = [UIColor greenColor];
	self.stationListenersLabel.textColor = [UIColor orangeColor];
}

#pragma mark -
#pragma mark Updating
#pragma mark -

- (void)updateWithStation:(Station *)station atIndexPath:(NSIndexPath *)indexPath {
	self.stationNameLabel.text = [NSString stringWithFormat:@"%ld. - %@", (long)indexPath.row + 1, station.stationName];
	self.stationGenereLabel.text = station.stationGenre;
	self.stationListenersLabel.text = [@"Listeners: " stringByAppendingFormat:@"%ld", (long)station.stationsCurrentListners];
//	NSInteger newCellY = (int)trunc(indexPath.row * self.stationContentView.bounds.size.height) % (int)trunc(self.bounds.size.height - self.stationContentView.bounds.size.height);
//	self.stationContentView.frame = CGRectMake(self.stationContentView.frame.origin.x, newCellY, self.stationContentView.bounds.size.width, self.stationContentView.bounds.size.height);
	[self setSelected:NO animated:YES];
	if (indexPath.row == 0) {
		//self.contentViewLeadingConstraint.active = NO;
		//self.contentView.frame = CGRectMake(self.bounds.size.width - self.contentView.bounds.size.width, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
		//self.contentViewLeadingConstraint.constant = self.bounds.size.width - self.contentView.bounds.size.width;
		self.constraintConstant = self.bounds.size.width - [StationCell expectedCellSize].width;
	} else {
		self.constraintConstant = 0;
	}
	[self setNeedsUpdateConstraints];
	[self updateAccessibilityLabelsWithCellIndex:indexPath.row];
}

- (void)updateAccessibilityLabelsWithCellIndex:(NSInteger)index {
	self.accessibilityLabel = [NSString stringWithFormat:@"StationSelectionNameCell_%ld", (long)index];
	self.stationNameLabel.accessibilityLabel = [NSString stringWithFormat:@"StationSelectionNameLabel_%ld", (long)index];
	self.stationGenereLabel.accessibilityLabel = [NSString stringWithFormat:@"StationSelectionGenereLabel_%ld", (long)index];
	self.stationListenersLabel.accessibilityLabel = [NSString stringWithFormat:@"StationSelectionNumberOfListenersLabel_%ld", (long)index];
}

@end
