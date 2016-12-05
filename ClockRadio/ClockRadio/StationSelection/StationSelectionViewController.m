//
//  StationSelectionViewController.m
//  RadioStationSelection
//
//  Created by Andre Hess on 29.11.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "StationSelectionViewController.h"
#import "Station.h"
#import "StationCell.h"
#import "StationSelectionLayout.h"
#import "SelectionButton.h"
#import "StationProvider.h"
#import "TuneinProvider.h"
#import "StationTuneinDetails.h"
#import <StreamingKit/STKAudioPlayer.h>

#define ButtonMargin   10
#define TwisingSpeed   100
#define MovementMargin 3

@interface StationSelectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SelectionButtonDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *stationSelectionCollectionView;
@property (weak, nonatomic) IBOutlet UIView *stationSelectionMarkerView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *useButton;
//@property (nonatomic, strong) NSMutableArray *stations;
@property (nonatomic, weak) IBOutlet SelectionButton *stationSelectionButton;
@property (nonatomic, strong) StationProvider *stationProvider;
@property (nonatomic, strong) TuneinProvider *tuneinProvider;
@property (nonatomic, strong) Station *currentSelectedStation;
@end

@implementation StationSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self != nil) {
		[self registerNotifications];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self != nil) {
		[self registerNotifications];
	}
	return self;
}

- (void)dealloc {
	[self unregisterNotifications];
}

- (void)registerNotifications {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRotation:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)unregisterNotifications {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.stationProvider = [StationProvider sharedProvider];
	self.tuneinProvider = [TuneinProvider sharedProvider];
//	self.stations = [NSMutableArray new];
//	for (NSInteger counter = 1; counter < 21; counter++) {
//		Station* station = [Station new];
//		station.name = [@"SuperStation " stringByAppendingFormat:@"%ld", (long)counter];
//		station.genere = @"Punk is not dead";
//		station.listeners = 285730 - counter * 8583;
//		[self.stations addObject:station];
//	}
	
	[self configureSubviews];
	[self configureStationSelectionButton];
	[self configureBackground];
	[self configureAccessibilityLabels];
	[self refreshView];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	//	NSIndexPath *firstCellPaht = [NSIndexPath indexPathForItem:0 inSection:0];
	//	CGSize cellSize = [self collectionView:self.stationSelectionCollectionView 
	//									layout:self.stationSelectionCollectionView.collectionViewLayout
	//					sizeForItemAtIndexPath:firstCellPaht];
	//	StationCell *cell = (StationCell *)[self.stationSelectionCollectionView cellForItemAtIndexPath:firstCellPaht];
	//	NSInteger numberOfPossibleRowsInCell = cellSize.height / cell.contentHeight;
	//	NSInteger numberOfLanes = ([self.stations count] / numberOfPossibleRowsInCell) + 1;
	//	self.stationSelectionCollectionView.contentSize = CGSizeMake(([self.stations count] - 1) * cell.bounds.size.width + cell.contentWidth, self.stationSelectionCollectionView.contentSize.height);
}

#pragma mark -
#pragma mark Configuration
#pragma mark -

- (void)configureSubviews {
	[self configureCollectionView];
	[self configureButtons];
}

- (void)configureCollectionView {
	[self.stationSelectionCollectionView registerNib:[UINib nibWithNibName:@"StationCell" bundle:nil] forCellWithReuseIdentifier:StationCellIdentifier];
	//self.stationSelectionCollectionView.collectionViewLayout = [StationSelectionLayout new];
	self.stationSelectionCollectionView.layer.cornerRadius = 12.;
	self.stationSelectionCollectionView.layer.masksToBounds = YES;
	self.stationSelectionCollectionView.layer.borderColor = [UIColor colorWithRed:218./255. green:165./255. blue:21./255. alpha:1].CGColor;
	self.stationSelectionCollectionView.layer.borderWidth = 2;
}

