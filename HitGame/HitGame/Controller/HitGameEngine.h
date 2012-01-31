//
//  HitGameEngine.h
//  HitGame
//
//  Created by Orange on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

struct HGAction {
    NSInteger x;
    NSInteger y;
};
typedef struct HGAction HGAction;

enum GAME_STATUS {
    gameStatRunning = 0,
    gameStatPause ,
    
    };

@protocol HitGameEngineDelegate <NSObject>
 @optional
- (void)preparedGame;
- (void)waitAction:(NSInteger)anAction;
- (void)goodAction;
- (void)badAction;
- (void)pauseGame;
- (void)accomplish;
- (void)failed;
- (void)reactoin:(HGAction)aReaction;
- (void)sumitReaction;
- (void)showActionRequest:(HGAction)anAction reactionTime:(float)anReactionTime;
- (void)missAnAction;
@end

@interface HitGameEngine : NSObject {
    NSInteger _gameStatus;
    HGAction _requestAction;
    HGAction _currentAction;
    NSTimer* _gameTimer;
    NSTimer* _actionTimer;
    float _retainSeconds;
    float _originActionTime;
    int _missCount;
}

@property (assign, nonatomic) float actionTime;
@property (assign, nonatomic) float gameTime;
@property (assign, nonatomic) id<HitGameEngineDelegate> delegate;
@property (assign, nonatomic) HGAction currentAction;

- (id)initWithActionTime:(float)actionTime;
- (void)gameStart;
- (void)gamePause;
- (void)gameEnd:(BOOL)isSuccessful;
- (void)makeAction:(HGAction)anAction;
- (void)sumitAction;
@end
