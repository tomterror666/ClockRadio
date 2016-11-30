//
//  SelectionButton.h
//  StationSelection
//
//  Created by Andre Hess on 15.11.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectionButton;

typedef enum _swipeDirection {
	swipeDirectionUnknown = 0,
	swipeDirectionUpward,
	swipeDirectionDownward
} SwipeDirection;

@protocol SelectionButtonDelegate <NSObject>

- (void)selectionButton:(SelectionButton *)button willChangeAngleTo:(CGFloat)angle inDirection:(SwipeDirection)direction;
- (void)selectionButton:(SelectionButton *)button didChangeAngle:(CGFloat)angle inDirection:(SwipeDirection)direction;

@end

@interface SelectionButton : UIControl

@property (nonatomic, assign) id<SelectionButtonDelegate> delegate;
@property (nonatomic, assign, readonly) CGFloat currentAngle;

- (id)initWithRadius:(CGFloat)radius atCenterPoint:(CGPoint)centerPoint;

- (void)updateWithRadius:(CGFloat)radius atCenterPoint:(CGPoint)centerPoint;

@end
