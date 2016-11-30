//
//  KIFTestActor+ClockRadio.m
//  ClockRadio
//
//  Created by Andre Heß on 01/10/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "KIFTestActor+ClockRadio.h"
#import <NSError-KIFAdditions.h>
#import "CGGeometry-KIFAdditions.h"

#define kSwipeDisplacement 5

@implementation KIFUITestActor (ClockRadio)

- (UIButton *)waitForButtonWithAccessibilityLabel:(NSString *)label isTappable:(BOOL)isTappable {
	UIView *view = [self waitForViewWithAccessibilityLabel:label];
	if (![view isKindOfClass:[UIButton class]]) {
		NSError *error = [NSError KIFErrorWithFormat:@"Found view with accessibility label %@ but this is not a button!", label];
		[self failWithError:error stopTest:NO];
		return nil;
	}
	UIButton *waitedFor = (UIButton *)view;
	if (waitedFor.enabled != isTappable) {
		NSError *error = [NSError KIFErrorWithFormat:@"Found button with accessibility label %@ but %@ tappable!", label, isTappable ? @"is not" : @"is"];
		[self failWithError:error stopTest:NO];
		return nil;
	}
	return waitedFor;
}

- (UIButton *)waitForButtonWithAccessibilityLabel:(NSString *)label withButtonText:(NSString *)text isTappable:(BOOL)isTappable {
	UIView *view = [self waitForViewWithAccessibilityLabel:label];
	if (![view isKindOfClass:[UIButton class]]) {
		NSError *error = [NSError KIFErrorWithFormat:@"Found view with accessibility label %@ but this is not a button!", label];
		[self failWithError:error stopTest:NO];
		return nil;
	}
	UIButton *waitedFor = (UIButton *)view;
	if (![waitedFor.titleLabel.text isEqualToString:text]) {
		NSError *error = [NSError KIFErrorWithFormat:@"Found button with accessibility label %@ but with button text %@ instead %@!", label, waitedFor.titleLabel.text, text];
		[self failWithError:error stopTest:NO];
		return nil;
	}
	if (waitedFor.enabled != isTappable) {
		NSError *error = [NSError KIFErrorWithFormat:@"Found button with accessibility label %@ but %@ tappable!", label, isTappable ? @"is not" : @"is"];
		[self failWithError:error stopTest:NO];
		return nil;
	}
	return waitedFor;
}

- (UILabel *)waitForLabelWithAccessibilityLabel:(NSString *)label withText:(NSString *)text {
	UIView *view = [self waitForViewWithAccessibilityLabel:label];
	if (![view isKindOfClass:[UILabel class]]) {
		NSError *error = [NSError KIFErrorWithFormat:@"Found view with accessibility label %@ but this is not a label!", label];
		[self failWithError:error stopTest:NO];
		return nil;
	}
	UILabel *waitedFor = (UILabel *)view;
	if (![waitedFor.text isEqualToString:text] && ([text length] > 0 || [waitedFor.text length] > 0)) {
		NSError *error = [NSError KIFErrorWithFormat:@"Found label with accessibility label %@ but with text %@ instead %@!", label, waitedFor.text, text];
		[self failWithError:error stopTest:NO];
		return nil;
	}
	return waitedFor;
}

