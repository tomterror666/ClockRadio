//
//  KIFTestActor+ClockRadio.m
//  ClockRadio
//
//  Created by Andre Heß on 01/10/16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "KIFTestActor+ClockRadio.h"
#import <NSError-KIFAdditions.h>

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

@end
