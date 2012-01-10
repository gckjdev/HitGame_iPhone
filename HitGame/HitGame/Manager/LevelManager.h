//
//  LevelManager.h
//  HitGame
//
//  Created by  on 12-1-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameLevel;
@interface LevelManager : NSObject
{
    NSMutableArray *_levelArray;
}

@property(retain, nonatomic) NSMutableArray *levelArray;

+ (LevelManager *)defaultManager;
- (GameLevel *)gameLevelForLevelIndex:(NSInteger )index;
- (GameLevel *)nextGameLevelWithCurrentLevel:(GameLevel *)currentLevel;
- (CFTimeInterval)calculateMaxDuration:(GameLevel *)level;
- (CFTimeInterval)calculateMinDuration:(GameLevel *)level;
@end
