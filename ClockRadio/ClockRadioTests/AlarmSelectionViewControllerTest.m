
#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "AlarmSelectionViewController.h"

@interface AlarmSelectionViewControllerTest : XCTestCase {
	AlarmSelectionViewController *controller;
	id delegateMock;
	id alarmSelectorMock;
}

@end

@interface AlarmSelectionViewController (Testing)
@property (nonatomic, weak) IBOutlet UIDatePicker *alarmSelector;
- (IBAction)doneButtonTouched:(id)sender;
- (IBAction)cancelButtonTouched:(id)sender;
@end

@implementation AlarmSelectionViewControllerTest

- (void)setUp {
	[super setUp];
	controller = [AlarmSelectionViewController new];
	delegateMock = [OCMockObject niceMockForProtocol:@protocol(AlarmSelectionDelegate)];
	controller.delegate = delegateMock;
	alarmSelectorMock = [OCMockObject niceMockForClass:[UIDatePicker class]];
	controller.alarmSelector = alarmSelectorMock;
}

- (void)tearDown {
	[alarmSelectorMock stopMocking];
	[delegateMock stopMocking];
	[super tearDown];
}

#pragma mark -
#pragma mark real test methods
#pragma mark -

- (void)testAlarmSelectionDidFinishedOnDoneButtonTouched {
	[[[alarmSelectorMock stub] andReturn:[NSDate date]] date];
	[[delegateMock expect] alarmSelectionVC:controller didFinishWithAlarmDate:OCMOCK_ANY];
	[controller doneButtonTouched:nil];
	[delegateMock verify];
}

- (void)testAlarmSelectionDidCancelOnCancelButtonTouched {
	[[delegateMock expect] alarmSelectonVCDidCancel:controller];
	[controller cancelButtonTouched:nil];
	[delegateMock verify];
}

#pragma mark -
#pragma mark helper methods
#pragma mark -


@end
