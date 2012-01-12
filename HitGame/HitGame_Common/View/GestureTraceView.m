//
//  GestureTraceView.m
//  HitGame
//
//  Created by  on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GestureTraceView.h"

#import <QuartzCore/QuartzCore.h>


@implementation GestureTraceView
@synthesize traceColor = _traceColor;
@synthesize traceWidth = _traceWidth;
@synthesize clearTraceDelay = _clearTraceDelay;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(performPan:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
        [pan release];
        
        pointList = [[NSMutableArray alloc] init];
        self.traceColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        
        _clearTraceDelay = 0.8;
        _traceWidth = 5;
    }
    return self;
}

- (void)dealloc
{
    [_traceColor release];
    [pointList release];
    [super dealloc];
}

- (void)clearTrace
{
    [pointList removeAllObjects];
    needDrawRect = NO;
    [self setNeedsDisplay];
}

- (void)addPoint:(CGPoint)point
{
    NSValue *value = [NSValue valueWithCGPoint:point];
    [pointList addObject:value];
}


- (void)animationDidStart:(CAAnimation *)anim
{
    
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    [self setNeedsDisplay];
}

- (void)performPan:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        [self.layer removeAllAnimations];
        needDrawRect = YES;
        startPoint = [pan locationInView:self];
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        CGPoint location = [pan locationInView:self];
        [self addPoint:location];
        [self setNeedsDisplay];
    }else if(pan.state == UIGestureRecognizerStateEnded){
        CGPoint location = [pan locationInView:self];
        [self addPoint:location];
        
        CABasicAnimation *clearAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        clearAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        clearAnimation.toValue = [NSNumber numberWithFloat:0.0];
        clearAnimation.duration = _clearTraceDelay;
        clearAnimation.fillMode = kCAFillModeForwards;
        clearAnimation.removedOnCompletion = NO;
        clearAnimation.delegate = self;
        [self.layer addAnimation:clearAnimation forKey:@"clearAnimation"];
        [pointList removeAllObjects];
        
        
        
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == self) {
        return YES;
    }
    return NO;
}

- (void)drawRect:(CGRect)rect
{
    if (needDrawRect && [pointList count] != 0) {
        CGContextRef currentContext = UIGraphicsGetCurrentContext(); 
        CGContextSetStrokeColorWithColor(currentContext, _traceColor.CGColor);
        CGContextSetLineWidth(currentContext, _traceWidth);
        CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);    
        for (NSValue *value in pointList) {
            CGPoint point = [value CGPointValue];
            CGContextAddLineToPoint(currentContext, point.x, point.y);
        }
        CGContextStrokePath(currentContext);
    }
    
}


@end

