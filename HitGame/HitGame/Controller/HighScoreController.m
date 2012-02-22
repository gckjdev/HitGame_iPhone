//
//  HighScoreController.m
//  HitGame
//
//  Created by Orange on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HighScoreController.h"
#import "HighScoreManager.h"
#import "Score.h"
#import "TimeUtils.h"
#import "HighScoreCell.h"

@implementation HighScoreController
@synthesize dataTableView = _dataTableView;
@synthesize dataList = _dataList;
@synthesize shownLevels = _shownLevels;
@synthesize allLevels = _allLevels;
@synthesize highScoreTitle = _highScoreTitle;

- (void)dealloc {
    [_dataTableView release];
    [_dataList release];
    [_shownLevels release];
    [_allLevels release];
    [_highScoreTitle release];
    [super dealloc];
}

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

- (void)updateHighScore
{
    HighScoreManager* manager = [HighScoreManager defaultManager];
    self.dataList = manager.highScoreDict;
    NSArray* array = [self.dataList allKeys];
    NSArray* sortArray = [array sortedArrayUsingSelector:@selector(compare:)];
    self.shownLevels = sortArray;
    self.allLevels = sortArray;

}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    //[super viewDidAppear:animated];
    [self updateHighScore];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.highScoreTitle setText:NSLocalizedString(@"Highscores", @"高分榜")];
    [self updateHighScore];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setDataTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber* level = [self.shownLevels objectAtIndex:indexPath.section];
    NSArray* scoreArray = [[HighScoreManager defaultManager] highScoresForLevel:level.intValue];
    Score* score = [scoreArray objectAtIndex:indexPath.row];
    HighScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:[HighScoreCell getCellIdentifier]];
    if (cell == nil) {
        cell = [HighScoreCell createHighScoreCellByName:score.name score:score.scoreValue];
        
    }
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    NSNumber* level = [self.shownLevels objectAtIndex:section];
    [label setBackgroundColor:[UIColor clearColor]];
    NSString* title = [NSString stringWithFormat:NSLocalizedString(@"Level: %d", @"第几关"), [level intValue]];
    [label setText:title]; 
    [label setFont:[UIFont boldSystemFontOfSize:16]];
    [label setTextColor:[UIColor colorWithRed:0xff/255.0 green:0xe0/255.0 blue:0x9d/255.0 alpha:1.0]];
    [label setShadowColor:[UIColor colorWithRed:0x81/255.0 green:0x58/255.0 blue:0x30/255.0 alpha:1.0]];
    return label;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSNumber* levelIndex = [self.shownLevels objectAtIndex:section];
    NSArray* scoreArray = [self.dataList objectForKey:levelIndex];
    int count = [scoreArray count];
    return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.shownLevels count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSNumber* level = [self.shownLevels objectAtIndex:section];
    NSString* title = [NSString stringWithFormat:NSLocalizedString(@"Level: %d", @"第几关"), [level intValue]];
    return title;
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    self.shownLevels = [self.allLevels subarrayWithRange:NSMakeRange(buttonIndex, 1)];
    [self.dataTableView reloadData];
}


- (IBAction)clickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickFilterButton:(id)sender
{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Level Selection", @"关卡选择") 
                                                       delegate:self 
                                              cancelButtonTitle:nil 
                                         destructiveButtonTitle:nil 
                                              otherButtonTitles:nil];
    for (NSNumber* level in self.allLevels) {
        NSString* title = [NSString stringWithFormat:NSLocalizedString(@"Level: %d", @"第几关"), [level intValue]];
        [sheet addButtonWithTitle:title];
    }
    [sheet addButtonWithTitle:NSLocalizedString(@"Back", @"返回")];
    [sheet setCancelButtonIndex:[self.allLevels count]];
    [sheet showInView:self.view];
    [sheet release];
}

@end
