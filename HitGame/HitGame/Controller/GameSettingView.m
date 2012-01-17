//
//  GameSettingView.m
//  HitGame
//
//  Created by Orange on 12-1-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameSettingView.h"
#import "AnimationManager.h"

@implementation GameSettingView
@synthesize vibrationSwitcher= _vibrationSwitcher;
@synthesize soundSwitcher = _soundSwitcher;
@synthesize clickDoneButton = _clickDoneButton;
@synthesize contentView = _contentView;
@synthesize bgmSwitcher = _bgmSwitcher;

- (void)initSwitcher
{
    _vibrationSwitcher = [[UISwitch alloc] init];
    _soundSwitcher = [[UISwitch alloc] init];
    _bgmSwitcher = [[UISwitch alloc] init];
    [self.contentView addSubview:_vibrationSwitcher];
    [self.contentView addSubview:_soundSwitcher];
    [self.contentView addSubview:_bgmSwitcher];
}

- (void)initLabels
{
    UILabel* vibrationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    UILabel* soundSwitcher = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    UILabel* bgmSwitcher = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [self.contentView addSubview:vibrationLabel];
    [self.contentView addSubview:soundSwitcher];
    [self.contentView addSubview:bgmSwitcher];
    [vibrationLabel release];
    [soundSwitcher release];
    [bgmSwitcher release];
}

- (void)initButtons
{
    UIButton* doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [doneBtn setFrame:CGRectMake(self.contentView.frame.size.width-40, self.contentView.frame.size.height-20, 40, 20)];
    [doneBtn setTitle:@"ok" forState:UIControlStateNormal];
    [self.contentView addSubview:doneBtn];
}

- (void)initContentView:(CGRect)aFrame
{
    _contentView = [[UIView alloc] initWithFrame:aFrame];
    [_contentView setBackgroundColor:[UIColor colorWithRed:(0x35)/255.0 
                                                     green:(0x42)/255.0 
                                                      blue:(0x53)/255.0 
                                                     alpha:0.33]];
    [_contentView setCenter:CGPointMake(160, 240)];
    [self addSubview:_contentView];
    CAAnimation *scaleAnimation = [AnimationManager scaleAnimationWithFromScale:0.1 toScale:1 duration:0.5 delegate:self removeCompeleted:NO];
    CAAnimation *rollAnimation = [AnimationManager rotationAnimationWithRoundCount:-3 duration:0.5];
    [_contentView.layer addAnimation:scaleAnimation forKey:@"enlarge"];
    [_contentView.layer addAnimation:rollAnimation forKey:@"rolling"];
    [_contentView release];
}

- (void)dealloc
{
    [_vibrationSwitcher release];
    [_soundSwitcher release];
    [_bgmSwitcher release];
    [_contentView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, 480)];
        [self setBackgroundColor:[UIColor clearColor]];
        [self initContentView:frame];
        [self initLabels];
        [self initSwitcher];
        [self initButtons];
        // Initialization code
    }
    return self;
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
