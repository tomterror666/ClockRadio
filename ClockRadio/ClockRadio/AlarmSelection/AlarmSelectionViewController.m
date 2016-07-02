//
//  AlarmSelectionViewController.m
//  ClockRadio
//
//  Created by Andre Heß on 02/07/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "AlarmSelectionViewController.h"

@interface AlarmSelectionViewController ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIDatePicker *alarmSelector;
@property (nonatomic, weak) IBOutlet UIButton *doneButton;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;

@end

@implementation AlarmSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark button handling
#pragma mark -

- (IBAction)doneButtonTouched:(id)sender {
	if (self.alarmSelector.date != nil) {
		if ([self.delegate respondsToSelector:@selector(alarmSelectionVC:didFinishWithAlarmDate:)]) {
			[self.delegate alarmSelectionVC:self didFinishWithAlarmDate:self.alarmSelector.date];
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
