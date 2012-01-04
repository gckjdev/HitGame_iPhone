//
//  Player.h
//  HitGameTest
//
//  Created by gamy on 11-12-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CREATOR = 0, //if the player create the game
    GENERAL_PLAYER, //else the player is a general player.
    UNDEFINED
    
} ROLE;

typedef enum {
    PLAYER_STATUS_FREE = 0, // when the player is out of all the games.
    PLAYER_STATUS_READY, // when the player enter a game and press the ready button
    PLAYER_STATUS_PALYING, //when the player is playing.
    
}PLAYER_STATUS;


@class Food;
@interface Player : NSObject {
    NSString *_playerId;
    NSString *_name;
    UIImage *_avatar;
    NSInteger _vilality; //when the vilality is equal to 0, the player die.
    NSInteger _level; //will use in the further
    PLAYER_STATUS _status;
    ROLE _role;
    NSMutableArray *_foodList;
    
}

@property(nonatomic, retain) NSMutableArray *foodList;
@property(nonatomic, copy) NSString *playerId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) UIImage *avatar;
@property(nonatomic, assign) ROLE role;
@property(nonatomic, assign) NSInteger level;
@property(nonatomic, assign) NSInteger vitality;
@property(nonatomic, assign) PLAYER_STATUS status;

- (id)initWithPlayerId:(NSString *)playerId 
                  name:(NSString *)name 
                avatar:(UIImage *)avatar 
              vilality:(NSInteger)vilality 
                  role:(ROLE)role 
              foodList:(NSArray *)foodList 
                 level:(NSInteger)level 
                status:(PLAYER_STATUS)status; 
@end



