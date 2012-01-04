//
//  GameManager.h
//  HitGameTest
//
//  Created by gamy on 11-12-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
//@class Game;
@interface GameManager : NSObject {
    NSMutableArray *_gameList;
}

@property(nonatomic, retain) NSMutableArray *gameList;
- (void)addGame:(Game *)game;
- (Game *)GameForGameId:(NSString *)gameId;
- (id)initWithGameList:(NSArray *)gameList;
+ (GameManager *)defaultManager;
- (NSString *)levelStringForLevelType:(GAME_LEVEL)levelType;
- (NSString *)statusStringForStatusType:(GAME_STATUS)statusType;

- (NSString *)levelStringForGame:(Game *)game;
- (NSString *)statusStringForGame:(Game *)game;



@end
