//
//  Player.m
//  HitGameTest
//
//  Created by gamy on 11-12-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player
@synthesize playerId = _playerId;
@synthesize name = _name;
@synthesize vitality = _vilality;
@synthesize level = _level;
@synthesize status = _status;
@synthesize avatar = _avatar;
@synthesize role = _role;
@synthesize foodList = _foodList;


- (id)initWithPlayerId:(NSString *)playerId 
                  name:(NSString *)name 
                avatar:(UIImage *)avatar 
              vilality:(NSInteger)vilality 
                  role:(ROLE)role 
              foodList:(NSArray *)foodList 
                 level:(NSInteger)level 
                status:(PLAYER_STATUS)status
{
    self = [super init];
    if(self){
        self.playerId = playerId;
        self.name = name;
        self.avatar = avatar;
        self.vitality = vilality;
        self.role = role;
        if (foodList) {
            self.foodList = [NSMutableArray arrayWithArray:foodList];
        }else{
            _foodList = [[NSMutableArray alloc] init];
        }
        self.level = level;
        self.status = status;
    }
    return self;
}


- (void)dealloc
{
    [_playerId release];
    [_name release];
    [_avatar release];
    [_foodList release];
    [super dealloc];
}

@end
