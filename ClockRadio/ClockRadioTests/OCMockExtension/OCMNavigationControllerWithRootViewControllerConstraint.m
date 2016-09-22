#import "OCMNavigationControllerWithRootViewControllerConstraint.h"


@implementation OCMNavigationControllerWithRootViewControllerConstraint

- (BOOL)evaluate:(id)value {
	BOOL result = YES;
	result &= [value isKindOfClass:[UINavigationController class]];
	result &= [[(UINavigationController *)value topViewController] isKindOfClass:testClass];
	return result;
}

@end
