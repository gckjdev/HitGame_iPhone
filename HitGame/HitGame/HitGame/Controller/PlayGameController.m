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


#define FALL_TIMER_DURATION 2
#define FALL_ANIMATION_DURATION 2
#define FALL_ROTATION_COUNT 4
#define MISSING_ROTATION_COUNT 6
#define MISSING_ANIMATION_DURATION 0.5
#define ANIMATION_KEY_ROTATION @"rotation"
#define ANIMATION_KEY_MISSING @"missing"
#define ANIMATION_KEY_TRANSLATION @"translation"
#define GAME_TIME 60.0

@implementation PlayGameController
@synthesize gestureTipsLabel = _gestureTipsLabel;
@synthesize scoreLabel = _scoreLabel;
@synthesize game = _game;

- (id)initWithGame:(Game *)game
{
    self = [super init];
    if (self) {
        self.game = game;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _foodList = [[TestCase createFoodList:5] retain];
        _fallingFoodViewList = [[NSMutableSet alloc] init];
        _foodManager = [FoodManager defaultManager];

    }
    return self;
}

- (void)dealloc
{
    [_foodList release];
    [_fallingFoodViewList release];
    [_gestureTipsLabel release];
    [_scoreLabel release];
    [super dealloc];
}

- (Food *)randFood
{
    return [_foodList objectAtIndex:rand()%5];
}

- (void)addDefaultMissingAnimationTofoodView:(FoodView *)foodView
{
    if (foodView) {
        if ([foodView.layer animationForKey:ANIMATION_KEY_MISSING]) {
            return;
        }
        CAAnimation *missingAnimation = [AnimationManager 
                                         missingAnimationWithDuration:MISSING_ANIMATION_DURATION];
        CAAnimation *rotation = [AnimationManager 
                                 rotationAnimationWithRoundCount:MISSING_ROTATION_COUNT 
                                 duration:MISSING_ANIMATION_DURATION];
        [foodView.layer addAnimation:missingAnimation forKey:ANIMATION_KEY_MISSING];
        [foodView.layer addAnimation:rotation forKey:ANIMATION_KEY_ROTATION];
        _score ++;
        [_scoreLabel setText:[NSString stringWithFormat:@"分数: %d",_score]];
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
    NSLog(@"performPanGesture:");
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
    _count ++;
    
    NSString *tips = [NSString stringWithFormat:@"手势: %@", [_foodManager gestureStringForFoodType:food.type]];
    [self.gestureTipsLabel setText:tips];
    
    FoodView *image = [[[FoodView alloc] initWithFood:food] autorelease];
    image.frame = CGRectMake(-48, -48, 48, 48);
    [self.view addSubview:image];
    CAAnimation *translation = [AnimationManager translationAnimationFrom:CGPointMake(rand()%320, -48) to:CGPointMake(rand()%320, 480+48) duration:FALL_ANIMATION_DURATION];
    CAAnimation *rotation = [AnimationManager rotationAnimationWithRoundCount:FALL_ROTATION_COUNT duration:FALL_ANIMATION_DURATION];
    translation.fillMode = kCAFillModeForwards;
    translation.removedOnCompletion = NO ;
    translation.delegate = self;
    [translation setValue:image forKey:@"foodView"];
    [image.layer addAnimation:translation forKey:ANIMATION_KEY_TRANSLATION];
    [image.layer addAnimation:rotation forKey:ANIMATION_KEY_ROTATION];
    return image;
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    FoodView *foodView = [anim valueForKey:@"foodView"];
    if (foodView) {
        [foodView.layer removeAllAnimations];
        [_fallingFoodViewList removeObject:foodView];
        [foodView removeFromSuperview];
    }
    foodView = nil;
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

#pragma mark - View lifecycle

- (void)fallRandFood
{
    Food *food = [self randFood];
    FoodView *foodView = [self fallFood:food];
    [_fallingFoodViewList addObject:foodView];
}

- (void)gameTimeout
{
    [_fallFoodTimer invalidate];
    [_gameTimer invalidate];
    _fallFoodTimer = nil;
    _gameTimer = nil;
    NSString *msg = [NSString stringWithFormat:@"您的分数是:%d, 失误:%d次",_score,_count-_score];
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
    [timeLabel setText:[NSString stringWithFormat:@"%d",_retainSeconds]];
}

- (void)startGame
{
    _score = 0;
    _count = 0;
    _retainSeconds = GAME_TIME;
    [self adjustClock];
    [self fallRandFood];
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:1 
                                                  target:self 
                                                selector:@selector(clock) 
                                                userInfo:nil 
                                                 repeats:YES];
    
    _fallFoodTimer = [NSTimer scheduledTimerWithTimeInterval:FALL_TIMER_DURATION
                                                      target:self 
                                                    selector:@selector(fallRandFood) 
                                                    userInfo:nil 
                                                     repeats:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttont index = %d",buttonIndex);
    if (buttonIndex == 1) {
        [self startGame];
    }
}

- (void)clock
{
    _retainSeconds --;    
    [self adjustClock];
    if (_retainSeconds == 0) {
        [self gameTimeout];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    for (int type = LongPressGestureRecognizer; type < GestureRecognizerTypeCount; ++ type) {
        [self view:self.view addGestureRecognizer:type delegate:self];
    }
    [self startGame];
    
}

- (void)viewDidUnload
{
    [self setGestureTipsLabel:nil];
    [self setScoreLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
