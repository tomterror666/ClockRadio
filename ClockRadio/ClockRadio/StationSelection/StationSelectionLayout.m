//
//  StationSelectionLayout.m
//  RadioStationSelection
//
//  Created by Andre Heß on 26/11/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "StationSelectionLayout.h"
#import "StationCell.h"

@interface StationSelectionLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributes;
@property (nonatomic, assign) CGRect collectionViewFrame;
@property (nonatomic, assign) CGFloat contentWidth;
@end

@implementation StationSelectionLayout

- (void)prepareLayout {
	if ((self.attributes != nil && CGRectEqualToRect(self.collectionView.frame, self.collectionViewFrame)) ||
		([self.collectionView numberOfItemsInSection:0] == 0)){
		return;
	}
	self.collectionViewFrame = self.collectionView.frame;
	self.attributes = [NSMutableArray new];
	
	CGSize cellSize = [StationCell expectedCellSize];
	NSInteger numberOfItemsInRow = self.collectionViewFrame.size.height / cellSize.height;
	CGFloat stepPlace = cellSize.width / numberOfItemsInRow;
	NSInteger numberOfCells = [self.collectionView numberOfItemsInSection:0];
	//CGFloat firstCellAddition = (self.collectionViewFrame.size.width - stepPlace) / 2;
	CGFloat firstCellAddition = self.collectionViewFrame.size.width / 2 - [StationCell cellsLED_X] - [StationCell cellsLED_Length] / 2;
	CGFloat lastCellAddition = (self.collectionViewFrame.size.width + stepPlace) / 2;
	UICollectionViewLayoutAttributes *firstAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
	firstAttribute.frame = CGRectMake(0,
									  self.collectionViewFrame.size.height - cellSize.height,
									  firstCellAddition + cellSize.width,
									  cellSize.height);
	[self.attributes addObject:firstAttribute];
	for (NSInteger counter = 1; counter < numberOfCells - 1; counter++) {
		NSIndexPath *currentCellPath = [NSIndexPath indexPathForItem:counter inSection:0];
		CGFloat cellX = counter % numberOfItemsInRow * stepPlace + (counter / numberOfItemsInRow) * cellSize.width + firstCellAddition;
		CGFloat cellY = self.collectionViewFrame.size.height - ((counter % numberOfItemsInRow) + 1) * cellSize.height;
		UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:currentCellPath];
		attribute.frame = CGRectMake(cellX, cellY, cellSize.width, cellSize.height);
		[self.attributes addObject:attribute];
	}
	UICollectionViewLayoutAttributes *lastAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:numberOfCells - 1 inSection:0]];
	lastAttribute.frame = CGRectMake((numberOfCells - 1)  % numberOfItemsInRow * stepPlace + ((numberOfCells - 1) / numberOfItemsInRow) * cellSize.width + firstCellAddition,
									 self.collectionViewFrame.size.height - (((numberOfCells - 1) % numberOfItemsInRow) + 1) * cellSize.height,
									 MAX(cellSize.width, lastCellAddition),
									 cellSize.height);
	[self.attributes addObject:lastAttribute];
	self.contentWidth = firstCellAddition + (numberOfCells - 1) * stepPlace + MAX(cellSize.width, lastCellAddition);
}

- (CGSize)collectionViewContentSize {
	return CGSizeMake(self.contentWidth, self.collectionViewFrame.size.height);
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
	NSMutableArray<UICollectionViewLayoutAttributes *> *resultAttributes = [NSMutableArray new];
	for (UICollectionViewLayoutAttributes *attribute in self.attributes) {
		if (CGRectIntersectsRect(attribute.frame, rect)) {
			[resultAttributes addObject:attribute];
		}
	}
	return resultAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	return self.attributes[indexPath.row];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
	return YES;
}

@end
