//
//  Food.m
//  HitGameTest
//
//  Created by gamy on 11-12-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Food.h"


@implementation Food
@synthesize retainCount = _retainCount;
@synthesize type = _type;
@synthesize image = _image;



- (id)initWithType:(FoodType)type 
             image:(UIImage *)image 
       retainCount:(NSInteger)retainCount
{
    self = [super init];
    if (self) {
        self.type = type;
        self.image = image;
        self.retainCount = retainCount;
    }
    return self;

}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:_type forKey:@"foodType"];
    [aCoder encodeInteger:_retainCount forKey:@"retainCount"];
    [aCoder encodeObject:_image forKey:@"foodImage"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.type = [aDecoder decodeIntegerForKey:@"foodType"];
        self.image = [aDecoder decodeObjectForKey:@"foodImage"];
        self.retainCount = [aDecoder decodeIntegerForKey:@"retainCount"];
    }
    return self;
}

- (void)dealloc
{
    [_image release];
    [super dealloc];
}

@end
