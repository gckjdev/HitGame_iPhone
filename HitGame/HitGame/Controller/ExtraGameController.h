//
//  ExtraGameController.h
//  HitGame
//
//  Created by Orange on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HitGameEngine.h"
@class GestureTraceView;

@interface ExtraGameController : UIViewController <HitGameEngineDelegate, UIGestureRecognizerDelegate>
{
    HitGameEngine* _gameEngine;
    GestureTraceView *_gestureTrace;
}
@property (retain, nonatomic) IBOutlet UIImageView *currentImage;
@property (retain, nonatomic) IBOutlet UIImageView *requestedImage;

@end
