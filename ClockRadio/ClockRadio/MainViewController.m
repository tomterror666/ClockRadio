//
//  ViewController.m
//  ClockRadio
//
//  Created by Andre Hess on 16.06.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "MainViewController.h"
#import "AudioPlayerView.h"

@interface MainViewController ()
@property (nonatomic, strong) STKAudioPlayer *audioPlayer;
@property (nonatomic, strong) AudioPlayerView *audioPlayerView;
@end

@implementation MainViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self addPlayerView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
}

- (void)addPlayerView {
	self.audioPlayer = [[STKAudioPlayer alloc] initWithOptions:(STKAudioPlayerOptions){ .flushQueueOnSeek = YES, .enableVolumeMixer = NO, .equalizerBandFrequencies = {50, 100, 200, 400, 800, 1600, 2600, 16000} }];
	self.audioPlayer.meteringEnabled = YES;
	self.audioPlayer.volume = 1;
	
	self.audioPlayerView = [[AudioPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2) withAudioPlayer:self.audioPlayer];
	//audioPlayerView.delegate = self;
	
	[self.view addSubview:self.audioPlayerView];
}

- (void)viewDidLayoutSubviews {
	self.audioPlayerView.frame = CGRectMake(8, self.view.bounds.size.height / 2, self.view.bounds.size.width - 16, (self.view.bounds.size.height - 16) / 2);
}

@end
