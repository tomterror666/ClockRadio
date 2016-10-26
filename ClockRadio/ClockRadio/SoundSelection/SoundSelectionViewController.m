//
//  SoundSelectionViewController.m
//  ClockRadio
//
//  Created by Andre Heß on 22/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "SoundSelectionViewController.h"
#import "SoundSelectionCell.h"
#import "Sound.h"

@interface SoundSelectionViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) NSMutableArray *soundFiles;
@property (nonatomic, strong) NSMutableArray *programmSoundFiles;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation SoundSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self refreshView];
	[self configureAccessibilityLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Configuration
#pragma mark -

- (void)refreshView {
	[self configureTableView];
	[self loadProgrammSounds];
}

- (void)configureTableView {
	[self.tableView registerNib:[UINib nibWithNibName:@"SoundSelectionCell" bundle:nil] forCellReuseIdentifier:SoundSelectionCellIdentifier];
}

- (void)loadProgrammSounds {
	self.programmSoundFiles = [NSMutableArray new];
	NSArray<NSURL *> *soundUrls = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"mp3" subdirectory:nil];
	for (NSURL *soundURL in soundUrls) {
		Sound *sound = [[Sound alloc] initWithURL:soundURL];
		[self.programmSoundFiles addObject:sound];
	}
}

- (void)configureAccessibilityLabels {
	self.view.accessibilityLabel = @"SoundSelectionView";
	self.tableView.accessibilityLabel = @"SoundSelectionTableView";
	self.cancelButton.accessibilityLabel = @"CancelButton";
	self.doneButton.accessibilityLabel = @"DoneButton";
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
	Sound *selectedSound = nil;
	if (selectedIndexPath.section == 0) {
		selectedSound = self.programmSoundFiles[selectedIndexPath.row];
	} else {
		selectedSound = self.soundFiles[selectedIndexPath.row];
	}
	if ([self.delegate respondsToSelector:@selector(soundSelectionViewController:didFinishWithSound:)]) {
		[self.delegate soundSelectionViewController:self didFinishWithSound:selectedSound];
	}
}

#pragma mark -
#pragma mark  UITableViewDelegate and UITableViewDataSource implementation
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.soundFiles count] > 0 ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return section == 0 ? [self.programmSoundFiles count] : [self.soundFiles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	SoundSelectionCell *cell = (SoundSelectionCell *)[tableView dequeueReusableCellWithIdentifier:SoundSelectionCellIdentifier];
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	SoundSelectionCell *soundSelectionCell = (SoundSelectionCell *)cell;
	switch (indexPath.section) {
  		case 0:
			[soundSelectionCell updateWithSound:self.programmSoundFiles[indexPath.row]];
			break;
		case 1:
			[soundSelectionCell updateWithSound:self.soundFiles[indexPath.row]];
			break;
  		default:
			break;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Sound *sound = indexPath.section == 0 ? self.programmSoundFiles[indexPath.row] : self.soundFiles[indexPath.row];
	[self playSoundWithURL:sound.soundURL];
}

#pragma mark -
#pragma mark Play selected sound
#pragma mark -

- (void)playSoundWithURL:(NSURL *)url {
	if (self.audioPlayer.playing) {
		[self.audioPlayer stop];
		return;
	}
	self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: url error: nil];
	[self.audioPlayer prepareToPlay];
	[self.audioPlayer play];
}

@end
