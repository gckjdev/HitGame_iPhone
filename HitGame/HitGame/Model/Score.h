//
//  Score.h
//  HitGame
//
//  Created by Orange on 12-1-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject <NSCoding>{
    NSString* _name;
    NSDate* _date;
    long _scoreValue;
}
@property (retain, nonatomic) NSString* name;
@property (retain, nonatomic) NSDate*   date;
@property (assign, nonatomic) long scoreValue;
- (id)initWithName:(NSString*)aName date:(NSDate*)aDate Score:(double)aScore;

@end
