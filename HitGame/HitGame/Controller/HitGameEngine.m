//
//  HitGameEngine.m
//  HitGame
//
//  Created by Orange on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HitGameEngine.h"
#define GAME_TIMER_INTERVAL 60

@implementation HitGameEngine
@synthesize actionTime = _actionTime;
@synthesize gameTime = _gameTime;
@synthesize delegate = _delegate;
@synthesize currentAction = _currentAction;

- (HGAction)mergeAction:(HGAction)action1 and:(HGAction)action2
{
    action1.x = abs((action1.x+action2.x+2) % 2);
    action1.y = abs((action1.y+action2.y+4) % 4);
    return action1;
}

- (BOOL)isEqualAction:(HGAction)action1 and:(HGAction)action2
{
    if (action1.x != action2.x || action1.y != action2.y) {
        return NO;
    }
    return YES;
}

- (void)creatRequestAction
{
    int a = rand()-rand();
    int b = rand();
    HGAction action = {abs((a-abs(a))/(2*abs(a))),b%4};
    _requestAction = action;
    self.currentAction = (HGAction){0, 0};
    if (_delegate && [_delegate respondsToSelector:@selector(showActionRequest:reactionTime:)]) {
        [_delegate showActionRequest:action reactionTime:_originActionTime];
    }
    [_actionTimer invalidate];
    _actionTimer = nil;
    _actionTimer = [NSTimer scheduledTimerWithTimeInterval:_originActionTime 
                                                    target:self 
                                                  selector:@selector(missAnAction) 
                                                  userInfo:nil 
                                                   repeats:NO];
}

- (void)missAnAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(missAnAction)]) {
        [_delegate missAnAction];
    }
    _missCount++;
    [self creatRequestAction];
}

#pragma mark - game attributes setting
- (void)adjustClock
{
    //UIProgressView *progress = (UIProgressView *)[self.view viewWithTag:61];
    //UILabel *timeLabel = (UILabel *)[self.view viewWithTag:60];
    //[_progress setProgress:_retainSeconds / _roundTime];
    //[timeLabel setText:[NSString stringWithFormat:@"%.0f",ABS(_retainSeconds)]];
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
        [self gameEnd:YES];
    }
}

- (void)startTimer
{
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAME_TIMER_INTERVAL 
                                                  target:self 
                                                selector:@selector(timerClock) 
                                                userInfo:nil 
                                                 repeats:NO];
    _actionTimer = [NSTimer scheduledTimerWithTimeInterval:_originActionTime 
                                                    target:self 
                                                  selector:@selector(missAnAction) 
                                                  userInfo:nil 
                                                   repeats:NO];
}

- (void)gameStart
{
    [self creatRequestAction];
    [self startTimer];
    
}

- (void)gamePause
{
    if (_delegate && [_delegate respondsToSelector:@selector(pauseGame)]) {
        [_delegate pauseGame];
    }
}

- (void)gameEnd:(BOOL)isSuccessful
{
    if (isSuccessful) {
        if (_delegate && [_delegate respondsToSelector:@selector(accomplish)]) {
            [_delegate accomplish];
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(failed)]) {
            [_delegate failed];
        }
    }
}

- (void)makeAction:(HGAction)anAction
{
    _currentAction = [self mergeAction:_currentAction and:anAction];
    if (_delegate && [_delegate respondsToSelector:@selector(reactoin:)]) {
        [_delegate reactoin:anAction];
    }
}

- (void)sumitAction
{
    if ([self isEqualAction:_currentAction and:_requestAction]) {
        if (_delegate && [_delegate respondsToSelector:@selector(goodAction)]) {
            [_delegate goodAction];
            [self creatRequestAction];
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(badAction)]) {
            [_delegate badAction];
        }
    }
}

- (id)initWithActionTime:(float)actionTime
{
    self = [super init];
    if (self) {
        _originActionTime = actionTime;
    }
    return self;
}


@end
