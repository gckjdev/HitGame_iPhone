//
//  Score.m
//  HitGame
//
//  Created by Orange on 12-1-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Score.h"

@implementation Score
@synthesize name = _name;
@synthesize date = _date;
@synthesize score = _score;

- (id)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (id)initWithName:(NSString*)aName date:(NSDate*)aDate Score:(double)aScore
{
    self = [self init];
    if (self) {
        self.name = aName;
        self.date = aDate;
        self.score = aScore;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.score = [aDecoder decodeDoubleForKey:@"score"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeDouble:self.score forKey:@"score"];
}

@end
