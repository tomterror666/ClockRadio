
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <KIF/KIF.h>
#import "KIFTestActor+ClockRadio.h"
#import "RadioStationSelectionViewController.h"
#import "MockedConfiguration.h"
#import "StationProvider.h"
#import "Station.h"

@interface RadioStationSelectionViewControllerUITest : KIFTestCase {
	MockedConfiguration *config;
	id stationProviderMock;
	id stationMock;
}

@end

@interface  RadioStationSelectionViewController(Testing)

@end

@implementation RadioStationSelectionViewControllerUITest

- (void)setUp {
	[super setUp];
	config = [MockedConfiguration new];
	stationProviderMock = [OCMockObject partialMockForObject:[StationProvider sharedProvider]];
	stationMock = [OCMockObject niceMockForClass:[Station class]];
}

- (void)tearDown {
	[stationMock stopMocking];
	[stationProviderMock stopMocking];
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

- (void)testCorrectNumberOfRowsInTableView {
	NSInteger numberOfStations = 10;
	[[[stationProviderMock stub] andReturn:stationProviderMock] sharedProvider];
	[[[stationProviderMock stub] andReturnValue:OCMOCK_VALUE(numberOfStations)] numberOfRadioStations];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	[tester tapViewWithAccessibilityLabel:@"RadioSelectionButton"];
	[tester waitForViewWithAccessibilityLabel:@"RadioStationSelectionView"];
	[tester waitForViewWithAccessiblityLabel:@"RadioStationSelectionTableView" containingNumberOfCells:numberOfStations inSection:0];
	[tester tapViewWithAccessibilityLabel:@"CancelButton"];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
}

- (void)testCorrectCellsInTableView {
	NSInteger numberOfStations = 1;
	NSIndexPath *stationIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	NSString *stationName = @"Dance Dance Dance";
	NSString *stationGenre = @"Tanzen";
	NSInteger numberOfListeners = 1000;
	[[[stationProviderMock stub] andReturn:stationProviderMock] sharedProvider];
	[[[stationProviderMock stub] andReturnValue:OCMOCK_VALUE(numberOfStations)] numberOfRadioStations];
	[[[stationProviderMock stub] andReturn:stationMock] radioStationAtIndexPath:stationIndexPath];
	[[[stationMock stub] andReturn:stationName] stationName];
	[[[stationMock stub] andReturn:stationGenre] stationGenre];
	[[[stationMock stub] andReturnValue:OCMOCK_VALUE(numberOfListeners)] stationsCurrentListners];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	[tester tapViewWithAccessibilityLabel:@"RadioSelectionButton"];
	[tester waitForViewWithAccessibilityLabel:@"RadioStationSelectionView"];
	[tester waitForLabelWithAccessibilityLabel:@"RadioStationSelectionNameLabel_0" withText:stationName];
	[tester waitForLabelWithAccessibilityLabel:@"RadioStationSelectionDetailsLabel_0" withText:[NSString stringWithFormat:@"Genre: %@ - Listeners: %ld", stationGenre, (long)numberOfListeners]];
	[tester tapViewWithAccessibilityLabel:@"CancelButton"];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
}

@end
