
#import "UIScrollView+AccessibilityLabelExtension.h"

@implementation UIScrollView (AccessibilityLabelExtension)

- (void)setAccessibilityLabel:(NSString *)accessibilityLabel {
	self.accessibilityIdentifier = accessibilityLabel;
	[super setAccessibilityLabel:accessibilityLabel];
}

@end
