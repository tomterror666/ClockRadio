//
//  SelectionButton.m
//  StationSelection
//
//  Created by Andre Hess on 15.11.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "SelectionButton.h"
#import "TwistRecognizer.h"

#define DegreesToRadians(x) ((x) * M_PI / 180.0)
#define RadiansToDegrees(x) ((x) * 180 / M_PI)

@interface SelectionButton ()
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGFloat currentAngle;
@property (nonatomic, strong) UIImageView *backgroundView;
@end

@implementation SelectionButton

- (id)initWithRadius:(CGFloat)radius atCenterPoint:(CGPoint)centerPoint {
	self = [super initWithFrame:CGRectInset(CGRectMake(centerPoint.x, centerPoint.y, 0, 0), -radius, -radius)];
	if (self != nil) {
		//self.backgroundColor = [UIColor blueColor];
		[self configureMe];
	}
	return self;
}

- (void)updateWithRadius:(CGFloat)radius atCenterPoint:(CGPoint)centerPoint {
	[self configureMe];
}

- (void)configureMe {
	self.currentAngle = 0;
	self.startPoint = CGPointZero;
	[self configureBackground];
	[self configureRecog];
}

#pragma mark -
#pragma mark Configuration
#pragma mark -

- (void)configureBackground {
	[self.backgroundView removeFromSuperview];
	self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StationSelectionButton"]];
	self.backgroundView.contentMode = UIViewContentModeScaleAspectFit;
	self.backgroundView.frame = self.bounds;
	[self addSubview:self.backgroundView];
}

- (void)configureRecog {
	TwistRecognizer *recog = [[TwistRecognizer alloc] initWithTarget:self action:@selector(handlePanning:)];
	//UIPanGestureRecognizer *recog = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanning:)];
	[self addGestureRecognizer:recog];
}


#pragma mark -
#pragma mark GestureRecog handling
#pragma mark -

- (void)handlePanning:(TwistRecognizer *)recog {
//	switch (recog.state) {
//		case UIGestureRecognizerStateBegan:
//			self.startPoint = [recog locationInView:self];
//			break;
//		case UIGestureRecognizerStateChanged:
//		{
//			CGFloat angle = [self calcAngleToPoint:[recog locationInView:self]];
//			[self handleAngle:angle];
//			self.currentAngle += [self calcAngleToPoint:[recog locationInView:self]];
//			break;
//		}
//		case UIGestureRecognizerStateEnded:
//		case UIGestureRecognizerStateFailed:
//		case UIGestureRecognizerStateCancelled:
//			//self.currentAngle += [self calcAngleToPoint:[recog locationInView:self]];
//			break;
//		case UIGestureRecognizerStatePossible:
//			break;
//		default:
//			break;
//	}
	SwipeDirection direction = [self calcSwipeDirectionByAngle:recog.angle];
	self.currentAngle += recog.angle;
	[self handleAngle:recog.angle inDirection:direction];
}

- (SwipeDirection)calcSwipeDirectionByAngle:(CGFloat)angle {
	if (angle < 0) return swipeDirectionUpward;
	if (angle > 0) return swipeDirectionDownward;
	return swipeDirectionUnknown;
}

//- (CGFloat)calcAngleToPoint:(CGPoint)point {
//	CGPoint p1 = self.center;
//	CGPoint p2 = [self normalizedPointToCenter:point];
//	CGPoint p3 = [self normalizedPointToCenter:self.startPoint];
////	CGFloat a = sqrt((p2.x-p1.x) * (p2.x-p1.x) + (p2.y-p1.y) * (p2.y-p1.y));
////	CGFloat b = sqrt((p3.x-p2.x) * (p3.x-p2.x) + (p3.y-p2.y) * (p3.y-p2.y));
////	CGFloat c = sqrt((p1.x-p3.x) * (p1.x-p3.x) + (p1.y-p3.y) * (p1.y-p3.y));
//	//return atan2(p2.x - p3.x, p2.y - p3.y);
//	return atan2(p2.y - p1.y, p2.x - p1.x) - atan2(p3.y - p1.y, p3.x - p1.x);
//	//return [self updateDirectionToAngle:acos((b*b-a*a-c*c) / (2*a*c)) toPoint:point];
//	//return [self updateDirectionToAngle:acos((a*a+c*c-b*b) / (2*a*c)) toPoint:point];
//}
//
//- (CGFloat)updateDirectionToAngle:(CGFloat)angle toPoint:(CGPoint)point {
//	CGPoint p1 = [self normalizedPointToCenter:self.startPoint];
//	CGPoint p2 = [self normalizedPointToCenter:point];
//	if (p1.x > 0 && p2.x > 0) {
//		return p1.y > p2.y ? angle : -angle;
//	}
//	if (p1.x < 0 && p2.x < 0) {
//		return p1.y > p2.y ? -angle : angle;
//	}
//	if (p1.y > 0 && p2.y > 0) {
//		return p1.x > p2.x ? -angle : angle;
//	}
//	if (p1.y < 0 && p2.y < 0) {
//		return p1.x > p2.x ? angle : -angle;
//	}
//	return 0;
//}
//
//
//- (CGPoint)normalizedPointToCenter:(CGPoint)point {
//	//return CGPointMake(self.center.x - point.x, self.center.y - point.y);
//	return CGPointMake(point.x - self.bounds.size.width / 2, self.bounds.size.height / 2 - point.y);
//	CGPoint centralized = CGPointMake(self.center.x - point.x, self.center.y - point.y);
//	CGFloat xNeu = sqrt(10000.0/(1 + (centralized.y*centralized.y)/(centralized.x*centralized.x)));
//	CGFloat yNeu = sqrt(10000.0/(1 + (centralized.x*centralized.x)/(centralized.y*centralized.y)));
//	return CGPointMake(xNeu, yNeu);
//}

- (void)handleAngle:(CGFloat)angle inDirection:(SwipeDirection)direction {
	if ([self.delegate respondsToSelector:@selector(selectionButton:willChangeAngleTo:inDirection:)]) {
		[self.delegate selectionButton:self willChangeAngleTo:angle inDirection:direction];
	}
	__weak typeof(self) weakSelf = self;
	[UIView animateWithDuration:0.1
					 animations:^{
						 weakSelf.transform = CGAffineTransformMakeRotation(self.currentAngle + angle);
					 }];
	[self sendAction];
	if ([self.delegate respondsToSelector:@selector(selectionButton:didChangeAngle:inDirection:)]) {
		[self.delegate selectionButton:self didChangeAngle:angle inDirection:direction];
	}
}

- (void)sendAction {
	for (id target in self.allTargets) {
		NSArray *allActionsForValueChange = [self actionsForTarget:target forControlEvent:UIControlEventValueChanged];
		for (NSString *actionString in allActionsForValueChange) {
			SEL action = NSSelectorFromString(actionString);
			if ([target respondsToSelector:action]) {
				[target performSelector:action withObject:nil afterDelay:0];
			}
		}
	}
}

@end
