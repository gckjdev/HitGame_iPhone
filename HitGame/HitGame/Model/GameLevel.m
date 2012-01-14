//
//  GameLevel.m
//  HitGame
//
//  Created by  on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameLevel.h"

@implementation GameLevel
@synthesize highestScore = _highestScore;
@synthesize foodList = _foodList;
@synthesize status = _status;
@synthesize levelIndex = _levelIndex;
@synthesize locked = _locked;




- (id)initWithFoodList:(NSArray *)foodList 
          highestScore:(NSInteger)highestScore 
            levelIndex:(NSInteger)aLevelIndex 
                locked:(BOOL)locked
                status:(NSInteger)status
{
    self = [super init];
    if (self) {
        self.foodList = foodList;
        _highestScore = highestScore;
        _status = status;
        _levelIndex = aLevelIndex;
        _locked = locked;
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_foodList forKey:@"foodList"];
    [aCoder encodeInteger:_highestScore forKey:@"highestScore"];
    [aCoder encodeInteger:_status forKey:@"status"];
    [aCoder encodeInteger:_levelIndex forKey:@"levelIndex"];  
    [aCoder encodeBool:_locked forKey:@"locked"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.foodList = [aDecoder decodeObjectForKey:@"foodList"];
        _highestScore = [aDecoder decodeIntegerForKey:@"highestScore"];
        _levelIndex = [aDecoder decodeIntegerForKey:@"levelIndex"];
        _status = [aDecoder decodeIntegerForKey:@"status"];
        _locked = [aDecoder decodeBoolForKey:@"locked"];        
    }
    return self;
}

- (void)dealloc
{
    [_foodList release];
    [super dealloc];
}
@end
