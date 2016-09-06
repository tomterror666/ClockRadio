
#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import "Station.h"

#define TestStationName 			@"StationName"
#define TestStationId 				@"StationId"
#define TestStationBitRate 			44000
#define TestStationGenre 			@"Genere"
#define TestStationCurrentListeners	2000
#define TestStationMediaType 		@"MediaTypeMP3"

@interface StationTest : XCTestCase {
	Station *station;
}

@end

@interface Station (Testing)

@end

@implementation StationTest

- (void)setUp {
	[super setUp];
}

- (void)tearDown {
	[super tearDown];
}

#pragma mark -
#pragma mark real test methods
#pragma mark -

- (void)testInitStationCorrectly {
	NSDictionary *stationDict = @{StationNameKey: TestStationName,
								  StationIdKey: TestStationId,
								  StationBitRateKey: @(TestStationBitRate),
								  StationGenreKey: TestStationGenre,
								  StationsCurrentListnersKey: @(TestStationCurrentListeners),
								  StationMediaTypeKey: TestStationMediaType};
	station = [[Station alloc] initWithDict:stationDict];
	expect([station.stationName isEqualToString:TestStationName]).beTruthy();
	expect([station.stationId isEqualToString:TestStationId]).beTruthy();
	expect(station.stationBitRate).equal(TestStationBitRate);
	expect([station.stationGenre isEqualToString:TestStationGenre]).beTruthy();
	expect(station.stationsCurrentListners).equal(TestStationCurrentListeners);
	expect([station.stationMediaType isEqualToString:TestStationMediaType]).beTruthy();
}

#pragma mark -
#pragma mark helper methods
#pragma mark -


@end
