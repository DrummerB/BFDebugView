//
//  BFDebugRenderer.h
//  BFDebugView
//
//  Created by Balázs Faludi on 17.03.14.
//  Copyright (c) 2014 Balazs Faludi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFDebugRenderer : NSObject

+ (void)drawGridInRect:(CGRect)rect withDistance:(CGFloat)lineDistance offset:(CGFloat)lineOffset width:(CGFloat)lineWidth color:(UIColor *)lineColor;
+ (void)drawRect:(CGRect)rect width:(CGFloat)width color:(UIColor *)color;

@end