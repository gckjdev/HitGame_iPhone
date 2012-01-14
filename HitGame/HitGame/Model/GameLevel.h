//
//  GameLevel.h
//  HitGame
//
//  Created by  on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameLevel : NSObject<NSCoding>
{
    NSInteger _highestScore;
    NSArray *_foodList;
    NSInteger _levelIndex;
    BOOL _locked;
    NSInteger _status; //unuse
}


@property(nonatomic, assign)NSInteger highestScore;
@property(nonatomic, retain)NSArray *foodList;
@property(nonatomic, readonly)NSInteger levelIndex;
@property(nonatomic, assign, getter = isLocked)BOOL locked;

@property(nonatomic, assign)NSInteger status; //unuse


- (id)initWithFoodList:(NSArray *)foodList 
          highestScore:(NSInteger)highestScore 
            levelIndex:(NSInteger)aLevelIndex 
                locked:(BOOL)locked
                status:(NSInteger)status; 

@end
