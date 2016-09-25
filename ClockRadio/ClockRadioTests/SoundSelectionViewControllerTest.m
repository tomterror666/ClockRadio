
#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "SoundSelectionViewController.h"
#import "Sound.h"
#import "SoundSelectionCell.h"

@interface SoundSelectionViewControllerTest : XCTestCase {
	SoundSelectionViewController *controller;
	id controllerMock;
	id tableViewMock;
	id delegateMock;
	id soundMock;
	id cellMock;
}

@end

@interface SoundSelectionViewController (Testing)
@property (weak, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *programmSoundFiles;
@property (nonatomic, strong) NSMutableArray *soundFiles;
- (void)refreshView;
- (void)configureTableView;
- (void)loadProgrammSounds;
- (void)cancelButtonTouched:(id)sender;
- (void)doneButtonTouched:(id)sender;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)playSoundWithURL:(NSURL *)url;
@end

@implementation SoundSelectionViewControllerTest

- (void)setUp {
	[super setUp];
	controller = [SoundSelectionViewController new];
	controllerMock = [OCMockObject partialMockForObject:controller];
	tableViewMock = [OCMockObject niceMockForClass:[UITableView class]];
	[[[controllerMock stub] andReturn:tableViewMock] tableView];
	delegateMock = [OCMockObject niceMockForProtocol:@protocol(SoundSelectionDelegate)];
	[[[controllerMock stub] andReturn:delegateMock] delegate];
	soundMock = [OCMockObject niceMockForClass:[Sound class]];
	cellMock = [OCMockObject niceMockForClass:[SoundSelectionCell class]];
}

- (void)tearDown {
	[cellMock stopMocking];
	[soundMock stopMocking];
	[delegateMock stopMocking];
	[tableViewMock stopMocking];
	[controllerMock stopMocking];
	[super tearDown];
}

#pragma mark -
#pragma mark real test methods
#pragma mark -

- (void)testRefreshViewOnViewDidLoad {
	[[controllerMock expect] refreshView];
	[controller viewDidLoad];
	[controllerMock verify];
}

- (void)testConfigureTableViewOnRefreshView {
	[[controllerMock expect] configureTableView];
	[controller refreshView];
	[controllerMock verify];
}

- (void)testLoadProgrammSoundsOnRefreshView {
	[[controllerMock expect] loadProgrammSounds];
	[controller refreshView];
	[controllerMock verify];
}

- (void)testSoundSelectionViewControllerDidCancelOnCancelButtonTouched {
	[[delegateMock expect] soundSelectionViewControllerDidCancel:controller];
	[controller cancelButtonTouched:OCMOCK_ANY];
	[delegateMock verify];
}

- (void)testSoundSelectionViewControllerDidFinishWithSoundOnDoneButtonTouched {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[[[tableViewMock stub] andReturn:indexPath] indexPathForSelectedRow];
	[[[controllerMock stub] andReturn:[@[soundMock] mutableCopy]] programmSoundFiles];
	[[delegateMock expect] soundSelectionViewController:controller didFinishWithSound:soundMock];
	[controller doneButtonTouched:OCMOCK_ANY];
	[delegateMock verify];
}

- (void)testCorrectNumbersOfSections {
	[[[controllerMock stub] andReturn:@[]] soundFiles];
	expect([controller numberOfSectionsInTableView:tableViewMock]).equal(1);
}

- (void)testCorrectNumberOfRowsInSections {
	NSArray *programmSounds = @[@"44", @"55"];
	NSArray *sounds = @[@"111", @"222", @"333"];
	[[[controllerMock stub] andReturn:programmSounds] programmSoundFiles];
	[[[controllerMock stub] andReturn:sounds] soundFiles];
	expect([controller tableView:tableViewMock numberOfRowsInSection:0]).equal([programmSounds count]);
	expect([controller tableView:tableViewMock numberOfRowsInSection:1]).equal([sounds count]);
}

- (void)testDequeueReusableCellWithIdentifierOnCellForRowAtIndexPath {
	[[tableViewMock expect] dequeueReusableCellWithIdentifier:SoundSelectionCellIdentifier];
	[controller tableView:tableViewMock cellForRowAtIndexPath:OCMOCK_ANY];
	[tableViewMock verify];
}

- (void)testUpdateWithProgrammSoundOnWillDisplayRowAtIndexPath {
	NSArray *programmSounds = @[soundMock];
	[[[controllerMock stub] andReturn:programmSounds] programmSoundFiles];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[[cellMock expect] updateWithSound:soundMock];
	[controller tableView:tableViewMock willDisplayCell:cellMock forRowAtIndexPath:indexPath];
	[cellMock verify];
}

- (void)testUpdateWithSoundOnWillDisplayRowAtIndexPath {
	NSArray *sounds = @[soundMock];
	[[[controllerMock stub] andReturn:sounds] soundFiles];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
	[[cellMock expect] updateWithSound:soundMock];
	[controller tableView:tableViewMock willDisplayCell:cellMock forRowAtIndexPath:indexPath];
	[cellMock verify];
}

- (void)testCorrectHeightOfRowAtIndexPath {
	expect([controller tableView:tableViewMock heightForRowAtIndexPath:OCMOCK_ANY]).equal(50);
}

- (void)testPlaySoundOnDidSelectRowAtIndexPath {
	NSURL *soundUrl = [NSURL URLWithString:@"https://www.google.com"];
	[[[soundMock stub] andReturn:soundUrl] soundURL];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[[[controllerMock stub] andReturn:@[soundMock]] programmSoundFiles];
	[[controllerMock expect] playSoundWithURL:soundUrl];
	[controller tableView:tableViewMock didSelectRowAtIndexPath:indexPath];
	[controllerMock verify];
}

#pragma mark -
#pragma mark helper methods
#pragma mark -


@end
