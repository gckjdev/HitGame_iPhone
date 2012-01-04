//
//  TestCase.h
//  HitGameTest
//
//  Created by  on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestCase : NSObject

+ (void) createGameList:(NSInteger) count;
+ (NSArray *) createPlayerList:(NSInteger) count;
+ (NSArray *) createFoodList:(NSInteger) count;
@end


