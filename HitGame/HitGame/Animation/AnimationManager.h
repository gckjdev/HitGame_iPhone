//
//  AnimationManager.h
//  HitGameTest
//
//  Created by  on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
@interface AnimationManager : NSObject
{
    NSMutableDictionary *_animationDict;
}

- (CAAnimation *)animationForKey:(NSString *)key;
- (void)setAnimation:(CAAnimation *)animation forKey:(NSString *)key;

//rotation
+ (CAAnimation *)rotationAnimationWithRoundCount:(CGFloat) count 
                                        duration:(CFTimeInterval)duration;

//opacity
+ (CAAnimation *)missingAnimationWithDuration:(CFTimeInterval)duration;

//scale
+ (CAAnimation *)scaleAnimationWithScale:(CGFloat)scale  
                                duration:(CFTimeInterval)duration 
                                delegate:(id)delegate 
                        removeCompeleted:(BOOL)removedOnCompletion;

//translation
+ (CAAnimation *)translationAnimationFrom:(CGPoint) start
                                       to:(CGPoint)end
                                 duration:(CFTimeInterval)duration;
+ (CAAnimation *)translationAnimationTo:(CGPoint)end
                               duration:(CFTimeInterval)duration;
+ (CAAnimation *)translationAnimationFrom:(CGPoint) start
                                       to:(CGPoint)end
                                 duration:(CFTimeInterval)duration 
                                 delegate:(id)delegate 
                         removeCompeleted:(BOOL)removedOnCompletion;
@end
