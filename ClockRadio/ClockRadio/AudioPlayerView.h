//
//  AudioPlayerView.h
//  ClockRadio
//
//  Created by Andre Hess on 16.06.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StreamingKit/STKAudioPlayer.h>

@class AudioPlayerView;

@interface AudioPlayerView : UIView <STKAudioPlayerDelegate>

@property (nonatomic, readonly, strong) STKAudioPlayer* audioPlayer;

- (id)initWithFrame:(CGRect)frame withAudioPlayer:(STKAudioPlayer *)audioPlayer;

@end
