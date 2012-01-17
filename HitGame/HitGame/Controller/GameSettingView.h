//
//  GameSettingView.h
//  HitGame
//
//  Created by Orange on 12-1-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>

@interface GameSettingView : UIView

@property (retain, nonatomic) UISwitch *vibrationSwitcher;
@property (retain, nonatomic) UISwitch *soundSwitcher;
@property (retain, nonatomic) UIButton *clickDoneButton;
@property (retain, nonatomic) UIView *contentView;
@property (retain, nonatomic) UISwitch *bgmSwitcher;

@end
