
//#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <KIF/KIF.h>
#import "KIFTestActor+ClockRadio.h"
#import "MainViewController.h"
#import "MockedConfiguration.h"
#import "NavigationHelper.h"
#import "NSDate+Utility.h"
#import "Sound.h"

@interface MainViewControllerUITest : KIFTestCase {
	MockedConfiguration *config;
}

@end

@interface MainViewController (Testing)

@end

@implementation MainViewControllerUITest

- (void)setUp {
	[super setUp];
	config = [MockedConfiguration new];
}

- (void)tearDown {
	[super tearDown];
}

- (void)beforeEach {
	[super beforeEach];
	[tester waitForTimeInterval:1];
	[config mockEmptyConfiguration];
}

- (void)afterEach {
	[super afterEach];
}

#pragma mark -
#pragma mark real test methods
#pragma mark -

- (void)testStartAppEmpty {
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
}

- (void)testCannotPlayIfAnyStationIsNotSelected {
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	[config mockEmptyConfiguration];
	[(MainViewController *)[NavigationHelper visiblePhoneViewController] refreshView];
	[tester waitForButtonWithAccessibilityLabel:@"PlayButton" withButtonText:@"Play" isTappable:NO];
	[tester waitForLabelWithAccessibilityLabel:@"RadioSelectionLabel" withText:@"Current radio station:"];
	[tester waitForLabelWithAccessibilityLabel:@"RadioSelectionValueLabel" withText:@""];
	[tester waitForButtonWithAccessibilityLabel:@"RadioSelectionButton" isTappable:YES];
	[tester waitForLabelWithAccessibilityLabel:@"AlarmSelectionLabel" withText:@"Current Alarm:"];
	[tester waitForLabelWithAccessibilityLabel:@"AlarmSelectionValueLabel" withText:@""];
	[tester waitForButtonWithAccessibilityLabel:@"AlarmSelectionButton" isTappable:YES];
	[tester waitForLabelWithAccessibilityLabel:@"SoundSelectionLabel" withText:@"Current Sound:"];
	[tester waitForLabelWithAccessibilityLabel:@"SoundSelectionValueLabel" withText:@""];
	[tester waitForButtonWithAccessibilityLabel:@"SoundSelectionButton" isTappable:YES];
}

- (void)testDisplayingRadioStationCorrectly {
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	NSString *stationURLString = @"https://www.google.de";
	[config mockCurrentSelectedRadioStationURLString:stationURLString];
	[(MainViewController *)[NavigationHelper visiblePhoneViewController] refreshView];
	[tester waitForLabelWithAccessibilityLabel:@"RadioSelectionValueLabel" withText:stationURLString];
}

- (void)testDisplayingAlarmDateCorrectly {
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	NSDate *now = [NSDate date];
	NSString *alarmString = [now dateAndTimeString];
	[config mockCurrentAlarmDate:now];
	[(MainViewController *)[NavigationHelper visiblePhoneViewController] refreshView];
	[tester waitForLabelWithAccessibilityLabel:@"AlarmSelectionValueLabel" withText:alarmString];
}

- (void)testDisplayingAlarmSoundCorrectly {
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	NSString *soundString = @"SuperDooperAlarmSound";
	id soundMock = [OCMockObject niceMockForClass:[Sound class]];
	[[[soundMock stub] andReturn:soundString] soundName];
	[config mockCurrentSelectedSound:soundMock];
	[(MainViewController *)[NavigationHelper visiblePhoneViewController] refreshView];
	[tester waitForLabelWithAccessibilityLabel:@"SoundSelectionValueLabel" withText:soundString];
	[soundMock stopMocking];
}

- (void)testOpenRadioStationSelection {
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	[tester tapViewWithAccessibilityLabel:@"RadioSelectionButton"];
	[tester waitForViewWithAccessibilityLabel:@"RadioStationSelectionView"];
	[tester tapViewWithAccessibilityLabel:@"CancelButton"];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
}

- (void)testOpenAlarmDateSelection {
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	[tester tapViewWithAccessibilityLabel:@"AlarmSelectionButton"];
	[tester waitForViewWithAccessibilityLabel:@"AlarmSelectionView"];
	[tester tapViewWithAccessibilityLabel:@"CancelButton"];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
}

- (void)testOpenAlarmSoundSelection {
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	[tester tapViewWithAccessibilityLabel:@"SoundSelectionButton"];
	[tester waitForViewWithAccessibilityLabel:@"SoundSelectionView"];
	[tester tapViewWithAccessibilityLabel:@"CancelButton"];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
}

- (void)testPlayingStoppingAndMutingRadio {
	[tester tapViewWithAccessibilityLabel:@"RadioSelectionButton"];
	[tester waitForViewWithAccessibilityLabel:@"RadioStationSelectionView"];
	[tester tapViewWithAccessibilityLabel:@"RadioStationSelectionNameCell_0"];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	[tester waitForButtonWithAccessibilityLabel:@"PlayButton" isTappable:YES];
	[tester waitForButtonWithAccessibilityLabel:@"StopButton" isTappable:NO];
	[tester waitForButtonWithAccessibilityLabel:@"MuteButton" withButtonText:@"Mute" isTappable:YES];
	[tester tapViewWithAccessibilityLabel:@"PlayButton"];
	[tester waitForButtonWithAccessibilityLabel:@"PlayButton" isTappable:NO];
	[tester waitForButtonWithAccessibilityLabel:@"StopButton" isTappable:YES];
	[tester tapViewWithAccessibilityLabel:@"StopButton"];
	[tester waitForButtonWithAccessibilityLabel:@"PlayButton" isTappable:YES];
	[tester waitForButtonWithAccessibilityLabel:@"StopButton" isTappable:NO];
	[tester tapViewWithAccessibilityLabel:@"PlayButton"];
	[tester tapViewWithAccessibilityLabel:@"MuteButton"];
	[tester waitForButtonWithAccessibilityLabel:@"MuteButton" withButtonText:@"Unmute" isTappable:YES];
	[tester tapViewWithAccessibilityLabel:@"MuteButton"];
	[tester waitForButtonWithAccessibilityLabel:@"MuteButton" withButtonText:@"Mute" isTappable:YES];
	[tester tapViewWithAccessibilityLabel:@"StopButton"];
	[tester waitForButtonWithAccessibilityLabel:@"PlayButton" isTappable:YES];
	[tester waitForButtonWithAccessibilityLabel:@"StopButton" isTappable:NO];
}


#pragma mark -
#pragma mark helper methods
#pragma mark -


@end
