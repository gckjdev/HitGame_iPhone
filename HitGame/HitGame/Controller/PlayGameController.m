//
//  PlayGameController.m
//  HitGameTest
//
//  Created by  on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlayGameController.h"
#import <QuartzCore/QuartzCore.h>
#import "AnimationManager.h"
#import "FoodListView.h"
#import "TestCase.h"
#import "PlayerListView.h"
#import "Food.h"
#import "FoodView.h"
#import "FoodManager.h"
#import "GameLevel.h"
#import "HGQuadCurveMenu.h"


#define FALL_TIMER_DURATION 3
#define FALL_ANIMATION_DURATION 3
#define FALL_ROTATION_COUNT 4
#define MISSING_ROTATION_COUNT 6
#define MISSING_ANIMATION_DURATION 0.5
#define ANIMATION_KEY_ROTATION @"RotationFood"
#define ANIMATION_KEY_MISSING @"MissingFood"
#define ANIMATION_KEY_TRANSLATION @"TranslationFood"

#define ANIMATION_KILL_END @"KillEnd"
#define ANIMATION_NORMAL_END @"NormalEnd"
#define ANIMATION_ID_FOODVIEW @"FOODVIEW"
#define GAME_TIME 60.0

@implementation PlayGameController
@synthesize scoreLabel = _scoreLabel;
@synthesize gameLevel = _gameLevel;
@synthesize missLabel = _missLabel;




- (id)initWithGameLevel:(GameLevel *)gameLevel
{
    self = [super init];
    if (self) {
        self.gameLevel = gameLevel;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _fallingFoodViewList = [[NSMutableSet alloc] init];
        _foodManager = [FoodManager defaultManager];

    }
    return self;
}

- (void)dealloc
{
    [_gameLevel release];
    [_fallingFoodViewList release];
    [_scoreLabel release];
    [_missLabel release];
    [super dealloc];
}

- (Food *)randFood
{
    NSArray *foodList = _gameLevel.foodList;
    return [foodList objectAtIndex:ABS((random())%[foodList count])];
}

- (void)addDefaultMissingAnimationTofoodView:(FoodView *)foodView
{
    if (foodView) {
        if ([foodView.layer animationForKey:ANIMATION_KEY_MISSING]) {
            return;
        }
        CAAnimation *missingAnimation = [AnimationManager 
                                         missingAnimationWithDuration:MISSING_ANIMATION_DURATION];
        missingAnimation.delegate = self;
        [missingAnimation setValue:ANIMATION_KILL_END forKey:ANIMATION_KILL_END];
        [missingAnimation setValue:foodView forKey:ANIMATION_ID_FOODVIEW];
        CAAnimation *rotation = [AnimationManager 
                                 rotationAnimationWithRoundCount:MISSING_ROTATION_COUNT 
                                 duration:MISSING_ANIMATION_DURATION];
        [foodView.layer addAnimation:missingAnimation forKey:ANIMATION_KEY_MISSING];
        [foodView.layer addAnimation:rotation forKey:ANIMATION_KEY_ROTATION];
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - button gesture

#define FOOD_BUTTON_MIN_TAG 2010
#define FOOD_BUTTON_MAX_TAG 2014

- (void)performSwipeGesture:(UISwipeGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded){

    }
}
- (void)performRotationGesture:(UIRotationGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded){

    }
}

- (void)performLongPressGesture:(UILongPressGestureRecognizer *)recognizer
{    
    if(recognizer.state == UIGestureRecognizerStateEnded){

    }
}
- (void)performTapGesture:(UITapGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded){
        FoodType foodType = [_foodManager foodTypeForGuesture:TapGameGesture];
        FoodView *foodView = [self getFoodViewWithFoodType:foodType];
        [self addDefaultMissingAnimationTofoodView:foodView];
    }
}
- (void)performPinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded){
        
    }
}

