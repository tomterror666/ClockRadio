//
//  AlarmSelectionViewController.m
//  ClockRadio
//
//  Created by Andre Heß on 02/07/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "AlarmSelectionViewController.h"
#import "NSDate+Utility.h"

@interface AlarmSelectionViewController ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIDatePicker *alarmSelector;
@property (nonatomic, weak) IBOutlet UIButton *doneButton;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;

@end

@implementation AlarmSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self configureAccessibilityLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Configuration
#pragma mark -

- (void)configureAccessibilityLabels {
	self.view.accessibilityLabel = @"AlarmSelectionView";
	self.alarmSelector.accessibilityLabel = @"AlarmSelectionPicker";
	self.doneButton.accessibilityLabel = @"DoneButton";
	self.cancelButton.accessibilityLabel = @"CancelButton";
}

#pragma mark -
#pragma mark button handling
#pragma mark -

- (IBAction)doneButtonTouched:(id)sender {
	if (self.alarmSelector.date != nil) {
		if ([self.delegate respondsToSelector:@selector(alarmSelectionVC:didFinishWithAlarmDate:)]) {
			[self.delegate alarmSelectionVC:self didFinishWithAlarmDate:[NSDate normalizeSecondsOfDate:self.alarmSelector.date]];
		}
	} else {
		if ([self.delegate respondsToSelector:@selector(alarmSelectonVCDidCancel:)]) {
			[self.delegate alarmSelectonVCDidCancel:self];
		}
	}
}

- (IBAction)cancelButtonTouched:(id)sender {
	if ([self.delegate respondsToSelector:@selector(alarmSelectonVCDidCancel:)]) {
		[self.delegate alarmSelectonVCDidCancel:self];
	}
}


@end
