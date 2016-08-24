
#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "StationTuneinDetails.h"

#define TestNumberOfEnties		1
#define TestStationFileName		@"StationFileName"
#define TestStationTitle		@"StationTitle"

@interface StationTuneinDetailsTest : XCTestCase {
	StationTuneinDetails *details;
}

@end

@interface StationTuneinDetails (Testing)

@end

@implementation StationTuneinDetailsTest

- (void)setUp {
	[super setUp];
}

- (void)tearDown {
	[super tearDown];
}

#pragma mark -
#pragma mark real test methods
#pragma mark -

- (void)testInitStationTuneinDetailsCorrectly {
	NSDictionary *stationTuneinDict = @{@"playlist": @{@"numberofentries" : @(TestNumberOfEnties),
													   @"File1": TestStationFileName,
													   @"Title1": TestStationTitle}};
	details = [[StationTuneinDetails alloc] initWithDict:stationTuneinDict];
	expect(details.numberOfEntries).equal(TestNumberOfEnties);
	expect([details.titles[0] isEqualToString:TestStationTitle]).beTruthy();
	expect([details.fileURLStrings[0] isEqualToString:TestStationFileName]).beTruthy();
}

#pragma mark -
#pragma mark helper methods
#pragma mark -


@end