- (void)performPanGesture:(UIPanGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded){
        FoodType foodType = Illegal;
        CGPoint point = [recognizer translationInView:self.view];
        //左边
        GameGestureType gameGestureType = IllegalGameGesture;
        if (point.x < 0) {
            //左扫
            if (ABS(point.x) >= ABS(point.y)) {
                gameGestureType = LeftPanGameGesture;
            }else if(point.y > 0){            //下扫
                gameGestureType = DownPanGameGesture;                
            }else{            //上扫
                gameGestureType = UpPanGameGesture;
            }
        }else{
            //右扫
            if (ABS(point.x) >= ABS(point.y)) {
                gameGestureType = RightPanGameGesture;
            }else if(point.y > 0){            //下扫
                gameGestureType = DownPanGameGesture;                
            }else{                              //上扫
                gameGestureType = UpPanGameGesture;
            }
        }
        foodType = [_foodManager foodTypeForGuesture:gameGestureType];
        FoodView *foodView = [self getFoodViewWithFoodType:foodType];
        [self addDefaultMissingAnimationTofoodView:foodView];
    }
}

- (FoodView *)fallFood:(Food*) food
{
    
    if (food == nil) {
        return nil;
    }
    
    FoodView *image = [[[FoodView alloc] initWithFood:food] autorelease];
    image.frame = CGRectMake(-48, -48, 48, 48);
    [self.view insertSubview:image atIndex:0];
    CAAnimation *translation = [AnimationManager translationAnimationFrom:CGPointMake(rand()%320, -48) to:CGPointMake(rand()%320, 400+24) duration:FALL_ANIMATION_DURATION];
    CAAnimation *rotation = [AnimationManager rotationAnimationWithRoundCount:FALL_ROTATION_COUNT duration:FALL_ANIMATION_DURATION];
    translation.fillMode = kCAFillModeForwards;
    translation.removedOnCompletion = NO ;
    translation.delegate = self;
    [translation setValue:image forKey:ANIMATION_ID_FOODVIEW];
    [translation setValue:ANIMATION_NORMAL_END forKey:ANIMATION_NORMAL_END];
    [image.layer addAnimation:translation forKey:ANIMATION_KEY_TRANSLATION];
    [image.layer addAnimation:rotation forKey:ANIMATION_KEY_ROTATION];
    return image;
}

- (void)startfallFoodTimer
{
    [_fallFoodTimer invalidate];
    _fallFoodTimer = nil;
    [self fallRandFood];
    _fallFoodTimer = [NSTimer scheduledTimerWithTimeInterval:FALL_TIMER_DURATION
                                                      target:self 
                                                    selector:@selector(fallRandFood) 
                                                    userInfo:nil 
                                                     repeats:YES];
}

- (void)killFoodView:(FoodView *)foodView
{
    _score ++;
    [_scoreLabel setText:[NSString stringWithFormat:@"分数: %d",_score * 100]];
    
}

- (void)normalEndFoodView:(FoodView *)foodView
{
    [self.missLabel setText:[NSString stringWithFormat:@"失误: %d",_count - _score]];
    if (_count - _score == 3) {
        [self gameGoEnd];
    }
}

- (void)animationDidStart:(CAAnimation *)anim
{
    FoodView *foodView = [anim valueForKey:ANIMATION_ID_FOODVIEW];
    if (foodView) {
        if ([anim valueForKey:ANIMATION_KILL_END]) {
            [self killFoodView:foodView];
        } 
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if (flag) {
        FoodView *foodView = [anim valueForKey:ANIMATION_ID_FOODVIEW];
        if (foodView) {
            _count ++;

            if ([anim valueForKey:ANIMATION_KILL_END]) {
            }else{
                [self normalEndFoodView:foodView];
            }
            [foodView.layer removeAllAnimations];
            [_fallingFoodViewList removeObject:foodView];
            [foodView removeFromSuperview];
            if ([_fallingFoodViewList count] < 1 && _gameStatus == OnGoing) {
                [self fallRandFood];
            }
        }

    }

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == self.view) {
        return YES;
    }
    return NO;
}
 

