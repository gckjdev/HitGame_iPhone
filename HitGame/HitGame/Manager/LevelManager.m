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


- (NSInteger)numberWithCount:(NSInteger)count
{
    switch (count) {
        case 2:
            return 4;
        case 3:
            return 6;
        case 4:
            return 6;
        case 5:
            return 4;
        default:
            return 0;
    }
}
- (NSInteger)startIndexWithCount:(NSInteger)count
{
    if (count == 2) {
        return 0;
    }else if(count <= 5){
        return [self startIndexWithCount:count - 1] + [self numberWithCount:count - 1];
    }
    
    return -1;
}

- (NSInteger)countForIndex:(NSInteger)index
{
    for (int i = 2; i <= 5; ++ i) {
        if ( index < [self startIndexWithCount:i] + [self numberWithCount:i]) {
            return i;
        }
    }
    return 0;
}

- (id)init
{
    self = [super init];
    if (self) {
        _levelArray = [[NSMutableArray alloc] init];
    }
    return self;
}

//- (void)createGameLevelWithFoddCount:(NSInteger)count levelIndex:(NSInteger)aLevelIndex
//{
//    NSArray *foodArray = [TestCase createFoodList:5];
//
//    NSMutableArray *tempArray = [[[NSMutableArray alloc] init]autorelease];
//
//    if (count == [foodArray count]) {
//        [tempArray addObjectsFromArray:foodArray];
//    }
//    while ([tempArray count] < count) {
//        Food *food = [foodArray objectAtIndex:(rand()%[foodArray count])];
//        if (![tempArray containsObject:food]) {
//            [tempArray addObject:food];
//        }
//    }
//    GameLevel *gameLevel = [[GameLevel alloc]initWithFoodList:tempArray highestScore:0 levelIndex:aLevelIndex locked:YES status:0];
//    
//    [_levelArray addObject:gameLevel];
//    
//    [gameLevel release];
//}



- (void)createGameLevelForIndex:(NSInteger)index
{
    NSInteger count = [self countForIndex:index];
    NSInteger offset = index - [self startIndexWithCount:count];
    
    NSArray *foodArray = [TestCase createFoodList:5];
    NSMutableArray *tempArray = [[[NSMutableArray alloc] init]autorelease];
    for (int i = 0; i < count; ++ i) {
        Food *food = [foodArray objectAtIndex:((offset + i)%[foodArray count])];
        [tempArray addObject:food];
    }
    GameLevel *gameLevel = [[GameLevel alloc]initWithFoodList:tempArray highestScore:0 levelIndex:index + 1 locked:YES status:0];
    
    [_levelArray addObject:gameLevel];
    
    [gameLevel release];
}

- (void)createLevelConfigure
{
    for (int i = 0; i < 20; ++ i) {
        [self createGameLevelForIndex:i];
//        if (i <= 4) {
//            [self createGameLevelWithFoddCount:2 levelIndex:i];
//        }else if(i <= 10)
//        {
//            [self createGameLevelWithFoddCount:3 levelIndex:i];
//        }else if(i <= 15)
//        {
//            [self createGameLevelWithFoddCount:4 levelIndex:i];            
//        }else
//        {
//            [self createGameLevelWithFoddCount:5 levelIndex:i];
//        }
    }
    GameLevel *firstLevel = [_levelArray objectAtIndex:0];
    [firstLevel setLocked:NO];    
}

- (void)readLevelConfigure
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData* levelData = [userDefault objectForKey:LEVEL_ARRAY];
    
    if (levelData) {
        self.levelArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:levelData]];
    }else{
        [self createLevelConfigure];
        [self storeLevelConfigure];
    }
}

- (void)storeLevelConfigure
{

    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData *levelData = [NSKeyedArchiver archivedDataWithRootObject:_levelArray];
    [userDefault setObject:levelData forKey:LEVEL_ARRAY];
    [userDefault synchronize];
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



- (void)unLockGameLevelAtIndex:(NSInteger) index
{
    GameLevel *gameLevel = [self gameLevelForLevelIndex:index];
    if (gameLevel) {
        gameLevel.locked = NO;
    }
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
