//
//  Food.h
//  HitGameTest
//
//  Created by gamy on 11-12-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enum.h"


//Eggs (click), tomatoes (double), ice cream (sweep), sushi (zoom), potatoes


@interface Food : NSObject<NSCoding> {
    FoodType _type;
    UIImage *_image;
    NSInteger _retainCount;
}

@property(nonatomic, retain) UIImage *image;
@property(nonatomic, assign) FoodType type;
@property(nonatomic, assign) NSInteger retainCount;

- (id)initWithType:(FoodType)type 
             image:(UIImage *)image 
       retainCount:(NSInteger)retainCount;

@end
