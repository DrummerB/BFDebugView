//
//  BFDebugView.m
//  BFDebugView
//
//  Created by Balázs Faludi on 17.03.14.
//  Copyright (c) 2014 Balazs Faludi. All rights reserved.
//

#import "BFDebugView.h"
#import "BFDebugRenderer.h"

#define kBFDebugViewFontSize 10.0f

@implementation BFDebugView {
	UIView *_containerView;
}

#pragma mark -
#pragma mark Initialization & Destruction

- (void)setup {
	_lineDistance = 10.0f;
	_guideLineDistance = 50.0f;
	_lineOffset = 0.0f;
	_guideLineOffset = 0.0f;
	_lineWidth = 1.0f;
	_guideLineWidth = 2.0f;
	_borderWidth = 1.5f;
	_borderColor = [UIColor colorWithRed:0.382 green:0.466 blue:0.663 alpha:1.000];
	
	_containerView = [[UIView alloc] init];
	_containerView.translatesAutoresizingMaskIntoConstraints = NO;
	
	_widthLabel = [[UILabel alloc] init];
	_heightLabel = [[UILabel alloc] init];
	_originLabel = [[UILabel alloc] init];
	_titleLabel = [[UILabel alloc] init];
	_subTitleLabel = [[UILabel alloc] init];
	
	[self addSubview:_widthLabel];
	[self addSubview:_heightLabel];
	[self addSubview:_originLabel];
	[self addSubview:_containerView];
	[_containerView addSubview:_titleLabel];
	[_containerView addSubview:_subTitleLabel];
	
	NSArray *labels = @[_widthLabel, _heightLabel, _originLabel, _titleLabel, _subTitleLabel];
	for (UILabel *label in labels) {
		label.translatesAutoresizingMaskIntoConstraints = NO;
		label.textColor = _borderColor;
		label.font = [UIFont boldSystemFontOfSize:kBFDebugViewFontSize];
	}
	
	_titleLabel.font = [_titleLabel.font fontWithSize:kBFDebugViewFontSize + 2];
	
	NSDictionary *views = @{@"width" : _widthLabel,
							@"height" : _heightLabel,
							@"origin" : _originLabel,
							@"title" : _titleLabel,
							@"subtitle" : _subTitleLabel,
							@"container" : _containerView};
	NSDictionary *metrics = @{@"margin" : @(5)};
	NSLayoutConstraint *constraint;
	NSArray *constraints;
	
	// Constrain origin label
	constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(margin)-[origin]" options:0 metrics:metrics views:views];
	[self addConstraints:constraints];
	constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(margin)-[origin]" options:0 metrics:metrics views:views];
	[self addConstraints:constraints];
	
	// Constrain width label
	constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(margin)-[width]" options:0 metrics:metrics views:views];
	[self addConstraints:constraints];
	constraint = [NSLayoutConstraint constraintWithItem:_widthLabel
											  attribute:NSLayoutAttributeCenterX
											  relatedBy:NSLayoutRelationEqual
												 toItem:self
											  attribute:NSLayoutAttributeCenterX
											 multiplier:1.0
											   constant:0.0];
	[self addConstraint:constraint];
	
	// Constrain height label
	constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(margin)-[height]" options:0 metrics:metrics views:views];
	[self addConstraints:constraints];
	constraint = [NSLayoutConstraint constraintWithItem:_heightLabel
											  attribute:NSLayoutAttributeCenterY
											  relatedBy:NSLayoutRelationEqual
												 toItem:self
											  attribute:NSLayoutAttributeCenterY
											 multiplier:1.0
											   constant:0.0];
	[self addConstraint:constraint];
	
	// Constrain container label
	constraint = [NSLayoutConstraint constraintWithItem:_containerView
											  attribute:NSLayoutAttributeCenterX
											  relatedBy:NSLayoutRelationEqual
												 toItem:self
											  attribute:NSLayoutAttributeCenterX
											 multiplier:1.0
											   constant:0.0];
	[self addConstraint:constraint];
	constraint = [NSLayoutConstraint constraintWithItem:_containerView
											  attribute:NSLayoutAttributeCenterY
											  relatedBy:NSLayoutRelationEqual
												 toItem:self
											  attribute:NSLayoutAttributeCenterY
											 multiplier:1.0
											   constant:0.0];
	[self addConstraint:constraint];
	
	// Constrain title labels
	constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title]-[subtitle]|" options:0 metrics:metrics views:views];
	[_containerView addConstraints:constraints];
	constraint = [NSLayoutConstraint constraintWithItem:_titleLabel
											  attribute:NSLayoutAttributeCenterX
											  relatedBy:NSLayoutRelationEqual
												 toItem:_containerView
											  attribute:NSLayoutAttributeCenterX
											 multiplier:1.0
											   constant:0.0];
	[_containerView addConstraint:constraint];
	constraint = [NSLayoutConstraint constraintWithItem:_subTitleLabel
											  attribute:NSLayoutAttributeCenterX
											  relatedBy:NSLayoutRelationEqual
												 toItem:_containerView
											  attribute:NSLayoutAttributeCenterX
											 multiplier:1.0
											   constant:0.0];
	[_containerView addConstraint:constraint];
	
	[self updateLabels];
	
	self.lineColor = [UIColor colorWithRed:0.638 green:0.755 blue:1.000 alpha:1.000];
	self.guideLineColor = _lineColor;
	self.contentMode = UIViewContentModeRedraw;
	self.backgroundColor = [UIColor whiteColor];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

