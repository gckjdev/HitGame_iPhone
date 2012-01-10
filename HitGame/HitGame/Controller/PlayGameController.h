//
//  PlayGameController.h
//  HitGameTest
//
//  Created by  on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Enum.h"
#import "HGQuadCurveMenu.h"


@class Food;
@class FoodView;
@class FoodManager;
@class GameLevel;
@class LevelManager;

@interface PlayGameController : UIViewController <UIGestureRecognizerDelegate, UIAlertViewDelegate, HGQuadCurveMenuDelegate>
{

    NSMutableSet *_fallingFoodViewList;
    FoodManager *_foodManager;
    
    NSInteger _score;
    NSInteger _count;
    NSInteger _passScore;
    NSInteger _missCount;
    NSInteger _allowMissCount;

    NSTimer *_gameTimer;
    CFTimeInterval _retainSeconds;
    CFTimeInterval _roundTime;

    GameLevel *_gameLevel;
    GameStatus _gameStatus;
    LevelManager *_levelManager;
}

@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;
@property (retain, nonatomic) IBOutlet UILabel *missLabel;
@property (retain, nonatomic) GameLevel *gameLevel;
@property (retain, nonatomic) IBOutlet UILabel *levelLabel;

@property (retain, nonatomic) IBOutlet UILabel *popupScoreView;

@property (retain, nonatomic) IBOutlet UILabel *popupMissView;

- (id)initWithGameLevel:(GameLevel *)gameLevel;
- (FoodView *)getFoodViewWithFoodType:(FoodType)foodType;

- (void)fallRandFood;
- (void)startGame;
- (void)resumeGame;
- (void)pauseGame;
- (void)endGame:(BOOL)isSuccessful;
- (void)quitGame:(BOOL)backToLevelPick;
- (void)processStateMachine;

- (void)addDefaultMissingAnimationTofoodView:(FoodView *)foodView;

@end
