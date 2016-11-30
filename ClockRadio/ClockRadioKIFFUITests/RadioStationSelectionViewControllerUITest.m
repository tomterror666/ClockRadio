
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <KIF/KIF.h>
#import "KIFTestActor+ClockRadio.h"
#import "RadioStationSelectionViewController.h"
#import "MockedConfiguration.h"
#import "StationProvider.h"
#import "Station.h"

@interface RadioStationSelectionViewControllerUITest : KIFTestCase {
	id stationProviderMock;
	id stationMock;
}

@end

@interface  RadioStationSelectionViewController(Testing)

@end

@implementation RadioStationSelectionViewControllerUITest

- (void)setUp {
	[super setUp];
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
	[tester waitForViewWithAccessiblityLabel:@"StationSelectionCollectionView" containingNumberOfCells:numberOfStations inSection:0];
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
	[tester waitForLabelWithAccessibilityLabel:@"StationSelectionNameLabel_0" withText:[NSString stringWithFormat:@"1. - %@", stationName]];
	[tester waitForLabelWithAccessibilityLabel:@"StationSelectionGenereLabel_0" withText:[NSString stringWithFormat:@"%@", stationGenre]];
	[tester waitForLabelWithAccessibilityLabel:@"StationSelectionNumberOfListenersLabel_0" withText:[NSString stringWithFormat:@"Listeners: %ld", (long)numberOfListeners]];	
	[tester tapViewWithAccessibilityLabel:@"CancelButton"];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
}

- (void)testScrollingInStationsTableView {
//	[tester tapViewWithAccessibilityLabel:@"RadioSelectionButton"];
//	[tester waitForViewWithAccessibilityLabel:@"RadioStationSelectionView"];
//	[tester waitForLabelWithAccessibilityLabel:@"RadioStationSelectionNameLabel_0" withText:@"Alex Jones - Infowars.com Alternate/Relay"];
//	[tester waitForLabelWithAccessibilityLabel:@"RadioStationSelectionDetailsLabel_0" withText:@"Genre: News - Listeners: 26686"];
//	[tester waitForLabelWithAccessibilityLabel:@"RadioStationSelectionNameLabel_1" withText:@"Radio Sobsomoy"];
//	[tester waitForLabelWithAccessibilityLabel:@"RadioStationSelectionDetailsLabel_1" withText:@"Genre: Misc - Listeners: 17738"];
//	[tester scrollViewWithAccessibilityIdentifier:@"RadioStationSelectionTableView" byFractionOfSizeHorizontal:-0 vertical:-0.2];
//	[tester waitForLabelWithAccessibilityLabel:@"RadioStationSelectionNameLabel_19" withText:@"JewishMusic Stream"];
//	[tester waitForLabelWithAccessibilityLabel:@"RadioStationSelectionDetailsLabel_19" withText:@"Genre: Hebrew - Listeners: 1929"];
//	[tester tapViewWithAccessibilityLabel:@"CancelButton"];
//	[tester waitForViewWithAccessibilityLabel:@"MainView"];
}

- (void)testSelectingRadioStation {
	[stationMock stopMocking];
	[stationProviderMock stopMocking];
	[tester tapViewWithAccessibilityLabel:@"RadioSelectionButton"];
	[tester waitForViewWithAccessibilityLabel:@"RadioStationSelectionView"];
	[tester waitForLabelWithAccessibilityLabel:@"StationSelectionNameLabel_0" withText:@"1. - Alex Jones - Infowars.com Alternate/Relay"];
	[tester waitForLabelWithAccessibilityLabel:@"StationSelectionGenereLabel_0" withText:@"News"];
	[tester waitForLabelWithAccessibilityLabel:@"StationSelectionNumberOfListenersLabel_0" withText:@"Listeners: 26686"];
	MockedConfiguration *config = [MockedConfiguration new];
	[config mockCurrentSelectedRadioStationURLString:@"http://50.7.130.106:80"];
//	[tester tapViewWithAccessibilityLabel:@"RadioStationSelectionNameCell_0"];
	[tester tapViewWithAccessibilityLabel:@"CancelButton"];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	[tester waitForTimeInterval:1];
	[tester waitForLabelWithAccessibilityLabel:@"RadioSelectionValueLabel" withText:@"http://50.7.130.106:80"];
}

@end
