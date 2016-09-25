
#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "SoundSelectionCell.h"
#import "Sound.h"

@interface SoundSelectionCellTest : XCTestCase {
	SoundSelectionCell *cell;
	id cellMock;
	id soundMock;
	id labelMock;
}

@end

@interface SoundSelectionCell (Testing)
@property (weak, nonatomic) UILabel *soundNameLabel;
@end

@implementation SoundSelectionCellTest

- (void)setUp {
	[super setUp];
	cell = [SoundSelectionCell new];
	cellMock = [OCMockObject partialMockForObject:cell];
	soundMock = [OCMockObject niceMockForClass:[Sound class]];
	labelMock = [OCMockObject niceMockForClass:[UILabel class]];
	[[[cellMock stub] andReturn:labelMock] soundNameLabel];
}

- (void)tearDown {
	[labelMock stopMocking];
	[soundMock stopMocking];
	[cellMock stopMocking];
	[super tearDown];
}

#pragma mark -
#pragma mark real test methods
#pragma mark -

- (void)testCorrectAwakeFromNib {
	[cell awakeFromNib];
	expect(cell.selectionStyle).equal(UITableViewCellSelectionStyleNone);
}

- (void)testCellSeclectionCorrectly {
	[cell setSelected:YES animated:NO];
	expect(cell.accessoryType).equal(UITableViewCellAccessoryCheckmark);
	[cell setSelected:NO animated:NO];
	expect(cell.accessoryType).equal(UITableViewCellAccessoryNone);
}

- (void)testSetTextOnUpdateCellWithSound {
	NSString *soundName = @"soundName";
	[[[soundMock stub] andReturn:soundName] soundName];
	[[labelMock expect] setText:soundName];
	[cell updateWithSound:soundMock];
	[labelMock verify];
}

#pragma mark -
#pragma mark helper methods
#pragma mark -


@end
