//
//  RadioStationSelectionViewController.m
//  ClockRadio
//
//  Created by Andre Heß on 18/06/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "RadioStationSelectionViewController.h"
#import "StationProvider.h"
#import "Station.h"

@interface RadioStationSelectionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) StationProvider *stationProvider;

@end

@implementation RadioStationSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self != nil) {
		self.stationProvider = [StationProvider sharedProvider];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self configureAccessibilityLabels];
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

- (void)configureAccessibilityLabels {
	self.view.accessibilityLabel = @"RadioStationSelectionView";
	self.tableView.accessibilityLabel = @"RadioStationSelectionTableView";
	self.cancelButton.accessibilityLabel = @"CancelButton";
}

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
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:radioStationSelectionTableViewCellKey];
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	Station *station = [self.stationProvider radioStationAtIndexPath:indexPath];
	cell.accessibilityLabel = [NSString stringWithFormat:@"RadioStationSelectionNameCell_%ld", (long)indexPath.row];
	cell.textLabel.text = station.stationName;
	cell.textLabel.accessibilityLabel = [NSString stringWithFormat:@"RadioStationSelectionNameLabel_%ld", (long)indexPath.row];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Genre: %@ - Listeners: %ld", station.stationGenre, (long)station.stationsCurrentListners];
	cell.detailTextLabel.accessibilityLabel = [NSString stringWithFormat:@"RadioStationSelectionDetailsLabel_%ld", (long)indexPath.row]; 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	if ([self.delegate respondsToSelector:@selector(radioStationSelectionVC:didFinishWithRadioStationURLString:)]) {
//		[self.delegate radioStationSelectionVC:self didFinishWithRadioStationURLString:@"http://69.163.40.193:8000"];
//	}
	if ([self.delegate respondsToSelector:@selector(radioStationSelectionVC:didFinishWithRadioStation:)]) {
		Station *selectedStation = [self.stationProvider radioStationAtIndexPath:indexPath];
		[self.delegate radioStationSelectionVC:self didFinishWithRadioStation:selectedStation];
	}
}

@end