- (void)configureStationSelectionButton {
//	[self.stationSelectionButton removeFromSuperview];
	CGFloat radius = 45.;
//	self.stationSelectionButton = [[SelectionButton alloc] initWithRadius:radius
//															atCenterPoint:CGPointMake(self.view.bounds.size.width - radius - self.stationSelectionCollectionView.frame.origin.x, self.view.bounds.size.height - ButtonMargin - radius)];
//	self.stationSelectionButton.delegate = self;
////	self.stationSelectionButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin & UIViewAutoresizingFlexibleTopMargin;
//	[self.view addSubview:self.stationSelectionButton];
//	NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.stationSelectionButton 
//																	   attribute:NSLayoutAttributeWidth 
//																	   relatedBy:NSLayoutRelationEqual
//																		  toItem:nil
//																	   attribute:NSLayoutAttributeWidth
//																	  multiplier:1 
//																		constant:2 * radius];
//	NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.stationSelectionButton 
//																		attribute:NSLayoutAttributeHeight
//																		relatedBy:NSLayoutRelationEqual
//																		   toItem:nil
//																		attribute:NSLayoutAttributeHeight
//																	   multiplier:1 
//																		 constant:2 * radius];
//	NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.stationSelectionButton
//																		  attribute:NSLayoutAttributeTrailing
//																		  relatedBy:NSLayoutRelationEqual
//																			 toItem:self.stationSelectionCollectionView
//																		  attribute:NSLayoutAttributeTrailing
//																		 multiplier:1
//																		   constant:0];
//	NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.view
//																		attribute:NSLayoutAttributeBottom
//																		relatedBy:NSLayoutRelationEqual
//																		   toItem:self.stationSelectionButton
//																		attribute:NSLayoutAttributeBottom
//																	   multiplier:1
//																		 constant:ButtonMargin];
//	[self.stationSelectionButton addConstraints:@[widthConstraint, heightConstraint, trailingConstraint, bottomConstraint]];
//	[self.view setNeedsUpdateConstraints];
	[self.stationSelectionButton updateWithRadius:radius atCenterPoint:self.stationSelectionButton.center];
	self.stationSelectionButton.delegate = self;
}

- (void)configureBackground {
	self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
	self.backgroundImageView.image = [UIImage imageNamed:@"holz-textur"];
}

- (void)configureButtons {
	self.useButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
	self.backButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
	[self.useButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	self.useButton.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
	self.backButton.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
	self.useButton.layer.cornerRadius = 4;
	self.backButton.layer.cornerRadius = 4;
	self.useButton.layer.masksToBounds = YES;
	self.backButton.layer.masksToBounds = YES;
}

- (void)configureAccessibilityLabels {
	self.view.accessibilityLabel = @"RadioStationSelectionView";
	self.stationSelectionCollectionView.accessibilityLabel = @"StationSelectionCollectionView";
	self.backButton.accessibilityLabel = @"CancelButton";
	self.useButton.accessibilityLabel = @"UseButton";
	self.stationSelectionButton.accessibilityLabel = @"SelectionButton";
}

#pragma mark -
#pragma mark Data handling and updating
#pragma mark -

- (void)refreshView {
	[self updateUI];
	__weak typeof(self) weakSelf = self;
	[self.stationProvider loadStationsWithCompletion:^(id stationsJson, NSError *error) {
		[weakSelf updateUI];
	}];
}

- (void)updateUI {
	__weak typeof(self) weakSelf = self;
	dispatch_async(dispatch_get_main_queue(), ^{
		[weakSelf.stationSelectionCollectionView reloadData];
		[weakSelf checkCellSelection];
	});
}


#pragma mark -
#pragma mark UICollectionViewDelegate & UICollectionViewDataSource
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self.stationProvider numberOfRadioStations];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:StationCellIdentifier forIndexPath:indexPath];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
	StationCell *stationCell = (StationCell *)cell;
	[stationCell updateWithStation:[self.stationProvider radioStationAtIndexPath:indexPath] atIndexPath:indexPath];
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
//	return CGSizeMake(14, self.stationSelectionCollectionView.bounds.size.height);
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//	return 0;
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//	return 0;
//}


#pragma mark -
#pragma mark Rotation support
#pragma mark -

