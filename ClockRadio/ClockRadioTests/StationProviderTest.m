#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>

#import "StationProvider.h"
#import "ApiClient.h"
#import "Station.h"

@interface StationProviderTest : XCTestCase {
	StationProvider *provider;
	id providerMock;
	id apiClientMock;
}

@end

@interface StationProvider (Testing)
@property (nonatomic, strong) ApiClient *apiClient;
@property (nonatomic, strong) NSMutableArray *stations;
@property (nonatomic, copy) NSString *tuneInBase;
@property (nonatomic, copy) NSString *tuneInBaseM3U;
@property (nonatomic, copy) NSString *tuneInBaseXSPF;
- (void)handelResponseDict:(NSDictionary *)responseDict withCompletion:(LoadingStationsCompletion)completion;
@end

@interface ApiClient ()
@property (nonatomic, copy) NSString *basePath;
@end

@implementation StationProviderTest

- (void)setUp {
	[super setUp];
	provider = [StationProvider sharedProvider];
	providerMock = [OCMockObject partialMockForObject:provider];
	
	apiClientMock = [OCMockObject partialMockForObject:provider.apiClient];
}

- (void)tearDown {
	[apiClientMock stopMocking];
	[providerMock stopMocking];
	[super tearDown];
}

#pragma mark -
#pragma mark real test methods
#pragma mark -

- (void)testCorrectApiClientBasePath {
	expect([provider.apiClient.basePath isEqualToString:StationProviderBasePath]).beTruthy();
}

- (void)testGetDataForPathOnLoadStationsWithCompletion {
	[[apiClientMock expect] getDataForPath:@"Top500" withParameters:nil withCompletion:OCMOCK_ANY];
	[provider loadStationsWithCompletion:NULL];
	[apiClientMock verify];
}

- (void)testSettingTuneInBaseDataCorrectlyOnHandleResponseDict {
	NSString *tuneInBase = @"tuneInBase";
	NSString *tuneInBaseM3U = @"tuneInBaseM3U";
	NSString *tuneInBaseXSPF = @"tuneInBaseXSPF";
	NSString *stationName = @"TestStation";
	NSDictionary *stationDict = @{StationNameKey: stationName};
	NSArray *stations = @[stationDict];
	NSDictionary *responseDict = @{@"stationlist": @{@"tunein": @{@"base": tuneInBase, 
																  @"base-m3u": tuneInBaseM3U, 
																  @"base-xspf": tuneInBaseXSPF}, 
													 @"station": stations}};
	[provider handelResponseDict:responseDict withCompletion:NULL];
	expect([provider.tuneInBase isEqualToString:tuneInBase]).beTruthy();
	expect([provider.tuneInBaseM3U isEqualToString:tuneInBaseM3U]).beTruthy();
	expect([provider.tuneInBaseXSPF isEqualToString:tuneInBaseXSPF]).beTruthy();
	expect(provider.numberOfRadioStations).equal([stations count]);
	expect([[provider radioStationAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].stationName isEqualToString:stationName]).beTruthy();
}

- (void)testCorrectNumberOfStations {
	NSArray *stations = @[@"1", @"2", @"3"];
	[[[providerMock stub] andReturn:stations] stations];
	expect(provider.numberOfRadioStations).equal([stations count]);
}

- (void)testCorrectStationAtIndexPath {
	Station *station = [[Station alloc] initWithDict:@{}];
	NSArray *stations = @[@"1", station, @"3"];
	[[[providerMock stub] andReturn:stations] stations];
	expect([provider radioStationAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).equal(station);
}

- (void)testCorrectTuneinBase {
	NSString *tuneinBase = @"tuneinbase";
	[[[providerMock stub] andReturn:tuneinBase] tuneInBase];
	expect([[provider tuneinBase] isEqualToString:tuneinBase]).beTruthy();
}

- (void)testCorrectTuneinBaseM3U {
	NSString *tuneinBase = @"tuneinbaseM3U";
	[[[providerMock stub] andReturn:tuneinBase] tuneInBaseM3U];
	expect([[provider tuneinBaseM3U] isEqualToString:tuneinBase]).beTruthy();
}

- (void)testCorrectTuneinBaseXSPF {
	NSString *tuneinBase = @"tuneinbaseXSPF";
	[[[providerMock stub] andReturn:tuneinBase] tuneInBaseXSPF];
	expect([[provider tuneinBaseXSPF] isEqualToString:tuneinBase]).beTruthy();
}

@end
