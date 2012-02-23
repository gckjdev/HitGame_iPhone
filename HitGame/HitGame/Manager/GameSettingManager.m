//
//  GameSettingManager.m
//  HitGame
//
//  Created by Orange on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameSettingManager.h"
#define IS_SOUND_ON @"isSoundOn"
#define IS_VIBRATION @"isVibration"
#define IS_MUSIC_ON @"isMusicOn"

GameSettingManager* globalGameSettingManager;

GameSettingManager* GlobalGetGameSettingManager()
{
    if (globalGameSettingManager == nil) {
        globalGameSettingManager = [[GameSettingManager alloc ] init ];
        [globalGameSettingManager loadSettings];
    } 
    return globalGameSettingManager;
}

@implementation GameSettingManager
@synthesize isVibration = _isVibration;
@synthesize isSoundOn = _isSoundOn;
@synthesize isBGMOn = _isBGMOn;

- (id)init
{
    self = [super init];
    if (self) {
        _isVibration = YES;//
        _isSoundOn = YES;
    }
    return self;
}

+ (GameSettingManager*)defaultManager
{
    return GlobalGetGameSettingManager();
}

+ (BOOL)isVibration
{
    return [[GameSettingManager defaultManager] isVibration];
}

+ (BOOL)isSoundOn
{
    return [[GameSettingManager defaultManager] isSoundOn];
}

+ (BOOL)isBGMOn
{
    return [[GameSettingManager defaultManager] isBGMOn];
}

+ (void)saveIsSoundOn:(BOOL)isSoundOn
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isSoundOn forKey:IS_SOUND_ON];
}

+ (void)saveIsVibration:(BOOL)isVibration
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isVibration forKey:IS_VIBRATION];
}

+ (void)saveIsMusicOn:(BOOL)isMusicOn
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isMusicOn forKey:IS_MUSIC_ON];
}




+ (BOOL)getIsSoundOn
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:IS_SOUND_ON]) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:IS_SOUND_ON];
    }
    else{
        return YES;  //default has sound
    }
}

+ (BOOL)getIsVibration
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:IS_VIBRATION];
}

+ (BOOL)getIsMisicOn
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:IS_MUSIC_ON];
}

- (void)loadSettings
{
    self.isSoundOn = [GameSettingManager getIsSoundOn];
    self.isVibration = [GameSettingManager getIsVibration];
    self.isBGMOn = [GameSettingManager getIsMisicOn];
}
- (void)saveSettings
{
    [GameSettingManager saveIsSoundOn:self.isSoundOn];
    [GameSettingManager saveIsMusicOn:self.isBGMOn];
    [GameSettingManager saveIsVibration:self.isVibration];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
