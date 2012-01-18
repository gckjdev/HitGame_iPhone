//
//  GameSettingManager.h
//  HitGame
//
//  Created by Orange on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSettingManager : NSObject {
    BOOL _isVibration;
    BOOL _isSoundOn;
}
@property (assign, nonatomic) BOOL isVibration;
@property (assign, nonatomic) BOOL isSoundOn;
@property (assign, nonatomic) BOOL isBGMOn;
+ (GameSettingManager*)defaultManager;
+ (BOOL)isVibration;
+ (BOOL)isSoundOn;
+ (BOOL)isBGMOn;
@end
