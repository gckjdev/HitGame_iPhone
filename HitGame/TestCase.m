//
//  TestCase.m
//  HitGameTest
//
//  Created by  on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "TestCase.h"
#import "Game.h"
#import "GameManager.h"
#import "Player.h"
#import "Food.h"
#import "FoodManager.h"
#import "HGResource.h"

@implementation TestCase


+ (void) createGameList:(NSInteger) count
{
    if (count < 0) {
        return;
    }
    GameManager *gameManager = [GameManager defaultManager];
    for (int i = 0; i < count; ++ i) {
        NSString *gameId = [NSString stringWithFormat:@"d",i];
        NSInteger capacity = rand()%6 + 2;
        NSInteger count = rand()%capacity + 1;
        NSArray *playerList = [TestCase createPlayerList:count];
        Game *game = [[Game alloc] initWithGameId:gameId playerList:playerList capacity:capacity level:GAME_LEVEL_MEDIUM status:GAME_STATUS_WAITTING];
        [gameManager addGame:game];
        [game release];
    }
    
}
+ (NSArray *) createPlayerList:(NSInteger) count
{

    if (count < 0) {
        return nil;
    }
    NSInteger creatorIndex = rand() % count;
    NSMutableArray *playerList = [[[NSMutableArray alloc] initWithCapacity:count] autorelease];
    for (int i = 0; i < count; ++ i) {
        NSString *playerId = [NSString stringWithFormat:@"d",i];
        NSArray *foodList = [TestCase createFoodList:5];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"player%d.png",
                                              (i%5)+1]];
        Player *player = [[Player alloc] initWithPlayerId:playerId name:@"test" avatar:image vilality:100 role:GENERAL_PLAYER foodList:foodList level:10 status:PLAYER_STATUS_FREE];
        if (creatorIndex == i) {
            [player setRole:CREATOR];
        }
        
        [playerList addObject:player];
        [player release];
    }
    return playerList;
}
+ (NSArray *) createFoodList:(NSInteger) count
{
//    
//    EGG = 0,
//    TOMATO,
//    ICECREAM,
//    SUSHI,
//    POTATO
    
    if (count < 0 || count > 5) {
        return nil;
    }

    NSMutableArray *foodList = [[[NSMutableArray alloc] init]autorelease];
    for (int i = 0; i < count; ++ i) {
        UIImage *image = [FoodManager imageForType:i];
        Food *food = [[Food alloc] initWithType:i image:image retainCount:100];
        [foodList addObject:food];
        [food release];
    }
    return foodList;
}

- (void)dealloc
{
    [super dealloc];
}

@end
