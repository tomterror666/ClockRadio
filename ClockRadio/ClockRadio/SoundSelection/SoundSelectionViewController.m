//
//  SoundSelectionViewController.m
//  ClockRadio
//
//  Created by Andre Heß on 22/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "SoundSelectionViewController.h"
#import "SoundSelectionCell.h"

@interface SoundSelectionViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) NSArray *soundFileNames;
@property (nonatomic, strong) NSArray *programmSoundFileNames;
@end

@implementation SoundSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self refreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Configuration
#pragma mark -

- (void)refreshView {
	[self configureTableView];
}

- (void)configureTableView {
	[self.tableView registerNib:[UINib nibWithNibName:@"SoundSelectionCell" bundle:nil] forCellReuseIdentifier:SoundSelectionCellIdentifier];
}

#pragma mark -
#pragma mark Button handling
#pragma mark -

- (IBAction)cancelButtonTouched:(id)sender {
	if ([self.delegate respondsToSelector:@selector(soundSelectionViewControllerDidCancel:)]) {
		[self.delegate soundSelectionViewControllerDidCancel:self];
	}
}

- (IBAction)doneButtonTouched:(id)sender {
	NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
	NSString *selectedSoundName = nil;
	if (selectedIndexPath.section == 0) {
		selectedSoundName = self.programmSoundFileNames[selectedIndexPath.row];
	} else {
		selectedIndexPath = self.soundFileNames[selectedIndexPath.row];
	}
	if ([self.delegate respondsToSelector:@selector(soundSelectionViewController:didFinishWithSoundName:)]) {
		[self.delegate soundSelectionViewController:self didFinishWithSoundName:selectedSoundName];
	}
}

#pragma mark -
#pragma mark  UITableViewDelegate and UITableViewDataSource implementation
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.soundFileNames count] > 0 ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return section == 0 ? [self.programmSoundFileNames count] : [self.soundFileNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	SoundSelectionCell *cell = (SoundSelectionCell *)[tableView dequeueReusableCellWithIdentifier:SoundSelectionCellIdentifier];
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	SoundSelectionCell *soundSelectionCell = (SoundSelectionCell *)cell;
	switch (indexPath.section) {
  		case 0:
			[soundSelectionCell updateWithSoundName:self.programmSoundFileNames[indexPath.row]];
			break;
		case 1:
			[soundSelectionCell updateWithSoundName:self.soundFileNames[indexPath.row]];
			break;
  		default:
			break;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50.;
}

@end