- (BOOL)waitForViewWithAccessiblityLabel:(NSString*)label containingNumberOfCells:(NSInteger)numberOfCells inSection:(NSInteger)section {
	UIView* view = [self waitForViewWithAccessibilityLabel:label];
	UITableView* tableView = [view isKindOfClass:[UITableView class]] ? (UITableView*)view : nil;
	UICollectionView* collectionView = [view isKindOfClass:[UICollectionView class]] ? (UICollectionView*)view : nil;
	if (tableView != nil) {
		NSInteger numberOfSections = [tableView numberOfSections];
		if (numberOfSections > section) {
			NSInteger numberOfRowsInSection = [tableView numberOfRowsInSection:section];
			BOOL isValid = (numberOfRowsInSection == numberOfCells);
			if (!isValid) {
				NSError *error = [NSError KIFErrorWithFormat:@"Found table view with accesibility label \"%@\", but expected number of cells %ld is not equal to number of rows %ld in section %ld.", label, (long)numberOfCells, (long)numberOfRowsInSection, (long)section];
				[self failWithError:error stopTest:YES];
			}
			return isValid;
		} else {
			NSError *error = [NSError KIFErrorWithFormat:@"Found table view with accesibility label \"%@\", but expected number of found sections %ld is less than number of expected section %ld.", label, (long)numberOfSections, (long)section];
			[self failWithError:error stopTest:YES];
		}
	}
	else if (collectionView != nil) {
		NSInteger numberOfSections = [collectionView numberOfSections];
		if (numberOfSections > section) {
			NSInteger numberOfItemsInSection = [collectionView numberOfItemsInSection:section];
			BOOL isValid = (numberOfItemsInSection == numberOfCells);
			if (!isValid) {
				NSError *error = [NSError KIFErrorWithFormat:@"Found collection view with accesibility label \"%@\", but expected number of items %ld is not equal to number of items %ld in section %ld.", label, (long)numberOfCells, (long)numberOfItemsInSection, (long)section];
				[self failWithError:error stopTest:YES];
			}
			return isValid;
		} else {
			NSError *error = [NSError KIFErrorWithFormat:@"Found collection view with accesibility label \"%@\", but expected number of found sections %ld is less than number of expected section %ld.", label, (long)numberOfSections, (long)section];
			[self failWithError:error stopTest:YES];
		}
	}
	NSError *error = [NSError KIFErrorWithFormat:@"View with accesibility label \"%@\", is neither a table view nor a collection view", label];
	[self failWithError:error stopTest:YES];
	return NO;
}

- (void)swipeViewWithAccessibilityLabel:(NSString *)label inDirection:(KIFSwipeDirection)direction withStartPoint:(CGPoint)startPoint swipeDistance:(CGFloat)distance
{
	[self swipeViewWithAccessibilityLabel:label value:nil traits:UIAccessibilityTraitNone inDirection:direction withStartPoint:startPoint swipeDistance:distance];
}

- (void)swipeViewWithAccessibilityLabel:(NSString *)label value:(NSString *)value traits:(UIAccessibilityTraits)traits inDirection:(KIFSwipeDirection)direction withStartPoint:(CGPoint)startPoint swipeDistance:(CGFloat)distance
{
	UIView *viewToSwipe = nil;
	UIAccessibilityElement *element = nil;
	
	[self waitForAccessibilityElement:&element view:&viewToSwipe withLabel:label value:value traits:traits tappable:YES];
	
	[self swipeAccessibilityElement:element inView:viewToSwipe inDirection:direction withStartPoint:startPoint swipeDistance:distance];
}

- (void)swipeAccessibilityElement:(UIAccessibilityElement *)element inView:(UIView *)viewToSwipe inDirection:(KIFSwipeDirection)direction withStartPoint:(CGPoint)startPoint swipeDistance:(CGFloat)distance
{
	// The original version of this came from http://groups.google.com/group/kif-framework/browse_thread/thread/df3f47eff9f5ac8c
	
	const NSUInteger kNumberOfPointsInSwipePath = 20;
	
	// Within this method, all geometry is done in the coordinate system of the view to swipe.
	CGRect elementFrame = [self elementFrameForElement:element andView:viewToSwipe];
	
	KIFDisplacement swipeDisplacement = [self displacementForSwipingInDirection:direction withDistance:distance];
	
	[viewToSwipe dragFromPoint:startPoint displacement:swipeDisplacement steps:kNumberOfPointsInSwipePath];
}

- (KIFDisplacement)displacementForSwipingInDirection:(KIFSwipeDirection)direction withDistance:(CGFloat)distance {
	switch (direction) {
			// As discovered on the Frank mailing lists, it won't register as a
			// swipe if you move purely horizontally or vertically, so need a
			// slight orthogonal offset too.
		case KIFSwipeDirectionRight:
			return CGPointMake(distance, kSwipeDisplacement);
		case KIFSwipeDirectionLeft:
			return CGPointMake(-distance, kSwipeDisplacement);
		case KIFSwipeDirectionUp:
			return CGPointMake(kSwipeDisplacement, -distance);
		case KIFSwipeDirectionDown:
			return CGPointMake(kSwipeDisplacement, distance);
	}
}

- (CGRect) elementFrameForElement:(UIAccessibilityElement *)element andView:(UIView *)view
{
	CGRect elementFrame;
	
	// If the accessibilityFrame is not set, fallback to the view frame.
	if (CGRectEqualToRect(CGRectZero, element.accessibilityFrame)) {
		elementFrame.origin = CGPointZero;
		elementFrame.size = view.frame.size;
	} else {
		elementFrame = [view.windowOrIdentityWindow convertRect:element.accessibilityFrame toView:view];
	}
	return elementFrame;
}


@end
