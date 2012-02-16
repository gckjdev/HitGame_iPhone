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
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UILabel *settingTitle;
@property (retain, nonatomic) IBOutlet UILabel *vibrationText;
@property (retain, nonatomic) IBOutlet UILabel *soundText;
@property (retain, nonatomic) IBOutlet UILabel *bgmText;
@property (retain, nonatomic) IBOutlet UIButton *vibrationSwitcher;
@property (retain, nonatomic) IBOutlet UIButton *soundSwitcher;
@property (retain, nonatomic) IBOutlet UIButton *bgmSwitcher;
@property (retain, nonatomic) IBOutlet UIButton *clickDoneButton;
@property (retain, nonatomic) IBOutlet UIButton *clickBackButton;
@property (retain, nonatomic) IBOutlet UIButton *clickDefaultButton;
@property (assign, nonatomic) id<GameSettingDelegate> delegate;
+ (GameSettingView *)createSettingViewWithDelegate:(id<GameSettingDelegate>)aDelegate;
+ (GameSettingView *)createSettingView;
@end
