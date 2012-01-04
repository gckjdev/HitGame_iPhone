//
//  Game.h
//  HitGameTest
//
//  Created by gamy on 11-12-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum{
    GAME_STATUS_WAITTING = 0, //when the game has been created, but not all the  players has entered the game
    GAME_STATUS_READY, //when all the players enter the game, but bufore all the players are ready.
    GAME_STATUS_PLAYING, //when the game is playing.
    GAME_STATUS_END //when finish.
}GAME_STATUS;

typedef enum {
    GAME_LEVEL_LOW = 0,
    GAME_LEVEL_MEDIUM,
    GAME_LEVEL_HIGH
} GAME_LEVEL;

@class Player;
@class Food;


@interface Game : NSObject {
    NSString *_gameId;
    NSMutableArray *_playerList;
//    Player *_player;
    NSInteger _capacity;
    GAME_LEVEL _level;
    GAME_STATUS _status;
}


@property(nonatomic, copy) NSString *gameId;
@property(nonatomic, retain) NSMutableArray *playerList;
//@property(nonatomic, retain) Player *player;
@property(nonatomic, assign) NSInteger capacity;
@property(nonatomic, assign) GAME_LEVEL level;
@property(nonatomic, assign) GAME_STATUS status;

- (id)initWithGameId:(NSString *)gameId 
         playerList:(NSArray *)playerList 
           capacity:(NSInteger)capacity 
              level:(GAME_LEVEL)level 
             status:(NSInteger)status;

- (Player *)creator;


@end
