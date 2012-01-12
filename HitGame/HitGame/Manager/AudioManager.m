//
//  AudioManager.m
//  HitGame
//
//  Created by Orange on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AudioManager.h"
#import <AVFoundation/AVFoundation.h>

AudioManager* backgroundMusicManager;
AudioManager* soundManager;

AudioManager* globalGetBackgroundMusicManager()
{
    if (backgroundMusicManager == nil) {
        backgroundMusicManager = [[AudioManager alloc] init];
    }
    return backgroundMusicManager;
}

AudioManager* globalGetSoundManager()
{
    if (soundManager == nil) {
        soundManager = [[AudioManager alloc] init];
    }
    return soundManager;
}

@implementation AudioManager



@end
