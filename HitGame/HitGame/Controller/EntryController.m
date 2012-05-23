//
//  EntryController.m
//  HitGame
//
//  Created by  on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EntryController.h"
#import <QuartzCore/QuartzCore.h>
#import "PlayGameController.h"
#import "LevelPickerController.h"
#import "HighScoreController.h"
#import "GameSettingView.h"
#import "HelpView.h"
#import "GADBannerView.h"

@implementation EntryController
@synthesize startGame;
@synthesize resumeGame;
@synthesize gameSetting;
@synthesize highScore;
@synthesize bannerView = _bannerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

#define PUBLISHER_ID @"a14fbb6292926f8"
#pragma mark - View lifecycle

- (GADBannerView*)allocAdMobView:(UIViewController*)superViewController
{
    // Create a view of the standard size at the bottom of the screen.
    GADBannerView* view = [[[GADBannerView alloc]
                            initWithFrame:CGRectMake(0.0,
                                                     self.view.frame.size.height-GAD_SIZE_320x50.height,
                                                     GAD_SIZE_320x50.width,
                                                     GAD_SIZE_320x50.height)] autorelease];
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    view.adUnitID = PUBLISHER_ID;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    view.rootViewController = superViewController;
    [superViewController.view addSubview:view];
    [superViewController.view bringSubviewToFront:view];
    // Initiate a generic request to load it with an ad.
    [view loadRequest:[GADRequest request]];   
    
    return view;
}


- (void)viewDidAppear:(BOOL)animated
{
    if (self.bannerView == nil){
        self.bannerView = [self allocAdMobView:self];  
    }
    
    [super viewDidAppear:animated];
}

- (void)addAnimationToButton:(UIButton *)button
{
    CABasicAnimation *fallButtonAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [fallButtonAnimation setDuration:2];
    [fallButtonAnimation setFromValue:[NSValue valueWithCGPoint:CGPointMake(160, 
                                                                            -20-button.center.y)]];
    [fallButtonAnimation setToValue:[NSValue valueWithCGPoint:button.center]];
    [fallButtonAnimation setFillMode:kCAFillModeForwards];
    [fallButtonAnimation setRemovedOnCompletion:NO];    
    fallButtonAnimation.delegate = self;
    
    CABasicAnimation *stayButtonAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    [stayButtonAnimation setDuration:2];
    [stayButtonAnimation setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.4, 0, 0, 1)]];
    [stayButtonAnimation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.4, 0, 0, 1)]];
    
    CABasicAnimation *rotateButton = [CABasicAnimation animationWithKeyPath:@"transform"];
    [rotateButton setDuration:0.2];
    [rotateButton setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-0.1, 0, 0, 1)]];
    [rotateButton setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.1, 0, 0, 1)]];
    [rotateButton setAutoreverses:YES];
    [rotateButton setRepeatCount:1];
    [rotateButton setRemovedOnCompletion:YES]; 
    [rotateButton setBeginTime:CACurrentMediaTime() + 2];

    
    [button.layer removeAllAnimations];
    [button.layer addAnimation:rotateButton forKey:@"rotateButton"];
    [button.layer addAnimation:fallButtonAnimation forKey:@"fallButton"];
    [button.layer addAnimation:stayButtonAnimation forKey:@"stayButton"];
}


- (IBAction)enterGame:(id)sender {
    LevelPickerController *lpController = [[LevelPickerController alloc] init];
    [self.navigationController pushViewController:lpController animated:YES];
    [lpController release];
}

- (IBAction)enterGameSetting:(id)sender {
    GameSettingView* view = [GameSettingView createSettingView];
    [self.view addSubview:view];
}

- (IBAction)enterHighScore:(id)sender {
    HighScoreController *hsController = [[HighScoreController alloc] init];
    [self.navigationController pushViewController:hsController animated:YES];
    [hsController release];
    
}

- (IBAction)showHelp:(id)sender {
    HelpView* view = [HelpView createHelpView];
    [self.view addSubview:view];
}

- (void)showMenu
{
    [self addAnimationToButton:startGame];
    [self addAnimationToButton:resumeGame];
    [self addAnimationToButton:gameSetting];
    [self addAnimationToButton:highScore];

}
               
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showMenu];
    [self.startGame setTitle:NSLocalizedString(@"Start", @"开始游戏") forState:UIControlStateNormal];
    [self.resumeGame setTitle:NSLocalizedString(@"Help", @"帮助") forState:UIControlStateNormal];
    [self.gameSetting setTitle:NSLocalizedString(@"Settings", @"设置") forState:UIControlStateNormal];
    [self.highScore setTitle:NSLocalizedString(@"Highscores", "高分榜") forState:UIControlStateNormal];
    
}

- (void)viewDidUnload
{
    [self setStartGame:nil];
    [self setResumeGame:nil];
    [self setGameSetting:nil];
    [self setHighScore:nil];
    [self setBannerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [startGame release];
    [resumeGame release];
    [gameSetting release];
    [highScore release];
    [_bannerView release];
    [super dealloc];
}
@end
