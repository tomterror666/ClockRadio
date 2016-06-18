//
//  RadioStationSelectonViewController.m
//  ClockRadio
//
//  Created by Andre Heß on 18/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "RadioStationSelectonViewController.h"

static NSString *radioStationSelectionTableViewCellKey = @"com.tomterror.radioselection.tableviewcellkey";

@interface RadioStationSelectonViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;

@end

@implementation RadioStationSelectonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Button handling
#pragma mark -

- (IBAction)cancelButtonTouched:(id)sender {
	if ([self.delegate respondsToSelector:@selector(radioStationSelectionVCDidCancelSelecting:)]) {
		[self.delegate radioStationSelectionVCDidCancelSelecting:self];
	}
}

#pragma mark -
#pragma mark UITableViewDelegate and UITableViewDataSource
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:radioStationSelectionTableViewCellKey];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:radioStationSelectionTableViewCellKey];
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	cell.textLabel.text = @"Radio Wazee";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([self.delegate respondsToSelector:@selector(radioStationSelectionVC:didFinishWithRadioStationURLString:)]) {
		[self.delegate radioStationSelectionVC:self didFinishWithRadioStationURLString:@"http://69.163.40.193:8000"];
	}
}

@end
