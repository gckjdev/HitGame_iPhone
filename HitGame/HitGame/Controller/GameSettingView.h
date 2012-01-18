//
//  GameSettingView.h
//  HitGame
//
//  Created by Orange on 12-1-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>

@protocol GameSettingDelegate <NSObject>
@optional
- (void)settingFinish;

@end

@interface GameSettingView : UIView {
    id<GameSettingDelegate> _delegate;
}

@property (retain, nonatomic) UIButton *vibrationSwitcher;
@property (retain, nonatomic) UIButton *soundSwitcher;
@property (retain, nonatomic) UIButton *clickDoneButton;
@property (retain, nonatomic) UIView *contentView;
@property (retain, nonatomic) UIButton *bgmSwitcher;
@property (assign, nonatomic) id<GameSettingDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withDelegate:(id<GameSettingDelegate>)aDelegate;

@end
