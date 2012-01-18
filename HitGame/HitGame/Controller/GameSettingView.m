//
//  GameSettingView.m
//  HitGame
//
//  Created by Orange on 12-1-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameSettingView.h"
#import "AnimationManager.h"
#import "GameSettingManager.h"

@implementation GameSettingView
@synthesize vibrationSwitcher= _vibrationSwitcher;
@synthesize soundSwitcher = _soundSwitcher;
@synthesize clickDoneButton = _clickDoneButton;
@synthesize contentView = _contentView;
@synthesize bgmSwitcher = _bgmSwitcher;
@synthesize delegate = _delegate;

- (void)updateSwitch:(id)sender forState:(BOOL)state
{
    UIButton* button = (UIButton*)sender;
    if (state) {
        [button setSelected:YES];
    } else {
        [button setSelected:NO];
    }
}

- (void)switchSoundOn:(id)sender
{
    GameSettingManager* manager = [GameSettingManager defaultManager];
    manager.isSoundOn = !manager.isSoundOn;
    [self updateSwitch:sender forState:manager.isSoundOn];
    
}

- (void)switchVibration:(id)sender
{
    GameSettingManager* manager = [GameSettingManager defaultManager];
    manager.isVibration = !manager.isVibration;
    [self updateSwitch:sender forState:manager.isVibration];
}

- (void)switchBGM:(id)sender
{
    GameSettingManager* manager = [GameSettingManager defaultManager];
    manager.isBGMOn = !manager.isBGMOn;
    [self updateSwitch:sender forState:manager.isBGMOn];
}

- (void)initASwitcher:(UIButton*)aButton
{
    [self.contentView addSubview:aButton];
    [aButton setTitle:@"打开" forState:UIControlStateSelected];
    [aButton setTitle:@"关闭" forState:UIControlStateNormal];
}

- (void)initSwitcher
{
    _vibrationSwitcher = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _soundSwitcher = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _bgmSwitcher = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_vibrationSwitcher setFrame:CGRectMake(self.contentView.frame.size.width-40, 0, 40, 20)];
    [_soundSwitcher setFrame:CGRectMake(self.contentView.frame.size.width-40, 30, 40, 20)];
    [_bgmSwitcher setFrame:CGRectMake(self.contentView.frame.size.width-40, 60, 40, 20)];
    [self initASwitcher:_vibrationSwitcher];
    [self initASwitcher:_soundSwitcher];
    [self initASwitcher:_bgmSwitcher];
    [_vibrationSwitcher addTarget:self action:@selector(switchVibration:) forControlEvents:UIControlEventTouchUpInside];
    [_soundSwitcher addTarget:self action:@selector(switchSoundOn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgmSwitcher addTarget:self action:@selector(switchBGM:) forControlEvents:UIControlEventTouchUpInside];
    [self updateSwitch:_vibrationSwitcher forState:[GameSettingManager isVibration]];
    [self updateSwitch:_soundSwitcher forState:[GameSettingManager isSoundOn]];
    [self updateSwitch:_bgmSwitcher forState:[GameSettingManager isBGMOn]];
}

- (void)addLabelToContentView:(UILabel*)aLabel
{
    [self.contentView addSubview:aLabel];
    [aLabel setBackgroundColor:[UIColor clearColor]];
    [aLabel release];
}

- (void)initLabels
{
    UILabel* vibrationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    UILabel* soundSwitcherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 80, 20)];
    UILabel* bgmSwitcherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 20)];
    [vibrationLabel setText:@"振动开关"];
    [soundSwitcherLabel setText:@"音效"];
    [bgmSwitcherLabel setText:@"背景音乐"];
    [self addLabelToContentView:vibrationLabel];
    [self addLabelToContentView:soundSwitcherLabel];
    [self addLabelToContentView:bgmSwitcherLabel];
}

- (void)initButtons
{
    UIButton* doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [doneBtn setFrame:CGRectMake(self.contentView.frame.size.width-40, self.contentView.frame.size.height-20, 40, 20)];
    [doneBtn setTitle:@"ok" forState:UIControlStateNormal];
    [self.contentView addSubview:doneBtn];
    [doneBtn addTarget:self action:@selector(clickOkButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initContentView:(CGRect)aFrame
{
    _contentView = [[UIView alloc] initWithFrame:aFrame];
    [_contentView setBackgroundColor:[UIColor colorWithRed:(0x35)/255.0 
                                                     green:(0x42)/255.0 
                                                      blue:(0x53)/255.0 
                                                     alpha:0.66]];
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

- (id)initWithFrame:(CGRect)frame withDelegate:(id<GameSettingDelegate>)aDelegate
{
    self = [self initWithFrame:frame];
    if (self) {
        self.delegate = aDelegate;
        // Initialization code
    }
    return self;
}

- (void)clickOkButton:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(settingFinish)]) {
        [_delegate settingFinish];
    }
    CAAnimation *scaleAnimation = [AnimationManager scaleAnimationWithFromScale:1 toScale:0.1 duration:0.5 delegate:self removeCompeleted:NO];
    CAAnimation *rollAnimation = [AnimationManager rotationAnimationWithRoundCount:3 duration:0.5];
    [scaleAnimation setValue:@"minify" forKey:@"AnimationKey"];
    [scaleAnimation setDelegate:self];
    [_contentView.layer addAnimation:scaleAnimation forKey:@"minify"];
    [_contentView.layer addAnimation:rollAnimation forKey:@"rolling"];
    [self removeFromSuperview];
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
