//
//  ViewController.m
//  ClockRadio
//
//  Created by Andre Hess on 16.06.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "MainViewController.h"
#import "AudioPlayerView.h"
#import "RadioStationSelectonViewController.h"
#import "Configuration.h"

@interface MainViewController () <RadioStationSelectionDelegate>
@property (nonatomic, weak) IBOutlet UILabel *radioSelectionLabel;
@property (nonatomic, weak) IBOutlet UILabel *radioSelectionValueLabel;
@property (nonatomic, weak) IBOutlet UIButton *radioSelectionButton;
@property (nonatomic, strong) STKAudioPlayer *audioPlayer;
@property (nonatomic, strong) AudioPlayerView *audioPlayerView;
@end

@implementation MainViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self refreshView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
}

- (void)refreshView {
	[self addPlayerView];
	self.radioSelectionValueLabel.text = [Configuration currentConfiguration].currentSelectedRadioStationURLString;
}

- (void)addPlayerView {
	self.audioPlayer = [[STKAudioPlayer alloc] initWithOptions:(STKAudioPlayerOptions){ .flushQueueOnSeek = YES, .enableVolumeMixer = NO, .equalizerBandFrequencies = {50, 100, 200, 400, 800, 1600, 2600, 16000} }];
	self.audioPlayer.meteringEnabled = YES;
	self.audioPlayer.volume = 1;
	
	[self.audioPlayerView removeFromSuperview];
	self.audioPlayerView = [[AudioPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2) withAudioPlayer:self.audioPlayer];
	//audioPlayerView.delegate = self;
	
	[self.view addSubview:self.audioPlayerView];
}

- (void)viewDidLayoutSubviews {
	self.audioPlayerView.frame = CGRectMake(8, self.view.bounds.size.height / 2, self.view.bounds.size.width - 16, (self.view.bounds.size.height - 16) / 2);
}

#pragma mark -
#pragma mark Button handling
#pragma mark -

- (IBAction)radioSelectionButtonTouched:(id)sender {
	RadioStationSelectonViewController *controller = [[RadioStationSelectonViewController alloc] initWithNibName:@"RadioStationSelectonViewController" bundle:nil];
	controller.delegate = self;
	[self presentViewController:controller animated:YES completion:NULL];
}

#pragma mark -
#pragma mark RadioStationSelectionDelegate
#pragma mark -

- (void)radioStationSelectionVCDidCancelSelecting:(RadioStationSelectonViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)radioStationSelectionVC:(RadioStationSelectonViewController *)controller didFinishWithRadioStationURLString:(NSString *)radioStationURLString {
	[Configuration currentConfiguration].currentSelectedRadioStationURLString = radioStationURLString;
	[self dismissViewControllerAnimated:YES completion:NULL];
	[self refreshView];
}

- (void)radioStationSelectionVC:(RadioStationSelectonViewController *)controller didFinishWithRadioStationURL:(NSURL *)radioStationURL {
	[Configuration currentConfiguration].currentSelectedRadioStationURL = radioStationURL;
	[self dismissViewControllerAnimated:YES completion:NULL];
	[self refreshView];
}

@end
