//
//  Game.m
//  HitGameTest
//
//  Created by gamy on 11-12-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Game.h"
#import "Player.h"

@implementation Game
//@synthesize player = _player;
@synthesize playerList = _playerList;
@synthesize gameId = _gameId;
@synthesize capacity = _capacity;
@synthesize level = _level;
@synthesize status = _status;


-(id)initWithGameId:(NSString *)gameId 
         playerList:(NSArray *)playerList 
           capacity:(NSInteger)capacity 
              level:(GAME_LEVEL)level 
             status:(NSInteger)status
{
    self = [super init];
    if (self) {
        self.gameId = gameId;
        self.capacity = capacity;
        self.level = level;
        self.status = status;
        if (playerList) {
            self.playerList = [NSMutableArray arrayWithArray:playerList];
        }else {
            playerList = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (Player *)creator
{
    if (_playerList) {
        for (Player *player in _playerList) {
            if (player && [player role] == CREATOR) {
                return player;
            }
        }
    }
    return nil;
}

- (void)dealloc
{
//    [_player release];
    [_playerList release];
    [_gameId release];
    [super dealloc];
}
@end
