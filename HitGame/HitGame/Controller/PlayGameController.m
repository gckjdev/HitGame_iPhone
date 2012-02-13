//
//  PlayGameController.m
//  HitGameTest
//
//  Created by  on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlayGameController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AnimationManager.h"
#import "FoodListView.h"
#import "TestCase.h"
#import "Food.h"
#import "FoodView.h"
#import "FoodManager.h"
#import "GameLevel.h"
#import "HighScoreManager.h"
#import "LayerUtil.h"
#import "LevelManager.h"
#import "GameSettingManager.h"
#import "AudioManager.h"
#import "GestureTraceView.h"
#import "Style.h"
#import "TKProgressBarView.h"

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

#define POPUP_MESSAGE_DURATION 2

#define ROUND_TIME [[[NSBundle mainBundle] objectForInfoDictionaryKey:\
                @"CFRoundTime"] doubleValue]
#define ALLOW_MISS_COUNT [[[NSBundle mainBundle] objectForInfoDictionaryKey:\
                @"CFAllowMissCount"] doubleValue]




@implementation PlayGameController
@synthesize scoreLabel = _scoreLabel;
@synthesize gameLevel = _gameLevel;
@synthesize levelLabel = _levelLabel;
@synthesize popupScoreView = _popupScoreView;
@synthesize popupMissView = _popupMissView;
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
        _levelManager = [LevelManager defaultManager];
        _progress = [[TKProgressBarView alloc] initWithStyle:TKProgressBarViewStyleLong];
        _progress.center = CGPointMake(164, 18);        
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
    [_levelLabel release];
    [_popupScoreView release];
    [_popupMissView release];
    [_progress release];
    [super dealloc];
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)isMissCountEnough
{
    return _missCount >= _allowMissCount;
}

#define DECREASE_SCORE_WRONG_GESTURE 30
- (void)dealWithWrongGesture
{
    BOOL hasFood = NO;
    for (FoodView *foodView in _fallingFoodViewList) {
        hasFood = YES;
        if (foodView.foodViewScore > 0) {
            foodView.foodViewScore -= DECREASE_SCORE_WRONG_GESTURE;
            foodView.foodViewScore = MAX(0, foodView.foodViewScore);
        }
    }
    if (hasFood) {
        [self popUpMsg:NSLocalizedString(@"手势不对哦", @"错误手势提示") textColor:COLOR_POPUP_WRONG_GESTURE];
    }
}

- (void)increaseMissCount
{
    NSString* missCounter = NSLocalizedString(@"失误", @"失误计数");
    [self.missLabel setText:[NSString stringWithFormat:@"%@: %d", missCounter, ++ _missCount]];
}

- (void)vibrate
{
    if ([GameSettingManager isVibration]) {
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    }
}

- (void)reFreshLevelLabel
{
    NSString* levelString = NSLocalizedString(@"关卡", @"");
    if (_gameLevel) {
        [_levelLabel setText:[NSString stringWithFormat:@"%@:", levelString, _gameLevel.levelIndex]];
    }
}

- (CFTimeInterval)calculateFallDuration
{
    CFTimeInterval maxInterval = [_levelManager calculateMaxDuration:_gameLevel];
    CFTimeInterval minInterval = [_levelManager calculateMinDuration:_gameLevel];

    CFTimeInterval ret = (maxInterval - minInterval) / pow(_roundTime, 2) * pow(_retainSeconds, 2) +minInterval;
    //CFTimeInterval ret = (minInterval - maxInterval) * sin(M_PI/(2*_roundTime)*(_roundTime-_retainSeconds))+maxInterval;//method 2,using sin func
    return ret;
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
        if (foodView == nil) {
            [self dealWithWrongGesture];
        }else{
            [self addDefaultMissingAnimationTofoodView:foodView];
        }
    }
}


