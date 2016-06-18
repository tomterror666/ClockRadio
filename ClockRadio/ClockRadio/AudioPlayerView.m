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
@property (nonatomic, strong) STKAudioPlayer* audioPlayer;
@end

@implementation AudioPlayerView

- (id)initWithFrame:(CGRect)frame withAudioPlayer:(STKAudioPlayer *)audioPlayer {
	self = [super initWithFrame:frame];
	if (self != nil) {
		self.audioPlayer = audioPlayer;
		self.backgroundColor = [UIColor redColor];
		[self addPlayButton];
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
	self.playButton.enabled = [Configuration currentConfiguration].currentRadioStationSelected;
	[self addSubview:self.playButton];
}

- (void)layoutSubviews {
	self.playButton.frame = CGRectMake(0, 0, 100., 40.);
	self.playButton.center = CGPointMake(self.bounds.size.width / 2, self.playButton.bounds.size.height / 2 + 8); 
}

#pragma mark -
#pragma mark Button handling
#pragma mark -

- (void)playButtonTouched:(id)sender {
	NSLog(@"play button touched!");
	
//	NSURL *url = [NSURL URLWithString:@""];
	NSURL *url = [Configuration currentConfiguration].currentSelectedRadioStationURL;
	if (url == nil) {
		url = [NSURL URLWithString:[Configuration currentConfiguration].currentSelectedRadioStationURLString];
	}
	
	STKDataSource* dataSource = [STKAudioPlayer dataSourceFromURL:url];
	[self.audioPlayer queueDataSource:dataSource withQueueItemId:@0];
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
	
}

/// Raised when an item has finished playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration {
	
}

/// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode {
	
}


@end
