//
//  GameSettingController.m
//  HitGame
//
//  Created by Orange on 12-1-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameSettingController.h"
#import "GameSettingManager.h"

@implementation GameSettingController
@synthesize vibrationSwitcher;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)vibrationSwitcherInit
{
    
    [self.vibrationSwitcher setOn:[GameSettingManager isVibration]];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self vibrationSwitcherInit];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setVibrationSwitcher:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)switchIsVibration:(id)sender
{
    UISwitch* sw = (UISwitch*)sender;
    GameSettingManager* manager = [GameSettingManager defaultManager];
    [manager setIsVibration:[sw isOn]];
}


- (void)dealloc {
    [vibrationSwitcher release];
    [super dealloc];
}
@end