- (void)handleRotation:(NSNotification *)notification {
	[self.stationSelectionCollectionView reloadData];
	[self configureStationSelectionButton];
	__weak typeof(self) weakSelf = self;
	dispatch_async(dispatch_get_main_queue(), ^{
		[weakSelf checkCellSelection];
	});
}


#pragma mark -
#pragma mark SelectionButtonDelegate
#pragma mark -

- (void)selectionButton:(SelectionButton *)button willChangeAngleTo:(CGFloat)angle inDirection:(SwipeDirection)direction {
	
}

- (void)selectionButton:(SelectionButton *)button didChangeAngle:(CGFloat)angle inDirection:(SwipeDirection)direction {
	CGFloat movement = TwisingSpeed * angle;
	switch (direction) {
		case swipeDirectionUpward:
			if (self.stationSelectionCollectionView.contentOffset.x + movement > -MovementMargin) {
				self.stationSelectionCollectionView.contentOffset = CGPointMake(self.stationSelectionCollectionView.contentOffset.x + movement, self.stationSelectionCollectionView.contentOffset.y);
			}
			break;
		case swipeDirectionDownward:
			if (self.stationSelectionCollectionView.contentOffset.x + movement < self.stationSelectionCollectionView.contentSize.width - self.stationSelectionCollectionView.bounds.size.width + MovementMargin) {
				self.stationSelectionCollectionView.contentOffset = CGPointMake(self.stationSelectionCollectionView.contentOffset.x + movement, self.stationSelectionCollectionView.contentOffset.y);
			}
			break;
		default:
			break;
	}
	[self checkCellSelection];
}

- (void)checkCellSelection {
	__block BOOL isAtleastOneLEDOn = NO;
	for (StationCell *cell in self.stationSelectionCollectionView.visibleCells) {
		CGRect selectionMarkerFrame = [cell convertRect:self.stationSelectionMarkerView.frame fromView:self.view];
		BOOL isSelected = (selectionMarkerFrame.origin.x > [StationCell cellsLED_X]) && (selectionMarkerFrame.origin.x < cell.LED_X + cell.LED_Length);
		[cell setSelected:isSelected animated:YES];
		if (isSelected) {
			isAtleastOneLEDOn = YES;
			NSIndexPath *cellPath = [self.stationSelectionCollectionView indexPathForCell:cell];
			if (self.currentSelectedStation == nil || ![self.currentSelectedStation isEqual:[self.stationProvider radioStationAtIndexPath:cellPath]]) {
				self.currentSelectedStation = [self.stationProvider radioStationAtIndexPath:cellPath];
				NSLog(@"Selected radio station id: %@ name: %@", self.currentSelectedStation.stationId, self.currentSelectedStation.stationName);
				__weak typeof(self) weakSelf = self;
				[self.tuneinProvider loadTuneinDataWithStationId:self.currentSelectedStation.stationId
												   forTuneinBase:self.stationProvider.tuneinBase
												  withCompletion:^(id tuneinData, NSError *error) {
													  if (error == nil && weakSelf.tuneinProvider.tuneinDetails.numberOfEntries > 0) {
														  NSURL *url = [NSURL URLWithString:weakSelf.tuneinProvider.tuneinDetails.fileURLStrings[0]];
														  STKDataSource* dataSource = [STKAudioPlayer dataSourceFromURL:url];
														  [weakSelf.audioPlayer queueDataSource:dataSource withQueueItemId:@0];
													  }
												  }];
			}
		}
	}
	if (!isAtleastOneLEDOn) {
		self.currentSelectedStation = nil;
		[self.audioPlayer stop];
	}
}

#pragma mark -
#pragma mark Button handling
#pragma mark -

- (IBAction)backButtonTouched:(id)sender {
	if ([self.delegate respondsToSelector:@selector(stationSelectionViewControllerDidCancel:)]) {
		[self.delegate stationSelectionViewControllerDidCancel:self];
	}
}

- (IBAction)useButtonTouched:(id)sender {
	if ([self.delegate respondsToSelector:@selector(stationSelectionViewController:didFinsishWithStation:)]) {
		[self.delegate stationSelectionViewController:self didFinsishWithStation:self.currentSelectedStation];
	}
}

@end
