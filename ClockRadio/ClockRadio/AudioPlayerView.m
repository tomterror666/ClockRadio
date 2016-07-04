//
//  AudioPlayerView.m
//  ClockRadio
//
//  Created by Andre Hess on 16.06.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "AudioPlayerView.h"
#import "Configuration.h"

@interface AudioPlayerView ()
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) UISlider *volumeSlider;
@property (nonatomic, strong) UIButton *muteButton;
@property (nonatomic, strong) STKAudioPlayer* audioPlayer;
@end

@implementation AudioPlayerView

- (id)initWithFrame:(CGRect)frame withAudioPlayer:(STKAudioPlayer *)audioPlayer {
	self = [super initWithFrame:frame];
	if (self != nil) {
		self.audioPlayer = audioPlayer;
		self.audioPlayer.delegate = self;
		self.backgroundColor = [UIColor redColor];
		[self addPlayButton];
		[self addStopButton];
		[self addVolumeSlider];
		[self addMuteButton];
		[self updateUI];
	}
	return self;
}

- (void)addPlayButton {
	self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.playButton addTarget:self action:@selector(playButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
	[self.playButton setTitle:@"Play" forState:UIControlStateNormal];
	[self.playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[self.playButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	[self.playButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
	[self.playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
	[self addSubview:self.playButton];
}

- (void)addStopButton {
	self.stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.stopButton addTarget:self action:@selector(stopButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
	[self.stopButton setTitle:@"Stop" forState:UIControlStateNormal];
	[self.stopButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[self.stopButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	[self.stopButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
	[self.stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
	[self addSubview:self.stopButton];
}

- (void)addVolumeSlider {
	self.volumeSlider = [[UISlider alloc] initWithFrame:CGRectZero];
	self.volumeSlider.continuous = YES;
	self.volumeSlider.minimumTrackTintColor = [UIColor blueColor];
	[self.volumeSlider addTarget:self action:@selector(volumeSliderDidChanged:) forControlEvents:UIControlEventValueChanged];
	self.volumeSlider.value = self.audioPlayer.volume;
	[self addSubview:self.volumeSlider];
}

- (void)addMuteButton {
	self.muteButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.muteButton addTarget:self action:@selector(muteButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
	[self.muteButton setTitle:@"Mute" forState:UIControlStateNormal];
	[self.muteButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[self.muteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	[self.muteButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
	[self.muteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
	[self addSubview:self.muteButton];
}

#pragma mark -
#pragma mark Updating
#pragma mark -

- (void)updateUI {
	self.playButton.enabled = [Configuration currentConfiguration].currentRadioStationSelected && (self.audioPlayer.state != STKAudioPlayerStatePlaying);
	self.stopButton.enabled = [Configuration currentConfiguration].currentRadioStationSelected && (self.audioPlayer.state == STKAudioPlayerStatePlaying);
}

#pragma mark -
#pragma mark Layouting
#pragma mark -

- (void)layoutSubviews {
	[self layoutPlayButton];
	[self layoutStopButton];
	[self layoutVolumeSlider];
	[self layoutMuteButton];
}

- (void)layoutPlayButton {
	self.playButton.frame = CGRectMake(0, 0, 100., 40.);
	self.playButton.center = CGPointMake(self.bounds.size.width / 2 - self.playButton.bounds.size.width / 2 - 8, self.playButton.bounds.size.height / 2 + 8);
}

- (void)layoutStopButton {
	self.stopButton.frame = CGRectMake(0, 0, 100., 40.);
	self.stopButton.center = CGPointMake(self.bounds.size.width / 2 + self.stopButton.bounds.size.width / 2 + 8, self.stopButton.bounds.size.height / 2 + 8);
}

- (void)layoutMuteButton {
	self.muteButton.frame = CGRectMake(0, 0, 100., 40.);
	self.muteButton.center = CGPointMake(self.bounds.size.width / 2, self.volumeSlider.frame.origin.y + self.volumeSlider.bounds.size.height + 8);
}

- (void)layoutVolumeSlider {
	self.volumeSlider.frame = CGRectMake(self.playButton.frame.origin.x, self.playButton.frame.origin.y + self.playButton.bounds.size.height + 10, self.stopButton.frame.origin.x + self.stopButton.bounds.size.width - self.playButton.frame.origin.x, 31);
}

#pragma mark -
#pragma mark Button handling
#pragma mark -

- (void)playButtonTouched:(id)sender {
	NSLog(@"play button touched!");
	
	NSURL *url = [Configuration currentConfiguration].currentSelectedRadioStationURL;
	if (url == nil) {
		url = [NSURL URLWithString:[Configuration currentConfiguration].currentSelectedRadioStationURLString];
	}
	
	STKDataSource* dataSource = [STKAudioPlayer dataSourceFromURL:url];
	[self.audioPlayer queueDataSource:dataSource withQueueItemId:@0];
}

- (void)stopButtonTouched:(id)sender {
	NSLog(@"stop button touched!");
	[self.audioPlayer stop];
}

- (void)muteButtonTouched:(id)sender {
	NSLog(@"stop button touched!");
	self.audioPlayer.volume = 0;
	[self.audioPlayer mute];
}

- (void)volumeSliderDidChanged:(id)sender {
	self.audioPlayer.volume = self.volumeSlider.value;
}

#pragma mark -
#pragma mark STKAudioPlayerDelegate
#pragma mark -

/// Raised when an item has started playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId {
	
}

/// Raised when an item has finished buffering (may or may not be the currently playing item)
/// This event may be raised multiple times for the same item if seek is invoked on the player
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId {
	
}

/// Raised when the state of the player has changed
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState {
	[self updateUI];
}

/// Raised when an item has finished playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration {
	
}

/// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode {
	
}


@end
