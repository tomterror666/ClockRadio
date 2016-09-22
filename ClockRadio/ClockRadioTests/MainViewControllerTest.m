
#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "OCMConstraint+Extensions.h"
#import "MainViewController.h"
#import "TuneinProvider.h"
#import "StationProvider.h"
#import "Configuration.h"
#import "AudioPlayerView.h"
#import "RadioStationSelectonViewController.h"
#import "AlarmSelectionViewController.h"
#import "SoundSelectionViewController.h"

@interface MainViewControllerTest : XCTestCase {
	MainViewController *controller;
	id controllerMock;
	id tuneinProviderMock;
	id stationProviderMock;
	id configurationMock;
	id audioPlayerMock;
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
}

- (void)tearDown {
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
	[[controllerMock expect] presentViewController:[OCMConstraint isKindOfClass:[UIViewController class]]
										  animated:YES
										completion:OCMOCK_ANY];
	[controller radioSelectionButtonTouched:nil];
	[controllerMock verify];
}

- (void)testPresentAlarmSelectionVCOnAlarmSelectionButtonTouched {
	
}

- (void)testPresentSoundSelectionVCOnSoundSelectionButtonTouched {
	
}

#pragma mark -
#pragma mark helper methods
#pragma mark -


@end
