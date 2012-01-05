//
//  LayerUtil.h
//  HitGame
//
//  Created by  on 12-1-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LayerUtil : NSObject

+ (void) pauseLayer:(CALayer *)layer;
+ (void)resumeLayer:(CALayer*)layer;
@end