- (void)performPanGesture:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [[AudioManager defaultManager] playSoundById:0];
        [_gestureTrace didStartGestrue:recognizer];
        [_gestureTrace didGestrue:recognizer MovedAtPoint:
         [recognizer locationInView:_gestureTrace]];
        
    }else if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        [_gestureTrace didGestrue:recognizer MovedAtPoint:
         [recognizer locationInView:_gestureTrace]];
        
    }else if(recognizer.state == UIGestureRecognizerStateEnded){
        [_gestureTrace didEndedGestrue:recognizer];
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
        if (foodView == nil) {
            [self dealWithWrongGesture];
        }else{
            [self addDefaultMissingAnimationTofoodView:foodView];
        }
    }
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == _gestureTrace) {
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
    image.endPoint = CGPointMake(rand()%320, 400+24);
    CAAnimation *translation = [AnimationManager translationAnimationFrom:CGPointMake(rand()%320, -24) to:image.endPoint duration:[self calculateFallDuration] delegate:self removeCompeleted:NO];
    
    [translation setValue:image forKey:ANIMATION_ID_FOODVIEW];
    [translation setValue:ANIMATION_TAG_FALL forKey:ANIMATION_TAG_FALL];
    
    [image.layer addAnimation:translation forKey:ANIMATION_KEY_TRANSLATION];
    CAAnimation *rotation = [AnimationManager rotationAnimationWithRoundCount:FALL_ROTATION_COUNT duration:FALL_ANIMATION_DURATION];

    [image.layer addAnimation:rotation forKey:ANIMATION_KEY_ROTATION];
    return image;
}


- (void)popUpMsg:(NSString *)msg textColor:(UIColor *)color
{
    [_popupScoreView setHidden:NO];
    [_popupScoreView setTextColor:color];
    [_popupScoreView setText:msg];     
    CAAnimation *popUp = [AnimationManager 
                          translationAnimationFrom:CGPointMake(160, 255) 
                          to:CGPointMake(160, 120) 
                          duration:POPUP_MESSAGE_DURATION];
    CAAnimation *popOpacity = [AnimationManager missingAnimationWithDuration:2];
    
    [self.popupScoreView.layer addAnimation:popUp forKey:@"popUp"];
    [_popupScoreView.layer addAnimation:popOpacity forKey:@"popOpacity"];
}

- (void)popUpScore:(NSInteger)score
{
    [self popUpMsg:[NSString stringWithFormat:@"+%d",score] textColor:COLOR_POPUP_SCORE];
}

- (void)killFoodView:(FoodView *)foodView
{
    if (foodView.status == Falling) {
        _score += foodView.foodViewScore;
        [self popUpScore:foodView.foodViewScore];
        [_scoreLabel setText:[NSString stringWithFormat:@"分数: %d",_score]];
        foodView.status = Killed;
    }
}

