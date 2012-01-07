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
#import "HighScoreManager.h"
#import "LayerUtil.h"


#define FALL_TIMER_DURATION 3
#define FALL_ANIMATION_DURATION 3
#define FALL_ROTATION_COUNT 4

#define MISSING_ROTATION_COUNT 6
#define MISSING_ANIMATION_DURATION 0.5

#define GAME_TIMER_INTERVAL 0.1

#define ANIMATION_KEY_ROTATION @"RotationFood"
#define ANIMATION_KEY_MISSING @"MissingFood"
#define ANIMATION_KEY_TRANSLATION @"TranslationFood"

#define ANIMATION_TAG_MISS @"MissTag"
#define ANIMATION_TAG_FALL @"FallTag"
#define ANIMATION_ID_FOODVIEW @"FoodView"



#define ROUND_TIME [[[NSBundle mainBundle] objectForInfoDictionaryKey:\
                @"CFRoundTime"] doubleValue]
#define ALLOW_MISS_COUNT [[[NSBundle mainBundle] objectForInfoDictionaryKey:\
                @"CFAllowMissCount"] doubleValue]



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

- (void)readConfig
{
    _allowMissCount = ALLOW_MISS_COUNT;
    _roundTime = ROUND_TIME;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _fallingFoodViewList = [[NSMutableSet alloc] init];
        _foodManager = [FoodManager defaultManager];
        [self readConfig];

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



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - game gesture process
 
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
- (void)performPinchGesture:(UIPinchGestureRecognizer *)recognizer
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


#pragma mark - fall ball animation

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
        [missingAnimation setValue:ANIMATION_TAG_MISS forKey:ANIMATION_TAG_MISS];
        [missingAnimation setValue:foodView forKey:ANIMATION_ID_FOODVIEW];
        
        CAAnimation *rotation = [AnimationManager 
                                 rotationAnimationWithRoundCount:MISSING_ROTATION_COUNT 
                                 duration:MISSING_ANIMATION_DURATION];
        [foodView.layer addAnimation:missingAnimation forKey:ANIMATION_KEY_MISSING];
        [foodView.layer addAnimation:rotation forKey:ANIMATION_KEY_ROTATION];
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
    CAAnimation *translation = [AnimationManager translationAnimationFrom:CGPointMake(rand()%320, -24) to:CGPointMake(rand()%320, 400+24) duration:FALL_ANIMATION_DURATION delegate:self removeCompeleted:NO];
    
    [translation setValue:image forKey:ANIMATION_ID_FOODVIEW];
    [translation setValue:ANIMATION_TAG_FALL forKey:ANIMATION_TAG_FALL];
    
    [image.layer addAnimation:translation forKey:ANIMATION_KEY_TRANSLATION];
    CAAnimation *rotation = [AnimationManager rotationAnimationWithRoundCount:FALL_ROTATION_COUNT duration:FALL_ANIMATION_DURATION];

    [image.layer addAnimation:rotation forKey:ANIMATION_KEY_ROTATION];
    return image;
}



- (void)killFoodView:(FoodView *)foodView
{
    if (foodView.status == Falling) {
        _score ++;
        [_scoreLabel setText:[NSString stringWithFormat:@"分数: %d",_score * 100]];
        foodView.status = Killed;
    }
}

- (void)normalEndFoodView:(FoodView *)foodView
{
    if (foodView.status == Falling) {
        _missCount ++;
        foodView.status = Dead;
        [self.missLabel setText:[NSString stringWithFormat:@"失误: %d",_missCount]];
        if (_missCount == _allowMissCount) {
            _gameStatus = Fail;
            [self processStateMachine];
        }else {
            [self fallRandFood];
        }
    }

}

- (void)animationDidStart:(CAAnimation *)anim
{
    FoodView *foodView = [anim valueForKey:ANIMATION_ID_FOODVIEW];
    if (foodView) {
        if ([anim valueForKey:ANIMATION_TAG_MISS]) {
            [self killFoodView:foodView];
        }else{
            
        }
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if (flag) {
        FoodView *foodView = [anim valueForKey:ANIMATION_ID_FOODVIEW];
        if (foodView) {
            //if is miss animation end.
            if ([anim valueForKey:ANIMATION_TAG_MISS]) {
                
            }else if([anim valueForKey:ANIMATION_TAG_FALL]){
                [self normalEndFoodView:foodView];
            }
            [foodView.layer removeAllAnimations];
            [_fallingFoodViewList removeObject:foodView];
            [foodView removeFromSuperview];
            [self fallRandFood];

        }

    }

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
    if ([_fallingFoodViewList count] < 1 && _gameStatus == OnGoing){
        Food *food = [self randFood];
        FoodView *foodView = [self fallFood:food];
        [_fallingFoodViewList addObject:foodView];
        _count ++;
    }
}





#pragma mark - game attributes setting
- (void)adjustClock
{
    UIProgressView *progress = (UIProgressView *)[self.view viewWithTag:61];
    UILabel *timeLabel = (UILabel *)[self.view viewWithTag:60];
    [progress setProgress:_retainSeconds / _roundTime];
    [timeLabel setText:[NSString stringWithFormat:@"%.0f",ABS(_retainSeconds)]];
}

- (void)stopClockTimer
{
    [_gameTimer invalidate];
    _gameTimer = nil;
}

- (void)timerClock
{
    _retainSeconds -= GAME_TIMER_INTERVAL;    
    [self adjustClock];
    if (_retainSeconds <= 0) {
        _gameStatus = Sucess;
        [self processStateMachine];
    }
}

- (void)startClockTimer
{
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAME_TIMER_INTERVAL 
                                                  target:self 
                                                selector:@selector(timerClock) 
                                                userInfo:nil 
                                                 repeats:YES];
}


