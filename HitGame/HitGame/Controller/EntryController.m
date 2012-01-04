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

@implementation EntryController
@synthesize startGame;
@synthesize resumeGame;
@synthesize gameSetting;

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

- (void)showMenu
{
    [self addAnimationToButton:startGame];
    [self addAnimationToButton:resumeGame];
    [self addAnimationToButton:gameSetting];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showMenu];
    
}

- (void)viewDidUnload
{
    [self setStartGame:nil];
    [self setResumeGame:nil];
    [self setGameSetting:nil];
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
    [super dealloc];
}
@end
