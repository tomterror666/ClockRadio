
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <KIF/KIF.h>
#import "KIFTestActor+ClockRadio.h"
#import "AlarmSelectionViewController.h"
#import "NSDate+Utility.h"
#import "NavigationHelper.h"
#import "MainViewController.h"
//#import <DateTools/DateTools.h>

@interface AlarmSelectionViewControllerUITest : KIFTestCase {
	
}

@end

@interface AlarmSelectionViewController (Testing)
- (void)createLocalNotificationForDate:(NSDate *)date;
@end

@implementation AlarmSelectionViewControllerUITest

- (void)setUp {
	[super setUp];
}

- (void)tearDown {
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

- (void)testOpenAlarmSelection {
	[tester tapViewWithAccessibilityLabel:@"AlarmSelectionButton"];
	[tester waitForViewWithAccessibilityLabel:@"AlarmSelectionView"];
	UIDatePicker *alarmPicker = (UIDatePicker *)[tester waitForViewWithAccessibilityLabel:@"AlarmSelectionPicker"];
	NSDate *now = [NSDate date];
	NSAssert([[NSDate normalizeSecondsOfDate:now] compare:[NSDate normalizeHoursOfDate:alarmPicker.date]] != NSOrderedSame, @"wrong time found! %@ != %@", now, alarmPicker.date);
	[tester tapViewWithAccessibilityLabel:@"CancelButton"];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
}

- (void)testSelectingAndDisplayingAlarmDateCorrectly {
	[tester tapViewWithAccessibilityLabel:@"AlarmSelectionButton"];
	[tester waitForViewWithAccessibilityLabel:@"AlarmSelectionView"];
	NSDate *now = [NSDate date];
	[tester selectDatePickerValue:@[@"Heute", [@(now.hours + 2) stringValue], [@(now.minutes + 2) stringValue]]];
	UIDatePicker *alarmPicker = (UIDatePicker *)[tester waitForViewWithAccessibilityLabel:@"AlarmSelectionPicker"];
	NSAssert([[NSDate normalizeSecondsOfDate:[now dateByAddingTimeInterval:2 * 60 * 60 + 2 * 60]] compare:[NSDate normalizeHoursOfDate:alarmPicker.date]] != NSOrderedSame, @"wrong time found! %@ != %@", now, alarmPicker.date);
	[tester tapViewWithAccessibilityLabel:@"CancelButton"];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
}

- (void)testUsingAlarmDateCorrectly {
	MainViewController *mainVC = (MainViewController*)[NavigationHelper visiblePhoneViewController];
	id mainVCMock = [OCMockObject partialMockForObject:mainVC];
	[[mainVCMock stub] createLocalNotificationForDate:OCMOCK_ANY];
	[tester tapViewWithAccessibilityLabel:@"AlarmSelectionButton"];
	[tester waitForViewWithAccessibilityLabel:@"AlarmSelectionView"];
	NSDate *now = [NSDate date];
	if ([self isDateIncreasableWithoutDayChange:now]) {
		[tester selectDatePickerValue:@[@"Heute", [@(now.hours + 2) stringValue], [@(now.minutes + 2) stringValue]]];
	} else {
		NSDate *increasedDate = [now dateByAddingTimeInterval:2 * 60 * 60 + 2 * 60];
//		NSDateFormatter *formatter = [NSDateFormatter new];
//		formatter.dateStyle = NSDateFormatterLongStyle;
//		formatter.timeStyle = NSDateFormatterNoStyle;
		NSString *selectedDate = [increasedDate dateStringInDatePickerFormat];
		NSString *selectedHour = [@(now.hours + 2 - 24) stringValue];
		NSString *selectedMinute = [@(now.minutes + 2) stringValue];
		[tester selectDatePickerValue:@[@"12. Nov.", selectedHour, selectedMinute]];
	}
	[tester tapViewWithAccessibilityLabel:@"DoneButton"];
	[tester waitForViewWithAccessibilityLabel:@"MainView"];
	NSString *expectedDateString = [[NSDate normalizeSecondsOfDate:[now dateByAddingTimeInterval:2 * 60 * 60 + 2 * 60]] dateAndTimeString];
	[tester waitForLabelWithAccessibilityLabel:@"AlarmSelectionValueLabel" withText:expectedDateString];
	[mainVCMock stopMocking];
}

#pragma mark -
#pragma mark Helper methods
#pragma mark -

- (BOOL)isDateIncreasableWithoutDayChange:(NSDate *)date {
	NSInteger hours = date.hours;
	date = [date dateByAddingTimeInterval:2 * 60 * 60+ 2 * 60];
	NSInteger increasedHours = date.hours;
	return hours < increasedHours;
}

@end
