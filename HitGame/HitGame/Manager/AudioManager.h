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
    AVAudioPlayer* _backgroundMusicPlayer;
    NSMutableArray* _sounds;
}
@property (retain, nonatomic) AVAudioPlayer* backgroundMusicPlayer;
@property (retain, nonatomic) NSMutableArray* sounds;
+ (AudioManager*)defaultManager;
- (void)setBackGroundMusicWithName:(NSString*)aMusicName;
- (void)playSoundById:(NSInteger)aSoundIndex;
- (void)backgroundMusicStart;
- (void)backgroundMusicPause;
- (void)backgroundMusicContinue;
- (void)backgroundMusicStop;
- (void)setBackGroundMusicVolumn:(CGFloat)aVolumn;
@end
