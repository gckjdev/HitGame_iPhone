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
}
@property (assign, nonatomic) BOOL isVibration;
+ (GameSettingManager*)defaultManager;
+ (BOOL)isVibration;
@end
