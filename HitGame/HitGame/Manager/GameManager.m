//
//  GameManager.m
//  HitGameTest
//
//  Created by gamy on 11-12-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"
#import "Game.h"

GameManager *gameManager;

@implementation GameManager
@synthesize gameList = _gameList;


- (id)initWithGameList:(NSArray *)gameList
{
    self = [super init];
    if (self) {
        if (gameList) {
            _gameList = [[NSMutableArray alloc] initWithArray:gameList];            
        }else{
            _gameList = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (id)init
{
    return [self initWithGameList:nil];
}

+ (GameManager *)defaultManager
{
    if (gameManager == nil) {
        gameManager = [[GameManager alloc] init];
    }
    return gameManager;
}

- (void)addGame:(Game *)game
{
    [_gameList addObject:game];
}

- (Game *)GameForGameId:(NSString *)gameId
{
    if ([_gameList count] > 0) {
        for(Game *game in _gameList){
            if (game && [game.gameId isEqualToString:gameId]) {
                return game;
            }
        }
    }
    return nil;
}


- (NSString *)levelStringForLevelType:(GAME_LEVEL)levelType
{

    switch (levelType) {
        case GAME_LEVEL_LOW:
            return @"低";
        case GAME_LEVEL_MEDIUM:
            return @"中";
        case GAME_LEVEL_HIGH:    
            return @"高";
        default:
            return @"低";
    }
}
- (NSString *)statusStringForStatusType:(GAME_STATUS)statusType
{
    
    switch (statusType) {
        case GAME_STATUS_WAITTING:
            return @"等待中";
        case GAME_STATUS_PLAYING:
            return @"游戏中";
        case GAME_STATUS_READY:
            return @"准备中";
        case GAME_STATUS_END:
            return @"已结束";
        default:
            return @"等待中";
    }
}


- (NSString *)levelStringForGame:(Game *)game
{
    if (game) {
        return [self levelStringForLevelType:game.level];
    }
    return nil;
}
- (NSString *)statusStringForGame:(Game *)game
{
    if (game) {
        return [self statusStringForStatusType:game.status];
    }
    return nil;
}

- (void)dealloc
{
    [_gameList release];
    [super dealloc];
}
@end
