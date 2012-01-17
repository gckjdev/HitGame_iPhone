//
//  GameSettingManager.m
//  HitGame
//
//  Created by Orange on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameSettingManager.h"

GameSettingManager* globalGameSettingManager;

GameSettingManager* GlobalGetGameSettingManager()
{
    if (globalGameSettingManager == nil) {
        globalGameSettingManager = [[GameSettingManager alloc ] init ];
    } 
    return globalGameSettingManager;
}

@implementation GameSettingManager
@synthesize isVibration = _isVibration;
@synthesize isSoundOn = _isSoundOn;

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

@end
