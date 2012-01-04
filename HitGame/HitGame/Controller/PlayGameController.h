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
@interface PlayGameController : UIViewController <UIGestureRecognizerDelegate, UIAlertViewDelegate, HGQuadCurveMenuDelegate>
{
    FoodView *_movingFood;
    NSInteger _movingStatus;    
    NSMutableSet *_fallingFoodViewList;
    FoodView *_throwingFood;
    FoodManager *_foodManager;
    NSInteger _score;
    NSInteger _count;
    NSTimer *_fallFoodTimer;
    NSTimer *_gameTimer;
    CGFloat _retainSeconds;
    NSInteger _speed;
    NSInteger _passScore;
    GameLevel *_gameLevel;
    GameStatus _gameStatus;
}

@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;
@property (retain, nonatomic) GameLevel *gameLevel;
@property (retain, nonatomic) IBOutlet UILabel *missLabel;

- (IBAction)clickBackButton:(id)sender;

- (id)initWithGameLevel:(GameLevel *)gameLevel;
- (FoodView *)getFoodViewWithFoodType:(FoodType)foodType;
- (void)gameGoEnd;
- (void)fallRandFood;

@end
