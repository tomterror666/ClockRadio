#import "OCMConstraint+Extensions.h"
#import "OCMKindOfClassConstraint.h"
#import "OCMNavigationControllerWithRootViewControllerConstraint.h"


@implementation OCMConstraint (Extensions)

+ (id)isKindOfClass:(id)value {
    OCMKindOfClassConstraint *constraint = [OCMKindOfClassConstraint constraint];
    constraint->testClass = value;
    return constraint;
}

+ (id)isNavigationControllerWithRootViewController:(id)value {
	OCMNavigationControllerWithRootViewControllerConstraint *constraint = [OCMNavigationControllerWithRootViewControllerConstraint constraint];
	constraint->testClass = value;
	return constraint;
}


@end