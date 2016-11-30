//
//  KIFTestActor+ClockRadio.h
//  ClockRadio
//
//  Created by Andre Heß on 01/10/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <KIF/KIF.h>

@interface KIFUITestActor (ClockRadio)

- (UIButton *)waitForButtonWithAccessibilityLabel:(NSString *)label isTappable:(BOOL)isTappable;

- (UIButton *)waitForButtonWithAccessibilityLabel:(NSString *)label withButtonText:(NSString *)text isTappable:(BOOL)isTappable;

- (UILabel *)waitForLabelWithAccessibilityLabel:(NSString *)label withText:(NSString *)text;

- (BOOL)waitForViewWithAccessiblityLabel:(NSString*)label containingNumberOfCells:(NSInteger)numberOfCells inSection:(NSInteger)section;

- (void)swipeViewWithAccessibilityLabel:(NSString *)label inDirection:(KIFSwipeDirection)direction withStartPoint:(CGPoint)startPoint swipeDistance:(CGFloat)distance;

@end
