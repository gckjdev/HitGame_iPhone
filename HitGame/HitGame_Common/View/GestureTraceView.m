//
//  GestureTraceView.m
//  HitGame
//
//  Created by  on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GestureTraceView.h"


@implementation GestureTraceView
@synthesize traceColor = _traceColor;
@synthesize traceWidth = _traceWidth;
@synthesize clearTraceDelay = _clearTraceDelay;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];     
        _pointList = [[NSMutableArray alloc] init];
        self.traceColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        _clearTraceDelay = 0.8;
        _traceWidth = 5;
    }
    return self;
}

- (void)dealloc
{
    [_traceColor release];
    [_pointList release];
    [super dealloc];
}

- (BOOL)receiveGesture:(UIGestureRecognizer *)gesture
{
    return [gesture isKindOfClass:[UIPanGestureRecognizer class]];
}

- (void)didStartGestrue:(UIGestureRecognizer *)gesture
{
    if ([self receiveGesture:gesture]) {
        [self.layer removeAllAnimations];
        _needDrawRect = YES;
    }
}

- (void)addPoint:(CGPoint)point
{ 
    _needDrawRect = YES;
    NSValue *value = [NSValue valueWithCGPoint:point];
    [_pointList addObject:value];
    [self setNeedsDisplay];
}
- (void)didGestrue:(UIGestureRecognizer *)gesture MovedAtPoint:(CGPoint)point
{
    if ([self receiveGesture:gesture]) {
        [self addPoint:point];
    }
}
- (void)didEndedGestrue:(UIGestureRecognizer *)gesture
{
    
    CABasicAnimation *clearAnimation = [CABasicAnimation 
                                        animationWithKeyPath:@"opacity"];
    clearAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    clearAnimation.toValue = [NSNumber numberWithFloat:0.0];
    clearAnimation.duration = _clearTraceDelay;
    clearAnimation.fillMode = kCAFillModeForwards;
    clearAnimation.removedOnCompletion = NO;
    clearAnimation.delegate = self;
    [self.layer addAnimation:clearAnimation forKey:@"clearAnimation"];
    [_pointList removeAllObjects];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (_needDrawRect && [_pointList count] != 0) {
        CGContextRef currentContext = UIGraphicsGetCurrentContext(); 
        CGContextSetStrokeColorWithColor(currentContext, _traceColor.CGColor);
        CGContextSetLineWidth(currentContext, _traceWidth);
        
        int i = 0;
        for (NSValue *value in _pointList) {
            CGPoint point = [value CGPointValue];
            if (i == 0) {
                CGContextMoveToPoint(currentContext, point.x, point.y);   
            }else{
                CGContextAddLineToPoint(currentContext, point.x, point.y);
            }
            ++ i;
        }
        CGContextStrokePath(currentContext);
    }
    
}


@end

