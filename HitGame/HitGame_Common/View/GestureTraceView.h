//
//  GestureTraceView.h
//  HitGame
//
//  Created by  on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureTraceView : UIView<UIGestureRecognizerDelegate>
{
    CGPoint startPoint;
    NSMutableArray *pointList;
    BOOL shouldClear;
    BOOL needDrawRect;
}


@property(nonatomic, retain)UIColor *traceColor;
@property(nonatomic, assign)CGFloat traceWidth;
@property(nonatomic, assign)CFTimeInterval clearTraceDelay;
@end
