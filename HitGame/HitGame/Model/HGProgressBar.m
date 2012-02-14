//
//  HGProgressBar.m
//  HitGame
//
//  Created by  on 12-2-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HGProgressBar.h"

@implementation HGProgressBar
@synthesize progress = _progress;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (id)initWithProgress:(CGFloat)progress
{
    self = [super initWithFrame:CGRectMake(0, 0, 0, 0)];
    if (self) {
        
    }
    return self;
}


- (void)setProgress:(float)progress
{
    _progress = progress;
//    _frontgroundView center = CGPointMake(_frontgroundView.x, <#CGFloat y#>)
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
