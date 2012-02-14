//
//  HGProgressBar.m
//  HitGame
//
//  Created by  on 12-2-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HGProgressBar.h"
#import "HGResource.h"

@implementation HGProgressBar
@synthesize progress = _progress;


- (void)defaultSetting
{
    _backgroundView = [[UIImageView alloc] initWithImage:PROGRESS_IMAGE];
    _frontgroundView = [[UIImageView alloc] initWithImage:PROGRESS_BAR_IMAGE];
    [self addSubview:_backgroundView];
    [_backgroundView setFrame:CGRectMake(0, 0, 220, 15)];
//    [_backgroundView setCenter:CGPointMake(170, 40)];
//    [_frontgroundView addSubview:_frontgroundView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)dealloc
{
    [_backgroundView release];
    [_frontgroundView release];
    [super dealloc];
}
- (id)initWithProgress:(CGFloat)progress
{
    self = [super initWithFrame:CGRectMake(0, 0, 220, 15)];
    if (self) {
        [self setCenter:CGPointMake(170, 40)];
        [self defaultSetting];
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