+ (BFDebugView *)debugViewWithFrame:(CGRect)frame {
	BFDebugView *debugView = [[BFDebugView alloc] initWithFrame:frame];
	return debugView;
}

#pragma mark -
#pragma mark Rendering

- (void)drawRect:(CGRect)rect {
	if ([self drawsLines]) {
		[BFDebugRenderer drawGridInRect:rect withDistance:_lineDistance offset:_lineOffset width:_lineWidth color:_lineColor];
	}
	if ([self drawsGuides]) {
		[BFDebugRenderer drawGridInRect:rect withDistance:_guideLineDistance offset:_guideLineOffset width:_guideLineWidth color:_guideLineColor];
	}
	if ([self drawsBorder]) {
		[BFDebugRenderer drawRect:rect width:_borderWidth * 2 color:_borderColor];
	}
}

- (BOOL)drawsLines {
	return _lineWidth > 0;
}

- (BOOL)drawsGuides {
	return _guideLineWidth > 0;
}

- (BOOL)drawsBorder {
	return _borderWidth > 0;
}

- (void)updateLabels {
	_widthLabel.text = [NSString stringWithFormat:@"%g", self.frame.size.width];
	_heightLabel.text = [NSString stringWithFormat:@"%g", self.frame.size.height];
	_originLabel.text = [NSString stringWithFormat:@"%g / %g", self.frame.origin.x, self.frame.origin.y];
}

#pragma mark -
#pragma mark Getters & Setters

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	[self updateLabels];
}

- (void)setLineDistance:(CGFloat)lineDistance {
	if (_lineDistance != lineDistance) {
		_lineDistance = lineDistance;
		[self setNeedsDisplay];
	}
}

- (void)setGuideLineDistance:(CGFloat)guideLineDistance {
	if (_guideLineDistance != guideLineDistance) {
		_guideLineDistance = guideLineDistance;
		[self setNeedsDisplay];
	}
}

- (void)setLineWidth:(CGFloat)lineWidth {
	if (_lineWidth != lineWidth) {
		_lineWidth = lineWidth;
		[self setNeedsDisplay];
	}
}

- (void)setGuideLineWidth:(CGFloat)guideLineWidth {
	if (_guideLineWidth != guideLineWidth) {
		_guideLineWidth = guideLineWidth;
		[self setNeedsDisplay];
	}
}

- (void)setLineColor:(UIColor *)lineColor {
	if (_lineColor != lineColor) {
		_lineColor = lineColor;
		[self setNeedsDisplay];
	}
}

- (void)setGuidelineColor:(UIColor *)guideLineColor {
	if (_guideLineColor != guideLineColor) {
		_guideLineColor = guideLineColor;
		[self setNeedsDisplay];
	}
}

- (void)setLineOffset:(CGFloat)lineOffset {
	if (_lineOffset != lineOffset) {
		_lineOffset = lineOffset;
		[self setNeedsDisplay];
	}
}

- (void)setGuideLineOffset:(CGFloat)guideLineOffset {
	if (_guideLineOffset != guideLineOffset) {
		_guideLineOffset = guideLineOffset;
		[self setNeedsDisplay];
	}
}

- (void)setBorderWidth:(CGFloat)borderWidth {
	if (_borderWidth != _borderWidth) {
		_borderWidth = borderWidth;
		[self setNeedsDisplay];
	}
}

- (void)setBorderColor:(UIColor *)borderColor {
	if (_borderColor != borderColor) {
		_borderColor = borderColor;
		[self setNeedsDisplay];
	}
}


@end
