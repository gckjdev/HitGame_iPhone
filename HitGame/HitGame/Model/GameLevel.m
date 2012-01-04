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
@synthesize passScore = _passScore;
@synthesize foodList = _foodList;
@synthesize speed = _speed;
@synthesize status = _status;


- (id)initWithFoodList:(NSArray *)foodList 
             passScore:(NSInteger)passScore 
          highestScore:(NSInteger)highestScore 
                 speed:(NSInteger)speed 
                status:(NSInteger)status
{
    self = [super init];
    if (self) {
        self.foodList = foodList;
        _passScore = [NSNumber numberWithInt:passScore];
        _highestScore = [NSNumber numberWithInt:highestScore];
        _speed = [NSNumber numberWithInt:speed];
        _status = [NSNumber numberWithInt:status];
    }
    return self;
}

- (void)dealloc
{
    [_highestScore release];
    [_passScore release];
    [_foodList release];
    [_status release];
    [_speed release];
    [super dealloc];
}
@end
