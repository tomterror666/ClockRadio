//
//  TwistRecognizer.m
//  StationSelection
//
//  Created by Andre Heß on 17/11/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <UIKit/UIGestureRecognizerSubclass.h>
#import "TwistRecognizer.h"

@implementation TwistRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	if ([[event touchesForGestureRecognizer:self] count] > 1) {
		self.state = UIGestureRecognizerStateFailed;
	}
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	if ([self state] == UIGestureRecognizerStatePossible) {
		[self setState:UIGestureRecognizerStateBegan];
	} else {
		[self setState:UIGestureRecognizerStateChanged];
	}
	UITouch *touch = [touches anyObject];
	CGPoint center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
	CGPoint currentPoint = [touch locationInView:self.view];
	CGPoint startPoint = [touch previousLocationInView:self.view];
	self.angle = atan2f(currentPoint.y - center.y, currentPoint.x - center.x) - atan2f(startPoint.y - center.y, startPoint.x - center.x);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	self.state = self.state == UIGestureRecognizerStateChanged ? UIGestureRecognizerStateEnded : UIGestureRecognizerStateFailed;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	self.state = UIGestureRecognizerStateFailed;
}

@end
