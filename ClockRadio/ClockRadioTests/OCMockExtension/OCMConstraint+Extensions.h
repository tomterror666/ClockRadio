#import <Foundation/Foundation.h>
#import "OCMConstraint.h"

@interface OCMConstraint (Extensions)

+ (id)isKindOfClass:(id)value;
#define MHOCM_isKindOfClass(variable) ([OCMConstraint isKindOfClass:(variable)])

+ (id)isNavigationControllerWithRootViewController:(id)value;
#define MHOCM_isNavigationControllerWithRootViewControllerOfClass(variable) ([OCMConstraint isNavigationControllerWithRootViewController:(variable)])

@end