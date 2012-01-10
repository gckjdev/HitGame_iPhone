//
//  GameLevel.h
//  HitGame
//
//  Created by  on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameLevel : NSObject
{
    
}


@property(nonatomic, retain)NSNumber *highestScore;
@property(nonatomic, retain)NSNumber *passScore;
@property(nonatomic, retain)NSArray *foodList;
@property(nonatomic, retain)NSNumber *speed;
@property(nonatomic, retain)NSNumber *status;
@property(nonatomic, assign)NSInteger levelIndex;

- (id)initWithFoodList:(NSArray *)foodList 
             passScore:(NSInteger)passScore 
          highestScore:(NSInteger)highestScore 
                 speed:(NSInteger)speed 
                status:(NSInteger)status;
- (id)initWithFoodList:(NSArray *)foodList 
             passScore:(NSInteger)passScore 
          highestScore:(NSInteger)highestScore 
                 speed:(NSInteger)speed 
                status:(NSInteger)status 
            levelIndex:(NSInteger)aLevelIndex;

@end
