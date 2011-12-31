//
//  FoodView.h
//  HitGameTest
//
//  Created by  on 11-12-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Food.h"

@interface FoodView : UIImageView
{
    Food *_food;
}


@property(nonatomic, retain, setter = privateSetFood:)Food *food;

- (void)setFood:(Food *)food;
- (id)initWithFood:(Food *)food;
- (id)initWithFood:(Food *)food frame:(CGRect)frame;
- (FoodType)foodType;
@end
