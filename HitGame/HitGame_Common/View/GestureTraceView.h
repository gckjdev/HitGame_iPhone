//
//  GestureTraceView.h
//  HitGame
//
//  Created by  on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface GestureTraceView : UIView<UIGestureRecognizerDelegate>
{
    NSMutableArray *_pointList;
    BOOL _needDrawRect;
    
}


@property(nonatomic, retain)UIColor *traceColor;
@property(nonatomic, assign)CGFloat traceWidth;
@property(nonatomic, assign)CFTimeInterval clearTraceDelay;

- (void)didStartGestrue:(UIGestureRecognizer *)gesture;
- (void)didEndedGestrue:(UIGestureRecognizer *)gesture;
- (void)didGestrue:(UIGestureRecognizer *)gesture MovedAtPoint:(CGPoint)point;
@end
