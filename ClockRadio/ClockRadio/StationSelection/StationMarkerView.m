//
//  StationMarkerView.m
//  RadioStationSelection
//
//  Created by Andre Hess on 29.11.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import "StationMarkerView.h"

@implementation StationMarkerView

- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ctx);
	CGFloat fillWidth = rect.size.width / 3;
	
	CGContextSetFillColorWithColor(ctx, [UIColor orangeColor].CGColor);
	CGContextFillRect(ctx, CGRectMake(0, rect.origin.y, fillWidth, rect.size.height));

	CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
	CGContextFillRect(ctx, CGRectMake(fillWidth, rect.origin.y, fillWidth, rect.size.height));

	CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:130./255. green:22./255. blue:22./255. alpha:1].CGColor);
	CGContextFillRect(ctx, CGRectMake(2 * fillWidth, rect.origin.y, fillWidth, rect.size.height));

	CGContextRestoreGState(ctx);
}


@end
