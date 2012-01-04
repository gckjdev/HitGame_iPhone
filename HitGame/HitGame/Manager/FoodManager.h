//
//  FoodManager.h
//  HitGameTest
//
//  Created by  on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enum.h"

@interface FoodManager : NSObject
{
    NSMutableDictionary *_foodGuestureDict;
}

+ (UIImage *)imageForType:(FoodType)type;
+ (FoodManager *)defaultManager;

- (void)bindDefaultGuestureAndFood;
- (void)removeAllBindings;
- (void)bindGuesture:(GameGestureType)rType WithFoodType:(FoodType)fType;

- (FoodType)foodTypeForGuesture:(GameGestureType)grType;
- (GameGestureType)gestureTypeForFoodType:(FoodType)foodtype;
- (NSString *)gestureStringForGestureType:(GameGestureType)type;
- (NSString *)gestureStringForFoodType:(FoodType)type;
@end
