//
//  HitGameAppDelegate.m
//  HitGame
//
//  Created by gamy on 11-12-31.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HitGameAppDelegate.h"
#import "EntryController.h"
#import "AudioManager.h"
#import "PlayGameController.h"

@implementation HitGameAppDelegate
@synthesize playGameController = _playGameController;

@synthesize window=_window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{


    EntryController* entryController = [[EntryController alloc] init];
    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:entryController];
    entryController.navigationController.navigationBarHidden = YES;

    self.window.rootViewController = rootViewController;
    [entryController release];
    [rootViewController release];
    [self.window makeKeyAndVisible];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    if (_playGameController) {
        [_playGameController enterBackground];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if (_playGameController) {
        [_playGameController enterForeground];
    }
    
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_playGameController release];
    [super dealloc];
}

@end
