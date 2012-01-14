//
//  LevelPickerController.m
//  HitGame
//
//  Created by  on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LevelPickerController.h"
#import "HitGameAppDelegate.h"
#import "PlayGameController.h"
#import "GameLevel.h"
#import "LevelManager.h"
#import "HGResource.h"
#import "TestCase.h"
#import "Food.h"

#define COUNT_PER_ROW 5
#define BUTTON_LENGTH 40.0
#define BUTTON_TAG_BASE 100

@implementation LevelPickerController
@synthesize levelArray = _levelArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.levelArray = [[LevelManager defaultManager] levelArray];
        _buttonArray  = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_levelArray release];
    [_buttonArray release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)setCurrentPlayGameController:(PlayGameController *)pgController;
{
    [(HitGameAppDelegate *)[UIApplication sharedApplication].delegate setPlayGameController:pgController]; 
}

- (void)pickLevelButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag - BUTTON_TAG_BASE;
    GameLevel *level = [_levelArray objectAtIndex:tag];
    PlayGameController *pgController = [[PlayGameController alloc] initWithGameLevel:level];
    [self.navigationController pushViewController:pgController animated:YES];
    [self setCurrentPlayGameController:pgController];
    [pgController release];
    
}

- (void)createLevelPickerButton
{
    CGFloat xSpace = (320 - BUTTON_LENGTH * COUNT_PER_ROW) / (COUNT_PER_ROW + 1);
    CGFloat ySpace = xSpace * 0.8;

    CGFloat x = 0, y = 0;
    for (int i = 0; i < [_levelArray count]; ++ i) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        x = xSpace + (xSpace + BUTTON_LENGTH) * (i % COUNT_PER_ROW);
        y = ySpace + (ySpace + BUTTON_LENGTH) * (i / COUNT_PER_ROW);
        button.frame = CGRectMake(x, y, BUTTON_LENGTH, BUTTON_LENGTH);

        button.tag = i + BUTTON_TAG_BASE;
        [button addTarget:self action:@selector(pickLevelButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] 
                forState:UIControlStateNormal];
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [self.view addSubview:button];
        [_buttonArray addObject:button];
    }
}

#pragma mark - View lifecycle

- (void)updateButtons
{
    if ([_buttonArray count] == 0) {
        return;
    }
    int i =0;
    for (UIButton *button in _buttonArray) {
        GameLevel *level = [_levelArray objectAtIndex:i];
        if (level && ![level isLocked]) {
            [button setBackgroundImage:UNLOCKED_IMAGE forState:UIControlStateNormal];
            [button setUserInteractionEnabled:YES];
        }else
        {
            [button setBackgroundImage:LOCKED_IMAGE forState:UIControlStateNormal];
            [button setUserInteractionEnabled:NO];
        }
        ++ i;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateButtons];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createLevelPickerButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
