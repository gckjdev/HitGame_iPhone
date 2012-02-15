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
    
    UIImage *s = [[UIImage imageNamed:@"progress_bar.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:11];
    _frontgroundView = [[UIImageView alloc] initWithImage:s];
    [self addSubview:_backgroundView];
    [self addSubview:_frontgroundView];
    [_frontgroundView setFrame:CGRectMake(2, 1, _progress * 216, 11)];
    [_backgroundView setFrame:CGRectMake(0, 0, 220, 15)];
    [self setClipsToBounds:YES];
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
        [self setCenter:CGPointMake(170, 20)];
        self.progress = progress;
        [self defaultSetting];
    }
    return self;
}


- (void)setProgress:(float)progress
{
    _progress = progress;
    [_frontgroundView setFrame:CGRectMake(1, 1, _progress * 218, 11)];
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
