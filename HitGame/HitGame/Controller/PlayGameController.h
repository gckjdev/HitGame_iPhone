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


@class Food;
@class FoodView;
@class FoodManager;
@class GameLevel;
@interface PlayGameController : UIViewController <UIGestureRecognizerDelegate, UIAlertViewDelegate>
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
    NSInteger _retainSeconds;
    NSInteger _speed;
    NSInteger _passScore;
    GameLevel *_gameLevel;
}

@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;
@property (retain, nonatomic) GameLevel *gameLevel;

- (IBAction)clickBackButton:(id)sender;

- (id)initWithGameLevel:(GameLevel *)gameLevel;
- (FoodView *)getFoodViewWithFoodType:(FoodType)foodType;
@end