- (void)view:(UIView *)view addGestureRecognizer:(NSInteger)type 
    delegate:(id<UIGestureRecognizerDelegate>)delegate
{
    UIGestureRecognizer *recognizer = nil;
    SEL action = nil;
    switch (type) {
        case LongPressGestureRecognizer:
            action = @selector(performLongPressGesture:);
            recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case PanGestureRecognizer:
            action = @selector(performPanGesture:);
            recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case PinchGestureRecognizer:
            action = @selector(performPinchGesture:);
            recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case RotationGestureRecognizer:
            action = @selector(performRotationGesture:);
            recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case SwipeGestureRecognizer:
            action = @selector(performSwipeGesture:);
            recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case TapGestureRecognizer:
            action = @selector(performTapGesture:);
            recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
            ((UITapGestureRecognizer *)recognizer).numberOfTapsRequired = 1;
            break;
        default:
            return;
    }
    recognizer.delegate = delegate;
    [view addGestureRecognizer:recognizer];
    [recognizer release];
}


- (FoodView *)getFoodViewWithFoodType:(FoodType)foodType
{
    if (_fallingFoodViewList) {
        for(FoodView *foodView in _fallingFoodViewList)
        {
            if (foodView && [foodView foodType] == foodType) {
                return foodView;
            }
        }
    }
    return nil;
}


- (void)fallRandFood
{
    Food *food = [self randFood];
    FoodView *foodView = [self fallFood:food];
    [_fallingFoodViewList addObject:foodView];
}

- (void)gameGoEnd
{
    
    [_fallFoodTimer invalidate];
    [_gameTimer invalidate];
    _fallFoodTimer = nil;
    _gameTimer = nil;
    for (FoodView *foodView in _fallingFoodViewList) {
        if (foodView) {
            [foodView removeFromSuperview];
            [foodView.layer removeAllAnimations];
        }
    }
    [_fallingFoodViewList removeAllObjects];
    
    BOOL fail = (_count - _score) >= 3 ? YES : NO;
    NSString *msg = nil;
    if (fail) {
        msg = [NSString stringWithFormat:@"对不起，您失误了三次，本轮游戏失败！"];
        _gameStatus = Fail;
    }else{
        msg = [NSString stringWithFormat:@"您的分数是:%d, 失误:%d次",_score,_count-_score];
        _gameStatus = Sucess;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"游戏结束" 
                                                    message:msg 
                                                   delegate:self 
                                          cancelButtonTitle:@"确定" 
                                          otherButtonTitles:@"重试", nil];
    [alert show];
    [alert release];
}


- (void)adjustClock
{
    UIProgressView *progress = (UIProgressView *)[self.view viewWithTag:61];
    UILabel *timeLabel = (UILabel *)[self.view viewWithTag:60];
    [progress setProgress:_retainSeconds/GAME_TIME];
    [timeLabel setText:[NSString stringWithFormat:@"%.0f",_retainSeconds]];
}

- (void)startGame
{
    _score = 0;
    _count = 0;
    _gameStatus = OnGoing;
    _retainSeconds = GAME_TIME;
    [self.scoreLabel setText:@"得分: 0"];
    [self.missLabel setText:@"失误: 0"];
    [self adjustClock];
//    [self startfallFoodTimer];
    [self fallRandFood];
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 
                                                  target:self 
                                                selector:@selector(clock) 
                                                userInfo:nil 
                                                 repeats:YES];
    

}

- (void)clock
{
    _retainSeconds -= 0.1;    
    [self adjustClock];
    if (_retainSeconds <= 0) {
        [self gameGoEnd];
    }
}

#pragma - mark alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self startGame];
    }
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (int type = LongPressGestureRecognizer; type < GestureRecognizerTypeCount; ++ type) {
        [self view:self.view addGestureRecognizer:type delegate:self];
    }
    [self startGame];

}

- (void)viewDidUnload
{
    [self setScoreLabel:nil];
    [self setMissLabel:nil];
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - action
- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
