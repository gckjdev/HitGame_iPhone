//
//  Enum.h
//  HitGameTest
//
//  Created by  on 11-12-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

typedef enum{
    Illegal = -1,
    Egg = 0,
    Tomato,
    Icecream,
    Sushi,
    Potato
}FoodType;


typedef enum{
    IllegalGestureRecognizer = -1,
    LongPressGestureRecognizer = 0,
    PanGestureRecognizer,
    PinchGestureRecognizer,
    RotationGestureRecognizer,
    SwipeGestureRecognizer,
    TapGestureRecognizer,
    GestureRecognizerTypeCount
}GestureRecognizerType;

typedef enum {
    IllegalGameGesture = -1,
    TapGameGesture = 100,
    LeftPanGameGesture,
    RightPanGameGesture,
    UpPanGameGesture,
    DownPanGameGesture,
    GameGestureTypeCount = 5
}GameGestureType;
