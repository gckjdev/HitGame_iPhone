//
//  FoodListView.m
//  HitGameTest
//
//  Created by  on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FoodListView.h"
#import "Food.h"

@implementation FoodListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define FOOD_TAG_BASE 1000
#define FOOD_HEIGHT 48
#define FOOD_COUNT_PER_PAGE 5

- (id)initWithFrame:(CGRect)frame foodList:(NSArray *)foodList
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        CGFloat foodHeight = MIN((height * 0.8), (width / (FOOD_COUNT_PER_PAGE + 1)));
        CGFloat space = (width - FOOD_COUNT_PER_PAGE * foodHeight) / (FOOD_COUNT_PER_PAGE + 1);
        int i = 0;
        CGFloat y = (height - foodHeight) / 2;
        for (Food *food in foodList) {
            CGFloat x = space + (i ++) * (space + foodHeight); 
            UIImageView *foodView = [[UIImageView alloc] initWithImage:food.image];
            [foodView setFrame:CGRectMake(x, y, foodHeight, foodHeight)];
            [foodView setTag:FOOD_TAG_BASE + food.type];
            [self addSubview:foodView];
            [foodView release];
        }
        [self setBackgroundColor:[UIColor grayColor]];
    }
    return self;
}



@end