- (void)normalEndFoodView:(FoodView *)foodView
{
    if (foodView.status == Falling) {
        foodView.status = Dead;
        _popupMissView.center = CGPointMake(foodView.endPoint.x, 380);
        _popupMissView.hidden =NO;
        CAAnimation *missOpacity = [AnimationManager missingAnimationWithDuration:POPUP_MESSAGE_DURATION];
        [_popupMissView.layer addAnimation:missOpacity forKey:@"missOpacity"];
        [self increaseMissCount];
        [self vibrate];
        if ([self isMissCountEnough]) {
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
        _currentFood = [self fallFood:food];
        
        [_fallingFoodViewList addObject:_currentFood];
        _count ++;
    }
}





#pragma mark - game attributes setting
- (void)adjustClock
{
    //UIProgressView *progress = (UIProgressView *)[self.view viewWithTag:61];
    UILabel *timeLabel = (UILabel *)[self.view viewWithTag:60];
    [_progress setProgress:_retainSeconds / _roundTime];
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
    _missCount = 0;
    _retainSeconds = _roundTime;
    [self adjustClock];
    [self releaseAllFoodViews];
    [self.scoreLabel setText:NSLocalizedString(@"得分: 0", @"")];
    [self.missLabel setText:NSLocalizedString(@"失误: 0", @"")];
}

- (void)startPlayMusic
{
    [[AudioManager defaultManager] backgroundMusicStart];
}

enum {
    BGM_START = 0,
    BGM_PAUSE,
    BGM_CONTINUE,
    BGM_STOP
};

- (void) playBackGroundMusic:(NSInteger)anAction
{
    AudioManager* manager = [AudioManager defaultManager];
    switch (anAction) {
        case BGM_START: {
            [self performSelectorInBackground:@selector(startPlayMusic) withObject:nil];
            break;
        }
        case BGM_PAUSE: {
            [manager backgroundMusicPause];
            break;
        }
        case BGM_CONTINUE: {
            [manager backgroundMusicContinue];
            break;
        }
        case BGM_STOP: {
            [manager backgroundMusicStop];
            break;
        }
        default:
            break;
    }
    
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
    [self playBackGroundMusic:BGM_PAUSE];
}

- (void)resumeGame
{
    _gameStatus = OnGoing;
    
    [self startClockTimer];
    for (FoodView *foodView in _fallingFoodViewList) {
        [LayerUtil resumeLayer:foodView.layer];
    }
    [self playBackGroundMusic:BGM_CONTINUE];
}

- (void)startGame
{
    _gameStatus = OnGoing;
    _retainSeconds = _roundTime;
    [self startClockTimer];
    [self resetAttributes];
    [self fallRandFood];
    [self playBackGroundMusic:BGM_START];

}

- (void)showResult:(BOOL)isSuccessful
{
//    NSString *msg = nil;
//    NSString *title = nil;
    HighScoreManager* manager = [HighScoreManager defaultManager];
//    if (!isSuccessful) {
//        title = @"亲，你懂的!";
//        msg = @"一回生，两回熟，下次就过了";
        GameFinishView* view = [GameFinishView creatGameFinishViewWithDelegate:self 
                                                                    shouldRank:[manager shouldScore:_score RankInLevel:_gameLevel.levelIndex] 
                                                                  isSuccessful:isSuccessful 
                                                                         score:_score];
        [self.view addSubview:view];
//    }else {
//        title = @"亲，坚持了一分钟哦！";
//        msg = [NSString stringWithFormat:@"您的分数是:%d! 再闯一关？",_score];
//    }
    [self releaseAllFoodViews];
//    NSString *buttonMsg = (isSuccessful) ? @"下一关" : @"重玩";
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
//                                                    message:msg 
//                                                   delegate:self 
//                                          cancelButtonTitle:@"返回" 
//                                          otherButtonTitles:buttonMsg, nil];
//    if ([manager shouldScore:_score RankInLevel:_gameLevel.levelIndex]) {
//        [alert setTitle:@"恭喜进入高分榜"];
//        [alert setMessage:@"请输入你的大名:\n\n"];
//        UITextView* txtView = [[UITextView alloc] initWithFrame:CGRectMake(90, 70, 100, 30)];
//        txtView.tag = NAME_TEXT_VIEW_TAG;
//        //[alert addButtonWithTitle:@"确定"];
//        [alert addSubview:txtView];
//        [txtView release];
//    }
//    //[alert show];
//    [alert release];
}


- (void)endGame:(BOOL)isSuccessful
{
    [self stopClockTimer];
    [self adjustClock];
    [self showResult:isSuccessful];
    if (isSuccessful) {
        [_levelManager unLockGameLevelAtIndex:_gameLevel.levelIndex + 1];
        [_levelManager storeLevelConfigure];
    }
    [self playBackGroundMusic:BGM_STOP];  
}

- (void)quitGame:(BOOL)backToLevelPick
{
    [self stopClockTimer];
    [self releaseAllFoodViews];
    [self resetAttributes];
    if (backToLevelPick) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    [self playBackGroundMusic:BGM_STOP];
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

//enum
//{
//  INDEX_BACK =0,
//  INDEX_REPLAY,
//  INDEX_INPUT_NAME
//};
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == INDEX_BACK) {
//        [self quitGame:YES];
//    }
//    if (buttonIndex == REPLAY_GAME) {
//        
//        if (_gameStatus == Sucess) {
//            //next level
//            self.gameLevel = [_levelManager nextGameLevelWithCurrentLevel:_gameLevel];
//            if (self.gameLevel) {
//                [self reFreshLevelLabel];
//            }else
//            {
//                [self quitGame:YES];
//            }
//        } 
//        UITextView* txtView = (UITextView*)[alertView viewWithTag:NAME_TEXT_VIEW_TAG];
//        if (txtView) {
//            HighScoreManager* manager = [HighScoreManager defaultManager];
//            NSString* name = [txtView text];
//            NSDate* today = [NSDate dateWithTimeIntervalSinceNow:0];
//            [manager addHighScore:_score forLevel:_gameLevel.levelIndex withName:name date:today];
//        }
//        _gameStatus = Ready;
//        [self processStateMachine];
//        
//    }
//    if (buttonIndex == INDEX_INPUT_NAME) {
//        UITextView* txtView = (UITextView*)[alertView viewWithTag:NAME_TEXT_VIEW_TAG];
//        if (txtView) {
//            HighScoreManager* manager = [HighScoreManager defaultManager];
//            NSString* name = [txtView text];
//            NSDate* today = [NSDate dateWithTimeIntervalSinceNow:0];
//            [manager addHighScore:_score forLevel:_gameLevel.levelIndex withName:name date:today];
//        }
//    }
//}

- (void)restartLevel
{
    _gameStatus = Ready;
    [self processStateMachine];
}

- (void)nextLevel
{
    self.gameLevel = [_levelManager nextGameLevelWithCurrentLevel:_gameLevel];
    if (self.gameLevel) {
        [self reFreshLevelLabel];
    } else {
        [self quitGame:YES];
    }
    _gameStatus = Ready;
    [self processStateMachine];
}

- (void)sumitHighScore:(NSString*)name
{
    HighScoreManager* manager = [HighScoreManager defaultManager];
    NSDate* today = [NSDate dateWithTimeIntervalSinceNow:0];
    [manager addHighScore:_score forLevel:_gameLevel.levelIndex withName:name date:today];
}


- (void)popHelpMessage
{
    HelpView* help = [[HelpView alloc] initWithFrame:CGRectMake(0, 0, 240, 160) withDelegate:self];
    [self.view addSubview:help];
    [help release];
}

- (void)popSettingView
{
    GameSettingView* view = [[GameSettingView alloc] initWithFrame:CGRectMake(0, 0, 240, 160) withDelegate:self];
    [self.view addSubview:view];
    [view release];
}

- (void)clickOkButton
{
    _gameStatus = Resume;
    [self processStateMachine];
}

- (void)settingFinish
{
    _gameStatus = Resume;
    [self processStateMachine];
}

#pragma mark - HGQuadCurveMenu

- (void)quadCurveMenu:(HGQuadCurveMenu *)menu didSelectIndex:(NSInteger)anIndex
{
    switch (anIndex) {
        case CONTINUE_GAME:
            _gameStatus = Resume;
            break;
        case REPLAY_GAME: {
            _missCount = 0;
            _gameStatus = Ready;
            break;
        }
        case QUIT_GAME: {
            _gameStatus = BackToMainMenu;
            break;
        }
        case GAME_SETTING: {
            [self popSettingView];
            break;
        }
        case GAME_HELP: {
            [self popHelpMessage];
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
    
    HGQuadCurveMenuItem *continueGame = [[HGQuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"continue.png"] 
                                                               highlightedImage:[UIImage imageNamed:@"continue_press.png"]
                                                                   contentImage:nil 
                                                        highlightedContentImage:nil 
                                                                          title:NSLocalizedString(@"继续", @"弹出圆菜单提示")];
    HGQuadCurveMenuItem *rePlayGame = [[HGQuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"replay.png"]  
                                                               highlightedImage:[UIImage imageNamed:@"replay_pressed.png"]  
                                                                   contentImage:nil 
                                                        highlightedContentImage:nil 
                                                                          title:NSLocalizedString(@"重玩", @"")];
    HGQuadCurveMenuItem *gameSetting = [[HGQuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"setting2.png"]  
                                                                highlightedImage:[UIImage imageNamed:@"setting2_pressed.png"]  
                                                                    contentImage:nil 
                                                         highlightedContentImage:nil 
                                                                           title:NSLocalizedString(@"设置", @"")];
    HGQuadCurveMenuItem *gameHelp = [[HGQuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"help.png"]  
                                                                highlightedImage:[UIImage imageNamed:@"help_pressed.png"]  
                                                                    contentImage:nil 
                                                         highlightedContentImage:nil 
                                                                           title:NSLocalizedString(@"帮助", @"弹出圆菜单提示")];
    HGQuadCurveMenuItem *quitGame = [[HGQuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"back.png"]  
                                                                   highlightedImage:[UIImage imageNamed:@"back_pressed.png"]  
                                                                       contentImage:nil 
                                                            highlightedContentImage:nil 
                                                                              title:NSLocalizedString(@"离开", @"弹出圆菜单提示")];
    
    NSArray *menus = [NSArray arrayWithObjects:continueGame, rePlayGame, gameSetting, gameHelp, quitGame, nil];
    [continueGame release];
    [rePlayGame release];
    [gameSetting release];
    [gameHelp release];
    [quitGame release];
    
    _menu = [[HGQuadCurveMenu alloc] 
                             initWithFrame:self.view.bounds
                             menus:menus 
                             nearRadius:210 
                             endRadius:220 
                             farRadius:230 
                             startPoint:CGPointMake(40, 430) 
                             timeOffset:0.036 
                             rotateAngle:0
                             menuWholeAngle:(M_PI/2)
                             buttonImage:[UIImage imageNamed:@"menu.png"] 
                             buttonHighLightImage:[UIImage imageNamed:@"menu_pressed.png"] 
                             contentImage:nil
                             contentHighLightImage:nil];
    _menu.delegate = self;
    [self.view addSubview:_menu];
    [_menu release];
}



- (void)addGestureTraceView
{
    CGRect rect = CGRectMake(0, 0, 320, 420);
    _gestureTrace = [[GestureTraceView alloc] initWithFrame:rect];
    _gestureTrace.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_gestureTrace];
    [_gestureTrace release];
}

- (void)enterBackground
{
    if (_menu) {
        [_menu expandItems];
        CALayer* layer = (CALayer*)_currentFood.layer.presentationLayer;
        _currentLocation = layer.position;
    }
}

- (void)enterForeground
{
    //_currentFood.frame = CGRectMake(-48, -48, 48, 48);
    //[self.view insertSubview:_currentFood atIndex:0];
    _currentFood.endPoint = CGPointMake(rand()%320, 400+24);
    CAAnimation *translation = [AnimationManager translationAnimationFrom:_currentLocation to:_currentFood.endPoint duration:[self calculateFallDuration] delegate:self removeCompeleted:NO];
    
    [translation setValue:_currentFood forKey:ANIMATION_ID_FOODVIEW];
    [translation setValue:ANIMATION_TAG_FALL forKey:ANIMATION_TAG_FALL];
    
    [_currentFood.layer addAnimation:translation forKey:ANIMATION_KEY_TRANSLATION];
    CAAnimation *rotation = [AnimationManager rotationAnimationWithRoundCount:FALL_ROTATION_COUNT duration:FALL_ANIMATION_DURATION];
    
    [_currentFood.layer addAnimation:rotation forKey:ANIMATION_KEY_ROTATION];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self addGestureTraceView];
    for (int type = LongPressGestureRecognizer; type < GestureRecognizerTypeCount; ++ type) {
        [self view:self.view addGestureRecognizer:type delegate:self];
    }
    [self addOptionButton];
    
    [self reFreshLevelLabel];
    _gameStatus = Ready;
    [self processStateMachine];
    [self.view addSubview:_progress];
}

- (void)viewDidUnload
{
    [self setScoreLabel:nil];
    [self setMissLabel:nil];
    [self setLevelLabel:nil];
    [self setPopupScoreView:nil];
    [self setPopupMissView:nil];
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
