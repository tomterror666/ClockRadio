//
//  RadioStationSelectonViewController.m
//  ClockRadio
//
//  Created by Andre Heß on 18/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "RadioStationSelectonViewController.h"
#import "StationProvider.h"

static NSString *radioStationSelectionTableViewCellKey = @"com.tomterror.radioselection.tableviewcellkey";

@interface RadioStationSelectonViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) StationProvider *stationProvider;

@end

@implementation RadioStationSelectonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self != nil) {
		self.stationProvider = [StationProvider sharedProvider];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self refreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark data handling and refreshing
#pragma mark -

- (void)refreshView {
	[self updateUI];
	__weak typeof(self) weakSelf = self;
	[self.stationProvider loadStationsWithCompletion:^(id stationsJson, NSError *error) {
		[weakSelf updateUI];
	}];
}

- (void)updateUI {
	[self.tableView reloadData];
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
	return [self.stationProvider numberOfRadioStations];
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
