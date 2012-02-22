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
@synthesize settingTitle = _settingTitle;
@synthesize vibrationText = _vibrationText;
@synthesize soundText = _soundText;
@synthesize bgmText = _bgmText;
@synthesize vibrationSwitcher= _vibrationSwitcher;
@synthesize soundSwitcher = _soundSwitcher;
@synthesize clickDoneButton = _clickDoneButton;
@synthesize clickBackButton = _clickBackButton;
@synthesize clickDefaultButton = _clickDefaultButton;
@synthesize contentView = _contentView;
@synthesize bgmSwitcher = _bgmSwitcher;
@synthesize delegate = _delegate;

- (void)refleshSwitchs
{
    GameSettingManager* manager = [GameSettingManager defaultManager];
    [self.vibrationSwitcher setSelected:manager.isVibration];
    [self.soundSwitcher setSelected:manager.isSoundOn];
    [self.bgmSwitcher setSelected:manager.isBGMOn];
}

- (void)settingInit
{
    GameSettingManager* manager = [GameSettingManager defaultManager];
    [manager loadSettings];
    [self refleshSwitchs];
  
}

- (void)labelInit
{
    [_settingTitle setText:NSLocalizedString(@"Settings", @"设置")];
    [_vibrationText setText:NSLocalizedString(@"Vibration", @"振动开关")];
    [_soundText setText:NSLocalizedString(@"Sound", @"音效")];
    [_bgmText setText:NSLocalizedString(@"Music", @"背景音乐")];
}

+ (GameSettingView *)createSettingView
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GameSettingView" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).  
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <GameSettingView> but cannot find cell object from Nib");
        return nil;
    }
    GameSettingView* view =  (GameSettingView*)[topLevelObjects objectAtIndex:0];
    [view settingInit];
    [view labelInit];
    CAAnimation *scaleAnimation = [AnimationManager scaleAnimationWithFromScale:0.1 toScale:1 duration:0.5 delegate:view removeCompeleted:NO];
    CAAnimation *rollAnimation = [AnimationManager rotationAnimationWithRoundCount:-2 duration:0.5];
    [view.layer addAnimation:scaleAnimation forKey:@"enlarge"];
    [view.layer addAnimation:rollAnimation forKey:@"rolling"];
    return view;
    
}

+ (GameSettingView *)createSettingViewWithDelegate:(id<GameSettingDelegate>)aDelegate
{
    GameSettingView* view = [GameSettingView createSettingView];
    view.delegate = aDelegate;
    return view;
    
}

- (void)updateSwitch:(id)sender forState:(BOOL)state
{
    UIButton* button = (UIButton*)sender;
    if (state) {
        [button setSelected:YES];
    } else {
        [button setSelected:NO];
    }
}

- (IBAction)switchSoundOn:(id)sender
{
    GameSettingManager* manager = [GameSettingManager defaultManager];
    manager.isSoundOn = !manager.isSoundOn;
    [self updateSwitch:sender forState:manager.isSoundOn];
    
}

- (IBAction)switchVibration:(id)sender
{
    GameSettingManager* manager = [GameSettingManager defaultManager];
    manager.isVibration = !manager.isVibration;
    [self updateSwitch:sender forState:manager.isVibration];
}

- (IBAction)switchBGM:(id)sender
{
    GameSettingManager* manager = [GameSettingManager defaultManager];
    manager.isBGMOn = !manager.isBGMOn;
    [self updateSwitch:sender forState:manager.isBGMOn];
}

- (IBAction)clickBack:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(settingFinish)]) {
        [_delegate settingFinish];
    }
    CAAnimation *scaleAnimation = [AnimationManager scaleAnimationWithFromScale:1 toScale:0.1 duration:0.5 delegate:self removeCompeleted:NO];
    CAAnimation *rollAnimation = [AnimationManager rotationAnimationWithRoundCount:2 duration:0.5];
    [scaleAnimation setValue:@"minify" forKey:@"AnimationKey"];
    [scaleAnimation setDelegate:self];
    [self.layer addAnimation:scaleAnimation forKey:@"minify"];
    [self.layer addAnimation:rollAnimation forKey:@"rolling"];
}

- (IBAction)setDefault:(id)sender
{
    GameSettingManager* manager = [GameSettingManager defaultManager];
    manager.isBGMOn = YES;
    manager.isSoundOn = YES;
    manager.isVibration = YES;
    [self refleshSwitchs];
}

- (IBAction)setDone:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(settingFinish)]) {
        [_delegate settingFinish];
    }
    [[GameSettingManager defaultManager] saveSettings];
    CAAnimation *scaleAnimation = [AnimationManager scaleAnimationWithFromScale:1 toScale:0.1 duration:0.5 delegate:self removeCompeleted:NO];
    CAAnimation *rollAnimation = [AnimationManager rotationAnimationWithRoundCount:2 duration:0.5];
    [scaleAnimation setValue:@"minify" forKey:@"AnimationKey"];
    [scaleAnimation setDelegate:self];
    [self.layer addAnimation:scaleAnimation forKey:@"minify"];
    [self.layer addAnimation:rollAnimation forKey:@"rolling"];
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag 
{
    NSString* value = [anim valueForKey:@"AnimationKey"];
    if ([value isEqualToString:@"minify"]) {
        [self setHidden:YES];
        [self removeFromSuperview];
    }
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
