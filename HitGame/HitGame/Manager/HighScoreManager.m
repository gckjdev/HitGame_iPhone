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

- (void)loadHighScore
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData* highScoreData = [userDefault objectForKey:HIGH_SCORE];
    
    if (highScoreData) {
        NSMutableDictionary* dict = [NSKeyedUnarchiver unarchiveObjectWithData:highScoreData];
        self.highScoreDict = dict;
    }
}


- (void)saveHighScore
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData* highScoreData = [NSKeyedArchiver archivedDataWithRootObject:self.highScoreDict];
    [userDefault setObject:highScoreData forKey:HIGH_SCORE];
    [self loadHighScore];
}

- (id)init
{
    self = [super init];
    [self loadHighScore];
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

- (void)addHighScore:(NSInteger)aHighScore forLevel:(NSInteger)aLevel
{
    NSNumber* level = [NSNumber numberWithInt:aLevel];
    NSNumber* score = [NSNumber numberWithInt:aHighScore];
    NSMutableArray* scoreArray = [NSMutableArray arrayWithArray:[self.highScoreDict objectForKey:level]];
    [scoreArray addObject:score];
    NSArray* array = [scoreArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSNumber* num1 = (NSNumber*)obj1;
        NSNumber* num2 = (NSNumber*)obj2;
        if (num1.intValue > num2.intValue) {
            return NSOrderedAscending;
        } else if (num1.intValue < num2.intValue){
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    if ([array count] > 10) {
        array = [array subarrayWithRange:(NSRange){0,10}];
    }
    [self.highScoreDict setObject:array forKey:level];
    [self saveHighScore];
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
