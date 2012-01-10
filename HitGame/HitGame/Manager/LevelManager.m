//
//  LevelManager.m
//  HitGame
//
//  Created by  on 12-1-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LevelManager.h"
#import "Enum.h"
#import "Food.h"
#import "TestCase.h"
#import "GameLevel.h"

LevelManager *levelManager;


#define LEVEL_ARRAY @"LevelArray"

@implementation LevelManager
@synthesize levelArray = _levelArray;

- (id)init
{
    self = [super init];
    if (self) {
        _levelArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)createGameLevelWithFoddCount:(NSInteger)count levelIndex:(NSInteger)aLevelIndex
{
    NSArray *foodArray = [TestCase createFoodList:5];

    NSMutableArray *tempArray = [[[NSMutableArray alloc] init]autorelease];

    if (count == [foodArray count]) {
        [tempArray addObjectsFromArray:foodArray];
    }
    while ([tempArray count] < count) {
        Food *food = [foodArray objectAtIndex:(rand()%[foodArray count])];
        if (![tempArray containsObject:food]) {
            [tempArray addObject:food];
        }
    }
    GameLevel *level = [[GameLevel alloc] initWithFoodList:tempArray passScore:30 highestScore:0 speed:3 status:0 levelIndex:aLevelIndex];
    [_levelArray addObject:level];
    [level release];
}

- (void)createLevelConfigure
{
    for (int i = 1; i <= 20; ++ i) {
        
        if (i <= 4) {
            [self createGameLevelWithFoddCount:2 levelIndex:i];
        }else if(i <= 10)
        {
            [self createGameLevelWithFoddCount:3 levelIndex:i];
        }else if(i <= 18)
        {
            [self createGameLevelWithFoddCount:4 levelIndex:i];            
        }else
        {
            [self createGameLevelWithFoddCount:5 levelIndex:i];
        }
    }
    
}

- (void)readLevelConfigure
{
    NSUserDefaults *levelDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *defaultLevelArray = [levelDefaults arrayForKey:LEVEL_ARRAY];
    if (defaultLevelArray) {
        _levelArray = [[NSMutableArray alloc] initWithArray:defaultLevelArray];
    }else{
        [self createLevelConfigure];
    }
}

- (void)storeLevelConfigure
{
    NSUserDefaults *levelDefaults = [NSUserDefaults standardUserDefaults];
    [levelDefaults setValue:_levelArray forKey:LEVEL_ARRAY];
    [levelDefaults synchronize];
}

- (GameLevel *)gameLevelForLevelIndex:(NSInteger )index
{
    for (GameLevel *level in _levelArray) {
        if (level.levelIndex == index) {
            return level;
        }
    }
    return nil;
}
- (GameLevel *)nextGameLevelWithCurrentLevel:(GameLevel *)currentLevel
{
    if (currentLevel) {
        NSInteger index = currentLevel.levelIndex + 1;
        return [self gameLevelForLevelIndex:index];
    }
    return nil;
}

+ (LevelManager *)defaultManager
{
    if (levelManager == nil) {
        levelManager = [[LevelManager alloc] init];
        [levelManager readLevelConfigure];
    }
    return levelManager;
}

#define MAX_DURATION 3.0
#define MIN_DURATION 1.0
- (CFTimeInterval)calculateMaxDuration:(GameLevel *)level
{
    CFTimeInterval duration = 0;
    if (level) {
        duration = MAX_DURATION - (level.levelIndex - 1.0)/[_levelArray count];
        duration = MAX(duration, MIN_DURATION * 2);
        return duration;
    }
    return MAX_DURATION;
}
- (CFTimeInterval)calculateMinDuration:(GameLevel *)level
{
    CFTimeInterval duration = 0;
    if (level) {
        duration = MIN_DURATION + (([_levelArray count]) - level.levelIndex)/([_levelArray count] * 2.0);
        duration = MIN(duration, MAX_DURATION / 2.0);
        return duration;
    }
    return MAX_DURATION;
}
- (void)dealloc
{
    [_levelArray release];
    [super dealloc];
}
@end