- (void)releaseAllFoodViews
{
    for (FoodView *foodView in _fallingFoodViewList) {
        if (foodView) {
            [foodView.layer removeAllAnimations];
            [foodView removeFromSuperview];
        }
    }
    [_fallingFoodViewList removeAllObjects];
}

- (void)resetAttributes
{
    _score = 0;
    _count = 0;
    _retainSeconds = _roundTime;
    [self adjustClock];
    [self releaseAllFoodViews];
    [self.scoreLabel setText:@"得分: 0"];
    [self.missLabel setText:@"失误: 0"];
}

#pragma mark - game process control

- (void)pauseGame
{
    _gameStatus = Pause;
    [self stopClockTimer];
    [self adjustClock];
    for (FoodView *foodView in _fallingFoodViewList) {
        [LayerUtil pauseLayer:foodView.layer];
    }
}

- (void)resumeGame
{
    _gameStatus = OnGoing;
    [self startClockTimer];
    for (FoodView *foodView in _fallingFoodViewList) {
        [LayerUtil resumeLayer:foodView.layer];
    }
}

- (void)startGame
{
    _gameStatus = OnGoing;
    _retainSeconds = _roundTime;
    [self startClockTimer];
    [self resetAttributes];
    [self fallRandFood];

}

- (void)endGame:(BOOL)isSuccessful
{
    [self stopClockTimer];
    [self adjustClock];
    NSString *msg = nil;
    if (!isSuccessful) {
        msg = [NSString stringWithFormat:@"对不起，您失误了三次，本轮游戏失败！"];
    }else{
        msg = [NSString stringWithFormat:@"恭喜过关！您的分数是:%d!",_score * 100];

    }
    [self releaseAllFoodViews];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"游戏结束" 
                                                    message:msg 
                                                   delegate:self 
                                          cancelButtonTitle:@"确定" 
                                          otherButtonTitles:@"重试", nil];
    [alert show];
    [alert release];
    HighScoreManager* manager = [HighScoreManager defaultManager];
    [manager addHighScore:_score forLevel:1];
}

- (void)quitGame:(BOOL)backToLevelPick
{
    
    [self stopClockTimer];
    [self releaseAllFoodViews];
    [self resetAttributes];
    if (backToLevelPick) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //
    }
}

- (void)processStateMachine
{
    switch (_gameStatus) {
        case Ready:
            [self startGame];
            break;
        case Pause:
            [self pauseGame];
            break;
        case Resume:
            [self resumeGame];
            break;
        case Fail:
            [self endGame:NO];
            break;
        case Sucess:
            [self endGame:YES];
            break;
        case BackToLevelPicker:
            [self quitGame:YES];
            break;
        case BackToMainMenu:
            [self quitGame:NO];
            break;
        case OnGoing:
        default:
            break;
    }
    
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        _gameStatus = Ready;
        [self processStateMachine];
    }
}


#pragma mark - HGQuadCurveMenu

- (void)quadCurveMenu:(HGQuadCurveMenu *)menu didSelectIndex:(NSInteger)anIndex
{
    switch (anIndex) {
        case CONTINUE_GAME:
            _gameStatus = Resume;
            break;
        case REPLAY_GAME: {
            _gameStatus = Ready;
            break;
        }
        case QUIT_GAME: {
            _gameStatus = BackToLevelPicker;
            break;
        }
        default:
            _gameStatus = OnGoing;
            break;
    }
    [self processStateMachine];

}

- (void)quadCurveMenuDidExpand
{
    _gameStatus = Pause;
    [self processStateMachine];
}
- (void)quadCurveMenuDidClose
{
    _gameStatus = Resume;
    [self processStateMachine];
}

- (void)addOptionButton
{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];  
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    HGQuadCurveMenuItem *continueGame = [[HGQuadCurveMenuItem alloc] initWithImage:storyMenuItemImage 
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   contentImage:starImage 
                                                        highlightedContentImage:nil 
                                                                          title:@"继续"];
    HGQuadCurveMenuItem *rePlayGame = [[HGQuadCurveMenuItem alloc] initWithImage:storyMenuItemImage 
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   contentImage:starImage 
                                                        highlightedContentImage:nil 
                                                                          title:@"重玩"];
    HGQuadCurveMenuItem *quitGame = [[HGQuadCurveMenuItem alloc] initWithImage:storyMenuItemImage 
                                                                   highlightedImage:storyMenuItemImagePressed 
                                                                       contentImage:starImage 
                                                            highlightedContentImage:nil 
                                                                              title:@"离开"];
    
    NSArray *menus = [NSArray arrayWithObjects:continueGame, rePlayGame, quitGame, nil];
    [continueGame release];
    [rePlayGame release];
    [quitGame release];
    
    HGQuadCurveMenu *menu = [[HGQuadCurveMenu alloc] 
                             initWithFrame:self.view.bounds
                             menus:menus 
                             nearRadius:210 
                             endRadius:220 
                             farRadius:230 
                             startPoint:CGPointMake(40, 430) 
                             timeOffset:0.036 
                             rotateAngle:0
                             menuWholeAngle:(M_PI/1.7)
                             buttonImage:[UIImage imageNamed:@"bg-addbutton.png"] 
                             buttonHighLightImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"] 
                             contentImage:[UIImage imageNamed:@"icon-plus.png"] 
                             contentHighLightImage:[UIImage imageNamed:@"icon-plus-highlight.png"]];
    menu.delegate = self;
    [self.view addSubview:menu];
    [menu release];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (int type = LongPressGestureRecognizer; type < GestureRecognizerTypeCount; ++ type) {
        [self view:self.view addGestureRecognizer:type delegate:self];
    }
    [self addOptionButton];
    _gameStatus = Ready;
    [self processStateMachine];

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

@end
