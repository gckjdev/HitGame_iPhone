//
//  GameSettingManager.m
//  HitGame
//
//  Created by Orange on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameSettingManager.h"

GameSettingManager* GlobalGetGameSettingManager()
{
    GameSettingManager* manager = [[GameSettingManager alloc ] init ];
    return manager;
}

@implementation GameSettingManager
@synthesize isVibration = _isVibration;

- (id)init
{
    self = [super init];
    if (self) {
        _isVibration = YES;//
    }
    return self;
}

+ (GameSettingManager*)defaultManager
{
    return GlobalGetGameSettingManager();
}

+ (BOOL)isVibration
{
    return self.isVibration;
}

@end
