//
//  HitGameAppDelegate.h
//  HitGame
//
//  Created by gamy on 11-12-31.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HitGameViewController;

@interface HitGameAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HitGameViewController *viewController;

@end
