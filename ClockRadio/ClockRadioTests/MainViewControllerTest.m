
#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "OCMConstraint+Extensions.h"
#import "MainViewController.h"
#import "TuneinProvider.h"
#import "StationProvider.h"
#import "Configuration.h"
#import "AudioPlayerView.h"
#import "StationSelectionViewController.h"
#import "AlarmSelectionViewController.h"
#import "SoundSelectionViewController.h"
#import "Station.h"

@interface MainViewControllerTest : XCTestCase {
	MainViewController *controller;
	id controllerMock;
	id tuneinProviderMock;
	id stationProviderMock;
	id configurationMock;
	id audioPlayerMock;
	id stationMock;
}

@end

@interface MainViewController (Testing)
@property (nonatomic, strong) STKAudioPlayer *audioPlayer;
@property (nonatomic, strong) TuneinProvider *tuneinProvider;
@property (nonatomic, strong) StationProvider *stationProvider;
- (void)refreshView;
- (void)addPlayerView;
- (void)radioSelectionButtonTouched:(id)sender;
- (void)alarmSelectionButtonTouched:(id)sender;
- (void)soundSelectionButtonTouched:(id)sender;
//- (void)radioStationSelectionVCDidCancelSelecting:(RadioStationSelectionViewController *)controller;
//- (void)radioStationSelectionVC:(RadioStationSelectionViewController *)controller didFinishWithRadioStation:(Station *)station;
- (void)alarmSelectonVCDidCancel:(AlarmSelectionViewController *)controller;
- (void)alarmSelectionVC:(AlarmSelectionViewController *)controller didFinishWithAlarmDate:(NSDate *)date;
- (void)registerForLocalNotifications;
- (void)createLocalNotificationForDate:(NSDate *)date;
- (void)soundSelectionViewControllerDidCancel:(SoundSelectionViewController *)controller;
- (void)soundSelectionViewController:(SoundSelectionViewController *)controller didFinishWithSound:(Sound *)sound;
@end

@implementation MainViewControllerTest

- (void)setUp {
	[super setUp];
	controller = [[MainViewController alloc] initWithCoder:[[NSKeyedUnarchiver alloc] initForReadingWithData:[NSData data]]];
	controllerMock = [OCMockObject partialMockForObject:controller];
	tuneinProviderMock = [OCMockObject niceMockForClass:[TuneinProvider class]];
	stationProviderMock = [OCMockObject niceMockForClass:[StationProvider class]];
	configurationMock = [OCMockObject niceMockForClass:[Configuration class]];
	[[[configurationMock stub] andReturn:configurationMock] currentConfiguration];
	audioPlayerMock = [OCMockObject niceMockForClass:[STKAudioPlayer class]];
	stationMock = [OCMockObject niceMockForClass:[Station class]];
}

- (void)tearDown {
	[stationMock stopMocking];
	[audioPlayerMock stopMocking];
	[configurationMock stopMocking];
	[stationProviderMock stopMocking];
	[tuneinProviderMock stopMocking];
	[controllerMock stopMocking];
	[super tearDown];
}

#pragma mark -
#pragma mark real test methods
#pragma mark -

- (void)testInitControllerCorrectly {
	expect(controller.tuneinProvider).notTo.beNil();
	expect(controller.stationProvider).notTo.beNil();
}

- (void)testRefreshViewOnViewDidLoad {
	[[controllerMock expect] refreshView];
	[controller viewDidLoad];
	[controllerMock verify];
}

- (void)testAddPlayerViewOnRefreshView {
	[[controllerMock expect] addPlayerView];
	[controller refreshView];
	[controllerMock verify];
}

- (void)testQueueDataSourceOnRefreshView {
	[[[configurationMock stub] andReturnValue:OCMOCK_VALUE(YES)] shouldPlayImmediately];
	[[[controllerMock stub] andReturn:audioPlayerMock] audioPlayer];
	[[audioPlayerMock expect] queueDataSource:OCMOCK_ANY withQueueItemId:OCMOCK_ANY];
	[controller refreshView];
	[audioPlayerMock verify];
}

- (void)testPresentRadioStationVCOnRadioSelectionButtonTouched {
	[[controllerMock expect] presentViewController:[OCMConstraint isKindOfClass:[StationSelectionViewController class]]
										  animated:YES
										completion:OCMOCK_ANY];
	[controller radioSelectionButtonTouched:nil];
	[controllerMock verify];
}

- (void)testPresentAlarmSelectionVCOnAlarmSelectionButtonTouched {
	[[controllerMock expect] presentViewController:[OCMConstraint isKindOfClass:[AlarmSelectionViewController class]]
										  animated:YES
										completion:OCMOCK_ANY];
	[controller alarmSelectionButtonTouched:nil];
	[controllerMock verify];
}

- (void)testPresentSoundSelectionVCOnSoundSelectionButtonTouched {
	[[controllerMock expect] presentViewController:[OCMConstraint isKindOfClass:[SoundSelectionViewController class]]
										  animated:YES
										completion:OCMOCK_ANY];
	[controller soundSelectionButtonTouched:nil];
	[controllerMock verify];
}

//- (void)testDismissViewControllerOnRadioStationSelectionVCDidCancelSelecting {
//	[[controllerMock expect] dismissViewControllerAnimated:YES completion:NULL];
//	[controller radioStationSelectionVCDidCancelSelecting:OCMOCK_ANY];
//	[controllerMock verify];
//}
//
//- (void)testDismissViewControllerOnRadioStationSelectionVCDidFinishWithRadioStation {
//	[[controllerMock expect] dismissViewControllerAnimated:YES completion:OCMOCK_ANY];
//	[controller radioStationSelectionVC:OCMOCK_ANY didFinishWithRadioStation:OCMOCK_ANY];
//	[controllerMock verify];
//}

- (void)testDismissViewControllerOnAlarmSelectionVCDidCancel {
	[[controllerMock expect] dismissViewControllerAnimated:YES completion:NULL];
	[controller alarmSelectonVCDidCancel:OCMOCK_ANY];
	[controllerMock verify];
}

- (void)testDismissViewControllerOnAlarmSelectionVCDidFinishWithAlarmDate {
	[[controllerMock expect] dismissViewControllerAnimated:YES completion:OCMOCK_ANY];
	[controller alarmSelectionVC:OCMOCK_ANY didFinishWithAlarmDate:OCMOCK_ANY];
	[controllerMock verify];
}

- (void)testRegisterForLocalNotificationsOnCreateLocalNotificationForDate {
	[[controllerMock expect] registerForLocalNotifications];
	id applicationMock = [OCMockObject niceMockForClass:[UIApplication class]];
	[[[applicationMock stub] andReturn:applicationMock] sharedApplication];
	[[applicationMock stub] scheduleLocalNotification:OCMOCK_ANY];
	[controller createLocalNotificationForDate:[NSDate date]];
	[controllerMock verify];
	[applicationMock stopMocking];
}

- (void)testDismissViewControllerOnSoundSelectionVCDidCancel {
	[[controllerMock expect] dismissViewControllerAnimated:YES completion:NULL];
	[controller soundSelectionViewControllerDidCancel:OCMOCK_ANY];
	[controllerMock verify];
}

- (void)testDismissViewControllerOnSoundSelectionVCDidFinishWithSound {
	[[controllerMock expect] dismissViewControllerAnimated:YES completion:OCMOCK_ANY];
	[controller soundSelectionViewController:OCMOCK_ANY didFinishWithSound:OCMOCK_ANY];
	[controllerMock verify];
}

#pragma mark -
#pragma mark helper methods
#pragma mark -


@end
