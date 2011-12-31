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
enum{
    STATIONARY = 0,
    MOVING_UP = 1,
    MOVING_DOWN = 2
};

@class Game;
@class Food;
@class FoodView;
@class FoodManager;

@interface PlayGameController : UIViewController <UIGestureRecognizerDelegate, UIAlertViewDelegate>
{
    Game *_game;
    FoodView *_movingFood;
    NSInteger _movingStatus;
    NSArray *_foodList;
    
    NSMutableSet *_fallingFoodViewList;
    FoodView *_throwingFood;
    FoodManager *_foodManager;
    NSInteger _score;
    NSInteger _count;
    NSTimer *_fallFoodTimer;
    NSTimer *_gameTimer;
    NSInteger _retainSeconds;
}

@property (retain, nonatomic) IBOutlet UILabel *gestureTipsLabel;
@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;
@property(nonatomic, retain) Game *game;

- (id)initWithGame:(Game *)game;

- (FoodView *)getFoodViewWithFoodType:(FoodType)foodType;
@end
