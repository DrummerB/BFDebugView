//
//  BFDebugView.h
//  BFDebugView
//
//  Created by Balázs Faludi on 17.03.14.
//  Copyright (c) 2014 Balazs Faludi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BFDebugView : UIView

@property (nonatomic) CGFloat lineDistance;
@property (nonatomic) CGFloat lineOffset;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic) CGFloat guideLineDistance;
@property (nonatomic) CGFloat guideLineOffset;
@property (nonatomic) CGFloat guideLineWidth;
@property (nonatomic, strong) UIColor *guideLineColor;

@property (nonatomic) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, readonly) UILabel *widthLabel;
@property (nonatomic, readonly) UILabel *heightLabel;
@property (nonatomic, readonly) UILabel *originLabel;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *subTitleLabel;

+ (BFDebugView *)debugViewWithFrame:(CGRect)frame;

@end