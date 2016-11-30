//
//  StationCell.h
//  RadioStationSelection
//
//  Created by Andre Hess on 25.11.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

#define StationCellIdentifier @"stationCellIdentifier"

@class Station;

@interface StationCell : UICollectionViewCell

@property (nonatomic, assign, readonly) CGFloat contentHeight;
@property (nonatomic, assign, readonly) CGFloat contentWidth;
@property (nonatomic, assign, readonly) CGFloat LED_X;
@property (nonatomic, assign, readonly) CGFloat LED_Length;

- (void)updateWithStation:(Station *)station atIndexPath:(NSIndexPath *)indexPath;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

+ (CGSize)expectedCellSize;
+ (CGFloat)cellsLED_X;
+ (CGFloat)cellsLED_Length;

@end
