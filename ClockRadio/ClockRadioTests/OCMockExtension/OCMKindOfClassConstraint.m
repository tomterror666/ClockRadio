#import "OCMKindOfClassConstraint.h"


@implementation OCMKindOfClassConstraint

- (BOOL)evaluate:(id)value {
    return [value isKindOfClass:testClass];
}

@end