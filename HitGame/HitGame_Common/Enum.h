//
//  Enum.h
//  HitGameTest
//
//  Created by  on 11-12-31.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

typedef enum{
    Illegal = -1,
    Tap = 0,
    Left,
    Right,
    Up,
    Down
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


typedef enum{
    Ready = 0,
    OnGoing = 1,
    Pause = 2,
    Resume,
    Fail,
    Sucess,
    BackToLevelPicker,
    BackToMainMenu
}GameStatus;

typedef enum{
    Falling = 0,
    Killed,
    Dead
}FoodViewStatus;

enum OPTION_MENU_INDEX {
    CONTINUE_GAME = 0,
    REPLAY_GAME,
    GAME_SETTING,
    GAME_HELP,
    QUIT_GAME
};