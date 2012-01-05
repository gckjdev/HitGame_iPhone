//
//  HighScoreManager.m
//  HitGame
//
//  Created by Orange on 12-1-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define HIGH_SCORE @"highScore"

#import "HighScoreManager.h"
HighScoreManager *highScoreManager;

HighScoreManager* GlobalGetHighScoreManager()
{
    if (highScoreManager == nil) {
        highScoreManager = [[HighScoreManager alloc] init];
    }
    return highScoreManager;
}

@implementation HighScoreManager
@synthesize highScoreDict = _highScoreDict;

- (id)init
{
    self = [super init];
    if (_highScoreDict == nil) {
        _highScoreDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_highScoreDict release];
    [super dealloc];
}

+ (HighScoreManager*)defaultManager
{
    return GlobalGetHighScoreManager();
}

- (void)saveHighScore
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.highScoreDict forKey:HIGH_SCORE];
}

- (void)loadHighScore
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* dict = [userDefault objectForKey:HIGH_SCORE];
    if (dict) {
        self.highScoreDict = dict;
    }
}

- (void)addHighScore:(NSInteger)aHighScore forLevel:(NSInteger)aLevel
{
    NSNumber* level = [NSNumber numberWithInt:aLevel];
    NSNumber* score = [NSNumber numberWithInt:aHighScore];
    NSMutableArray* scoreArray = [self.highScoreDict objectForKey:level];
    if (scoreArray == nil) {
        scoreArray = [[NSMutableArray alloc] init ];
    }
    [scoreArray addObject:score];
    [scoreArray sortUsingSelector:@selector(compare:)];
    [self.highScoreDict setObject:score forKey:level];
    [self saveHighScore];
    [scoreArray release];
}

- (NSArray*)highScoresForLevel:(NSInteger)aLevel
{
    if (self.highScoreDict == nil || [self.highScoreDict count] == 0) {
        [self loadHighScore];
    }
    NSNumber* level = [NSNumber numberWithInt:aLevel];
    return [self.highScoreDict objectForKey:level];
}

@end
