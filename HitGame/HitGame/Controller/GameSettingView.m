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
#define LOC(x) NSLocalizedString(x, @"设置界面")


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

- (void)settingInit
{
    GameSettingManager* manager = [GameSettingManager defaultManager];
    [self.vibrationSwitcher setSelected:manager.isVibration];
    [self.soundSwitcher setSelected:manager.isSoundOn];
    [self.bgmSwitcher setSelected:manager.isBGMOn];
    
    
}

- (void)labelInit
{
    [_settingTitle setText:LOC(@"设置")];
    [_vibrationText setText:LOC(@"振动开关")];
    [_soundText setText:LOC(@"音效")];
    [_bgmText setText:LOC(@"背景音乐")];
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
    
}

- (IBAction)setDone:(id)sender
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

//- (void)initASwitcher:(UIButton*)aButton
//{
//    [self.contentView addSubview:aButton];
//    [aButton setTitle:NSLocalizedString(@"打开", @"开关") forState:UIControlStateSelected];
//    [aButton setTitle:NSLocalizedString(@"关闭", @"开关") forState:UIControlStateNormal];
//}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag 
{
    NSString* value = [anim valueForKey:@"AnimationKey"];
    if ([value isEqualToString:@"minify"]) {
        [self setHidden:YES];
        [self removeFromSuperview];
    }
}

//- (void)initSwitcher
//{
//    _vibrationSwitcher = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _soundSwitcher = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _bgmSwitcher = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [_vibrationSwitcher setFrame:CGRectMake(self.contentView.frame.size.width-40, 0, 40, 20)];
//    [_soundSwitcher setFrame:CGRectMake(self.contentView.frame.size.width-40, 30, 40, 20)];
//    [_bgmSwitcher setFrame:CGRectMake(self.contentView.frame.size.width-40, 60, 40, 20)];
//    [self initASwitcher:_vibrationSwitcher];
//    [self initASwitcher:_soundSwitcher];
//    [self initASwitcher:_bgmSwitcher];
//    [_vibrationSwitcher addTarget:self action:@selector(switchVibration:) forControlEvents:UIControlEventTouchUpInside];
//    [_soundSwitcher addTarget:self action:@selector(switchSoundOn:) forControlEvents:UIControlEventTouchUpInside];
//    [_bgmSwitcher addTarget:self action:@selector(switchBGM:) forControlEvents:UIControlEventTouchUpInside];
//    [self updateSwitch:_vibrationSwitcher forState:[GameSettingManager isVibration]];
//    [self updateSwitch:_soundSwitcher forState:[GameSettingManager isSoundOn]];
//    [self updateSwitch:_bgmSwitcher forState:[GameSettingManager isBGMOn]];
//}
//
//- (void)addLabelToContentView:(UILabel*)aLabel
//{
//    [self.contentView addSubview:aLabel];
//    [aLabel setBackgroundColor:[UIColor clearColor]];
//    [aLabel release];
//}
//
//- (void)initLabels
//{
//    UILabel* vibrationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
//    UILabel* soundSwitcherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 80, 20)];
//    UILabel* bgmSwitcherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 20)];
//    [self addLabelToContentView:vibrationLabel];
//    [self addLabelToContentView:soundSwitcherLabel];
//    [self addLabelToContentView:bgmSwitcherLabel];
//}
//
//- (void)initButtons
//{
//    UIButton* doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [doneBtn setFrame:CGRectMake(self.contentView.frame.size.width-40, self.contentView.frame.size.height-20, 40, 20)];
//    [doneBtn setTitle:@"ok" forState:UIControlStateNormal];
//    [self.contentView addSubview:doneBtn];
//    [doneBtn addTarget:self action:@selector(clickOkButton:) forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)initContentView:(CGRect)aFrame
//{
//    _contentView = [[UIView alloc] initWithFrame:aFrame];
//    [_contentView setBackgroundColor:[UIColor colorWithRed:(0x35)/255.0 
//                                                     green:(0x42)/255.0 
//                                                      blue:(0x53)/255.0 
//                                                     alpha:0.66]];
//    [_contentView setCenter:CGPointMake(160, 240)];
//    [self addSubview:_contentView];
//    CAAnimation *scaleAnimation = [AnimationManager scaleAnimationWithFromScale:0.1 toScale:1 duration:0.5 delegate:self removeCompeleted:NO];
//    CAAnimation *rollAnimation = [AnimationManager rotationAnimationWithRoundCount:-3 duration:0.5];
//    [_contentView.layer addAnimation:scaleAnimation forKey:@"enlarge"];
//    [_contentView.layer addAnimation:rollAnimation forKey:@"rolling"];
//    [_contentView release];
//}

//- (void)dealloc
//{
//    [_vibrationSwitcher release];
//    [_soundSwitcher release];
//    [_bgmSwitcher release];
//    [_contentView release];
//    [super dealloc];
//}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setFrame:CGRectMake(0, 0, 320, 480)];
//        [self setBackgroundColor:[UIColor clearColor]];
//        [self initContentView:frame];
//        [self initLabels];
//        [self initSwitcher];
//        [self initButtons];
//        // Initialization code
//    }
//    return self;
//}
//
//- (id)initWithFrame:(CGRect)frame withDelegate:(id<GameSettingDelegate>)aDelegate
//{
//    self = [self initWithFrame:frame];
//    if (self) {
//        self.delegate = aDelegate;
//        // Initialization code
//    }
//    return self;
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
