//
//  Sound.m
//  ClockRadio
//
//  Created by Andre Heß on 23/08/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "Sound.h"

#define SoundNameKey @"SoundNameKey"
#define SoundURLKey @"SoundURLKey"
#define SoundDataKey @"SoundDataKey"

@interface Sound ()

@property (nonatomic, strong) NSString *soundName;
@property (nonatomic, strong) NSURL *soundURL;
@property (nonatomic, strong) NSData *soundData;

@end

@implementation Sound

- (id)initWithURL:(NSURL *)url {
	self = [super init];
	if (self != nil) {
		self.soundURL = url;
		[self configureSoundName];
		[self loadSoundData];
	}
	return self;
}

- (void)configureSoundName {
	NSString *soundPath = self.soundURL.path;
	self.soundName = [soundPath.lastPathComponent stringByReplacingOccurrencesOfString:soundPath.pathExtension withString:@""];
}

- (void)loadSoundData {
	self.soundData = [NSData dataWithContentsOfURL:self.soundURL];
}

#pragma mark -
#pragma mark NSCoding
#pragma mark -

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self != nil) {
		self.soundName = [aDecoder decodeObjectForKey:SoundNameKey];
		self.soundURL = [aDecoder decodeObjectForKey:SoundURLKey];
		self.soundData = [aDecoder decodeObjectForKey:SoundDataKey];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.soundName forKey:SoundNameKey];
	[aCoder encodeObject:self.soundURL forKey:SoundURLKey];
	[aCoder encodeObject:self.soundData forKey:SoundDataKey];
}

#pragma mark -
#pragma mark NSCopying
#pragma mark -

- (id)copyWithZone:(NSZone *)zone {
	Sound *newOne = [[Sound allocWithZone:zone] init];
	if (newOne != nil) {
		newOne.soundName = [self.soundName copyWithZone:zone];
		newOne.soundURL = [self.soundURL copyWithZone:zone];
		newOne.soundData = [self.soundData copyWithZone:zone];
	}
	return newOne;
}

@end
