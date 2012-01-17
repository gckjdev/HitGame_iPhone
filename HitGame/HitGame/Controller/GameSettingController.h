//
//  GameSettingController.h
//  HitGame
//
//  Created by Orange on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSettingController : UIViewController {
    
}
@property (retain, nonatomic) IBOutlet UISwitch *vibrationSwitcher;
@property (retain, nonatomic) IBOutlet UISwitch *soundSwitcher;
@property (retain, nonatomic) IBOutlet UIButton *clickDoneButton;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UISwitch *BGMSwitcher;

@end
