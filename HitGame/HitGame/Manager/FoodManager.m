//
//  FoodManager.m
//  HitGameTest
//
//  Created by  on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FoodManager.h"
#import "HGResource.h"


FoodManager *foodManager = nil;

@implementation FoodManager


- (id)init
{
    self = [super init];
    if (self) {
        _foodGuestureDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (FoodManager *)defaultManager
{
    if (foodManager == nil) {
        foodManager = [[FoodManager alloc] init];
        [foodManager bindDefaultGuestureAndFood];
    }
    return foodManager;
}

- (void)dealloc
{
    [_foodGuestureDict release];
    [super dealloc];
}

+ (UIImage *)imageForType:(FoodType)type
{
    switch (type) {
        case Tap:
            return DURIAN_IMAGE;
        case Left:
            return GRAPES_IMAGE;
        case Right:
            return CHERRY_IMAGE;
        case Down:
            return KIWI_IMGE;
        case Up:
            return PEACH_IMAGE;
        default:
            return nil;
    }
}

- (void)bindGuesture:(GameGestureType)grType WithFoodType:(FoodType)fType
{
    NSNumber *key = [NSNumber numberWithInt:grType];
    NSNumber *value = [NSNumber numberWithInt:fType];
    [_foodGuestureDict setObject:value forKey:key];
}


- (GameGestureType)gestureTypeForFoodType:(FoodType)foodtype
{
    for (NSNumber *gestureType in [_foodGuestureDict allKeys]) {
        NSNumber *value = [_foodGuestureDict objectForKey:gestureType];
        if ([value integerValue] == foodtype) {
            return [gestureType integerValue];
        }
    }
    return IllegalGameGesture;
}

- (NSString *)gestureStringForGestureType:(GameGestureType)type
{
    switch (type) {
        case TapGameGesture:
            return @"点击";
        case LeftPanGameGesture:
            return @"左扫";
        case RightPanGameGesture:
            return @"右扫";
        case UpPanGameGesture:
            return @"上扫";
        case DownPanGameGesture:
            return @"下扫";
        default:
            return @"非法手势";
    }
}


- (NSString *)gestureStringForFoodType:(FoodType)type
{
    GameGestureType grType = [self gestureTypeForFoodType:type];
    return [self gestureStringForGestureType:grType];
}

- (void)bindDefaultGuestureAndFood
{
    [self bindGuesture:TapGameGesture WithFoodType:Tap];
    [self bindGuesture:LeftPanGameGesture WithFoodType:Left];
    [self bindGuesture:RightPanGameGesture WithFoodType:Right];
    [self bindGuesture:UpPanGameGesture WithFoodType:Up];
    [self bindGuesture:DownPanGameGesture WithFoodType:Down];
}

- (FoodType)foodTypeForGuesture:(GameGestureType)grType
{
    NSNumber *key = [NSNumber numberWithInt:grType];
    NSNumber *value = [_foodGuestureDict objectForKey:key];
    if (value) {
        return [value integerValue];
    }
    return Illegal;
}

- (void)removeAllBindings
{
    [_foodGuestureDict removeAllObjects];
}

//typedef enum{
//    Illegal = -1,
//    Egg = 0,
//    Tomato,
//    Icecream,
//    Sushi,
//    Potato
//}FoodType;
//
//
//typedef enum{
//    LongPressGestureRecognizer = 0,
//    PanGestureRecognizer,
//    PinchGestureRecognizer,
//    RotationGestureRecognizer,
//    SwipeGestureRecognizer,
//    TapGestureRecognizer,
//    GameGestureTypeCount
//}RecognizerType;

@end
