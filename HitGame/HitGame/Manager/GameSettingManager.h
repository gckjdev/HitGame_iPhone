//
//  GameSettingManager.h
//  HitGame
//
//  Created by Orange on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSettingManager : NSObject {
    BOOL _isVibration;
    BOOL _isSoundOn;
    BOOL _isBGMOn;
}
@property (assign, nonatomic) BOOL isVibration;
@property (assign, nonatomic) BOOL isSoundOn;
@property (assign, nonatomic) BOOL isBGMOn;
+ (GameSettingManager*)defaultManager;
+ (BOOL)isVibration;
+ (BOOL)isSoundOn;
+ (BOOL)isBGMOn;
+ (void)saveIsSoundOn:(BOOL)isSoundOn;
+ (void)saveIsVibration:(BOOL)isVibration;
+ (void)saveIsMusicOn:(BOOL)isMusicOn;
+ (BOOL)getIsSoundOn;
+ (BOOL)getIsVibration;
+ (BOOL)getIsMisicOn;

- (void)loadSettings;
- (void)saveSettings;

@end
