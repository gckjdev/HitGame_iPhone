//
//  HighScoreManager.h
//  HitGame
//
//  Created by Orange on 12-1-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScoreManager : NSObject {
 @private
    NSMutableDictionary *_highScoreDict;
}
@property (nonatomic, retain) NSMutableDictionary *highScoreDict;

+ (HighScoreManager*)defaultManager;
- (void)addHighScore:(NSInteger)aHighScore forLevel:(NSInteger)aLevel;
- (NSArray*)highScoresForLevel:(NSInteger)aLevel;

@end
