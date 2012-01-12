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

AudioManager* globalGetAudioManager()
{
    if (backgroundMusicManager == nil) {
        backgroundMusicManager = [[AudioManager alloc] init];
    }
    return backgroundMusicManager;
}


@implementation AudioManager
@synthesize backgroundMusicPlayer = _backgroundMusicPlayer;
@synthesize soundPlayer = _soundPlayer;

- (void)setBackGroundMusicWithName:(NSString*)aMusicName
{
    NSString* name;
    NSString* type;
    NSString *soundFilePath;
    NSArray* nameArray = [aMusicName componentsSeparatedByString:@"."];
    if ([nameArray count] == 2) {
        name = [nameArray objectAtIndex:0];
        type = [nameArray objectAtIndex:1];
        soundFilePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    } else {
        soundFilePath = [[NSBundle mainBundle] pathForResource:aMusicName ofType:@"mp3"];
    }
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    [self.backgroundMusicPlayer initWithContentsOfURL:soundFileURL error:nil];
    self.backgroundMusicPlayer.numberOfLoops = -1; //infinite
}

- (id)init
{
    self = [super init];
    if (self) {
        _backgroundMusicPlayer = [[AVAudioPlayer alloc] init];
        _soundPlayer = [[AVAudioPlayer alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_backgroundMusicPlayer release];
    [_soundPlayer release];
    [super dealloc];
}

+ (AudioManager*)defaultManager
{
    return globalGetAudioManager();
}



- (void)playSoundByName:(NSString*)aSoundName
{
    
}

- (void)backgroundMusicStart
{
//    [self setBackGroundMusicWithName:@"loveTrading.mp3"];
//    [self.backgroundMusicPlayer play];
    
}

- (void)backgroundMusicPause
{
    [self.backgroundMusicPlayer pause];
}

- (void)backgroundMusicContinue
{
    [self.backgroundMusicPlayer play];
}

- (void)backgroundMusicStop
{
    [self.backgroundMusicPlayer stop];
}



@end
