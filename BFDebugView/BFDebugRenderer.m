//
//  BFDebugRenderer.m
//  BFDebugView
//
//  Created by Balázs Faludi on 17.03.14.
//  Copyright (c) 2014 Balazs Faludi. All rights reserved.
//

#import "BFDebugRenderer.h"

@implementation BFDebugRenderer

+ (void)drawGridInRect:(CGRect)rect
		  withDistance:(CGFloat)lineDistance
				offset:(CGFloat)lineOffset
				 width:(CGFloat)lineWidth
				 color:(UIColor *)lineColor {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat currentOffset = fmodf(lineOffset, lineDistance) + 0.5f;
	CGFloat width = rect.size.width;
	CGFloat height = rect.size.height;
	while (currentOffset <= width || currentOffset <= height) {
		CGContextMoveToPoint(context, 0.0f, currentOffset);
		CGContextAddLineToPoint(context, width, currentOffset);
		CGContextMoveToPoint(context, currentOffset, 0.0f);
		CGContextAddLineToPoint(context, currentOffset, height);
		currentOffset += lineDistance;
	}
	CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
	CGContextSetLineWidth(context, lineWidth);
	CGContextStrokePath(context);
}

+ (void)drawRect:(CGRect)rect width:(CGFloat)width color:(UIColor *)color {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(context, color.CGColor);
	CGContextSetLineWidth(context, width);
	CGContextStrokeRect(context, rect);
}

@end
