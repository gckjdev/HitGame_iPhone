//
//  FoodView.m
//  HitGameTest
//
//  Created by  on 11-12-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FoodView.h"


@implementation FoodView
@synthesize food = _food;

- (id)initWithFood:(Food *)food
{
    self = [super init];
    if (self) {
        self.food = food;
        self.image = food.image;
    }
    return self;
}

- (id)initWithFood:(Food *)food frame:(CGRect)frame
{
    self = [self initWithFood:food];
    self.frame = frame;
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    return [super initWithFrame:frame];
}

- (id)initWithImage:(UIImage *)image
{
    return [super initWithImage:image];
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    return [super initWithImage:image highlightedImage:highlightedImage];
}

- (void)setFood:(Food *)food
{
    [self privateSetFood:food];
    self.image = food.image;
}
- (FoodType)foodType
{
    if (_food) {
        return _food.type;
    }
    return Illegal;
}

- (void)dealloc
{
    [_food release];
    [super dealloc];
}

@end
