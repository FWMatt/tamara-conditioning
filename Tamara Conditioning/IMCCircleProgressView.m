//
//  IMCCircleProgressView.m
//  IBMCaptureMobile
//
//  Created by Pedro Sebastião on 07/03/2017.
//  Copyright © 2017 IBM. All rights reserved.
//

#import "IMCCircleProgressView.h"
#import "IMCShapeView.h"

@interface IMCCircleProgressView ()

@property (nonatomic, assign) IMCShapeView *trackShapeView;
@property (nonatomic, assign) IMCShapeView *progressShapeView;
@property (nonatomic, assign) float progress;

@end

@implementation IMCCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    IMCShapeView *trackShapeView = [[IMCShapeView alloc] initWithFrame:self.bounds];
    [self addSubview:trackShapeView];
    self.trackShapeView = trackShapeView;
    trackShapeView.backgroundColor = [UIColor clearColor];
    trackShapeView.shapeLayer.fillColor = nil;
    trackShapeView.shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    trackShapeView.shapeLayer.lineWidth = 4.0f;
    
    IMCShapeView *progressShapeView = [[IMCShapeView alloc] initWithFrame:self.bounds];
    [self addSubview:progressShapeView];
    self.progressShapeView = progressShapeView;
    progressShapeView.backgroundColor = [UIColor clearColor];
    progressShapeView.shapeLayer.fillColor = nil;
    progressShapeView.shapeLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    progressShapeView.shapeLayer.lineWidth = 4.0f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.trackShapeView.frame = self.bounds;
    self.progressShapeView.frame = self.bounds;
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat maxDimension = MAX(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:maxDimension/2 startAngle:0 endAngle:2*(float)M_PI clockwise:YES];
    self.trackShapeView.shapeLayer.path = bezierPath.CGPath;
    
    UIBezierPath *bezierPathProgress = [UIBezierPath bezierPathWithArcCenter:center radius:maxDimension/2 startAngle:-M_PI/2 endAngle:2*(float)M_PI-M_PI/2 clockwise:YES];
    self.progressShapeView.shapeLayer.path = bezierPathProgress.CGPath;
}

- (void)setProgress:(float)progress animated:(BOOL)animated duration:(CGFloat)duration {
    if (progress != self->_progress) {
        if (animated == YES) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.duration = duration;
            [animation setFromValue:[NSNumber numberWithFloat:self->_progress]];
            [animation setToValue:[NSNumber numberWithFloat:progress]];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.5 :0.0 :0.5 :1.0]];
            [self.progressShapeView.shapeLayer addAnimation:animation forKey:@"progress"];
            self.progressShapeView.shapeLayer.strokeEnd = progress;
            self->_progress = progress;
        }
        else {
            self.progressShapeView.shapeLayer.strokeEnd = progress;
            self->_progress = progress;
        }
    }
}

@end
