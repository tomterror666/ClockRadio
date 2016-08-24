
#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "Sound.h"

@interface SoundTest : XCTestCase {
	Sound *sound;
	id soundMock;
}

@end

@interface Sound (Testing)
- (void)configureSoundName;
- (void)loadSoundData;
@end

@implementation SoundTest

- (void)setUp {
	[super setUp];
	sound = [Sound alloc];
	soundMock = [OCMockObject partialMockForObject:sound];
}

- (void)tearDown {
	[soundMock stopMocking];
	[super tearDown];
}

#pragma mark -
#pragma mark real test methods
#pragma mark -

- (void)testInitSoundCorrectly {
	NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"Rooster" withExtension:@"mp3"];
	sound = [sound initWithURL:soundURL];
	expect([sound.soundName isEqualToString:@"Rooster"]).beTruthy();
	expect([sound.soundExt isEqualToString:@"mp3"]).beTruthy();
	expect([sound.soundData length]).equal(30323);
}

- (void)testConfigureSoundNameOnInitWithURL {
	[[soundMock expect] configureSoundName];
	sound = [sound initWithURL:[NSURL URLWithString:@"https://www.google.de"]];
	[soundMock verify];
}

- (void)testLoadSoundDataOnInitWithURL {
	[[soundMock expect] loadSoundData];
	sound = [sound initWithURL:[NSURL URLWithString:@"https://www.google.de"]];
	[soundMock verify];
}

#pragma mark -
#pragma mark helper methods
#pragma mark -


@end
