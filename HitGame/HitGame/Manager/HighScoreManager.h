//
//  HighScoreManager.h
//  HitGame
//
//  Created by Orange on 12-1-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScoreManager : NSObject {
    NSMutableDictionary *_highScoreDict;
}
@property (nonatomic, retain) NSMutableDictionary *highScoreDict;
@property (nonatomic, retain) NSString* defaultName;
+ (HighScoreManager*)defaultManager;
- (void)addHighScore:(NSInteger)aHighScore forLevel:(NSInteger)aLevel;
- (NSArray*)highScoresForLevel:(NSInteger)aLevel;
- (BOOL)shouldScore:(NSInteger)aScore RankInLevel:(NSInteger)aLevel;
- (void)addHighScore:(NSInteger)aHighScore forLevel:(NSInteger)aLevel withName:(NSString*)aName date:(NSDate*)aDate;
- (NSString*)loadDefaultName;
@end
