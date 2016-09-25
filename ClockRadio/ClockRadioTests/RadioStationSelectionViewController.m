
#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "RadioStationSelectonViewController.h"
#import "StationProvider.h"
#import "Station.h"

@interface RadioStationSelectonViewControllerTest : XCTestCase {
	RadioStationSelectonViewController *controller;
	id controllerMock;
	id tableviewMock;
	id delegateMock;
	id providerMock;
	id cellMock;
	id stationMock;
}

@end

@interface RadioStationSelectonViewController (Testing)
@property (nonatomic, strong) StationProvider *stationProvider;
@property (nonatomic, strong) UITableView *tableView;
- (void)refreshView;
- (void)updateUI;
- (void)cancelButtonTouched:(id)sender;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RadioStationSelectonViewControllerTest

- (void)setUp {
	[super setUp];
	controller = [[RadioStationSelectonViewController alloc] initWithNibName:@"RadioStationViewController" bundle:nil];
	controllerMock = [OCMockObject partialMockForObject:controller];
	tableviewMock = [OCMockObject niceMockForClass:[UITableView class]];
	[[[controllerMock stub] andReturn:tableviewMock] tableView];
	delegateMock = [OCMockObject niceMockForProtocol:@protocol(RadioStationSelectionDelegate)];
	[[[controllerMock stub] andReturn:delegateMock] delegate];
	providerMock = [OCMockObject niceMockForClass:[StationProvider class]];
	cellMock = [OCMockObject niceMockForClass:[UITableViewCell class]];
	stationMock = [OCMockObject niceMockForClass:[Station class]];
}

- (void)tearDown {
	[stationMock stopMocking];
	[cellMock stopMocking];
	[providerMock stopMocking];
	[delegateMock stopMocking];
	[tableviewMock stopMocking];
	[controllerMock stopMocking];
	[super tearDown];
}

#pragma mark -
#pragma mark real test methods
#pragma mark -

- (void)testInitCorrectly {
	expect(controller.stationProvider).notTo.beNil();
}

- (void)testRefreshViewOnViewWillAppear {
	[[controllerMock expect] refreshView];
	[controller viewWillAppear:YES];
	[controllerMock verify];
}

- (void)testUpdateUIOnRefreshView {
	[[controllerMock expect] updateUI];
	[controller refreshView];
	[controllerMock verify];
}

- (void)testReloadDataOnUpdateUI {
	[[tableviewMock expect] reloadData];
	[controller updateUI];
	[tableviewMock verify];
}

- (void)testRadioStationSelectionVCDidCancelSelectingOnCancelButtonTouched {
	[[delegateMock expect] radioStationSelectionVCDidCancelSelecting:controller];
	[controller cancelButtonTouched:OCMOCK_ANY];
	[delegateMock verify];
}

- (void)testCorrectNumberOfSectionsInTableView {
	expect([controller numberOfSectionsInTableView:tableviewMock]).equal(1);
}

- (void)testCorrectNumberOfRowsInSection0 {
	NSInteger numberOfStations = 100;
	[[[providerMock stub] andReturnValue:OCMOCK_VALUE(numberOfStations)] numberOfRadioStations];
	[[[controllerMock stub] andReturn:providerMock] stationProvider];
	expect([controller tableView:tableviewMock numberOfRowsInSection:0]).equal(numberOfStations);
}

- (void)testDequeueReusableCellWithIdentifierOnCellForRowAtIndexPath {
	[[tableviewMock expect] dequeueReusableCellWithIdentifier:radioStationSelectionTableViewCellKey];
	[controller tableView:tableviewMock cellForRowAtIndexPath:OCMOCK_ANY];
	[tableviewMock verify];
}

- (void)testCorrectHeightOfRowAtIndexPath {
	expect([controller tableView:tableviewMock heightForRowAtIndexPath:OCMOCK_ANY]).equal(60.0);
}

- (void)testUpdateCellCorrectlyOnWillDisplayCellAtIndexPath {
	NSString *stationName = @"stationName";
	NSString *stationGenere = @"stationGenere";
	NSInteger listeners = 100;
	NSString *expectedDetail = [NSString stringWithFormat:@"Genre: %@ - Listeners: %ld", stationGenere, (long)listeners];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[[[stationMock stub] andReturn:stationName] stationName];
	[[[stationMock stub] andReturn:stationGenere] stationGenre];
	[[[stationMock stub] andReturnValue:OCMOCK_VALUE(listeners)] stationsCurrentListners];
	[[[providerMock stub] andReturn:stationMock] radioStationAtIndexPath:indexPath];
	[[[controllerMock stub] andReturn:providerMock] stationProvider];
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
	[controller tableView:tableviewMock willDisplayCell:cell forRowAtIndexPath:indexPath];
	expect([cell.textLabel.text isEqualToString:stationName]).beTruthy();
	expect([cell.detailTextLabel.text isEqualToString:expectedDetail]).beTruthy();
}

- (void)testRadioStationSelectionVCDidFinishWithRadioStationOnDidSelectRowAtIndexPath {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[[[providerMock stub] andReturn:stationMock] radioStationAtIndexPath:indexPath];
	[[[controllerMock stub] andReturn:providerMock] stationProvider];
	[[delegateMock expect] radioStationSelectionVC:controller didFinishWithRadioStation:stationMock];
	[controller tableView:tableviewMock didSelectRowAtIndexPath:indexPath];
	[delegateMock verify];
}

#pragma mark -
#pragma mark helper methods
#pragma mark -


@end
