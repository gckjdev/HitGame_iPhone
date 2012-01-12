//
//  AudioManager.h
//  HitGame
//
//  Created by Orange on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVAudioPlayer;

@interface AudioManager : NSObject {
 @protected
    AVAudioPlayer* _backgroundMusicPlayer;
    AVAudioPlayer* _soundPlayer;
}
@property (retain, nonatomic) AVAudioPlayer* backgroundMusicPlayer;
@property (retain, nonatomic) AVAudioPlayer* soundPlayer;

+ (AudioManager*)defaultManager;
- (void)setBackGroundMusicWithName:(NSString*)aMusicName;
- (void)playSoundByName:(NSString*)aSoundName;
- (void)backgroundMusicStart;
- (void)backgroundMusicPause;
- (void)backgroundMusicContinue;
- (void)backgroundMusicStop;

@end
