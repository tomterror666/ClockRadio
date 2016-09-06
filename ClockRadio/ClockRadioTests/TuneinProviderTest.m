#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>

#import "TuneinProvider.h"
#import "ApiClient.h"

@interface TuneinProviderTest : XCTestCase {
	TuneinProvider *provider;
	id providerMock;
	id apiClientMock;
}

@end

@interface TuneinProvider (Testing)
@property (nonatomic, strong) ApiClient *apiClient;
@end

@implementation TuneinProviderTest

- (void)setUp {
	[super setUp];
	provider = [TuneinProvider sharedProvider];
	providerMock = [OCMockObject partialMockForObject:provider];
	
	apiClientMock = [OCMockObject niceMockForClass:[ApiClient class]];
	[[[providerMock stub] andReturn:apiClientMock] apiClient];
}

- (void)tearDown {
	[apiClientMock stopMocking];
	[providerMock stopMocking];
	[super tearDown];
}

#pragma mark -
#pragma mark real test methods
#pragma mark -


@end
