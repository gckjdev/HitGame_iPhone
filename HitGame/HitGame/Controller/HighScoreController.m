//
//  HighScoreController.m
//  HitGame
//
//  Created by Orange on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HighScoreController.h"
#import "HighScoreManager.h"

@implementation HighScoreController
@synthesize dataTableView = _dataTableView;
@synthesize dataList = _dataList;
@synthesize shownLevels = _shownLevels;
@synthesize allLevels = _allLevels;

- (void)dealloc {
    [_dataTableView release];
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
    array = [array sortedArrayUsingSelector:@selector(compare:)];
    self.shownLevels = array;
    self.allLevels = array;

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HighScore"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HighScore"] autorelease];
        
    }
    NSNumber* level = [self.shownLevels objectAtIndex:indexPath.section];
    NSArray* scoreArray = [[HighScoreManager defaultManager] highScoresForLevel:level.intValue];
    NSNumber* score = [scoreArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%d00",[score intValue]]];
    return cell;
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
    NSString* title = [NSString stringWithFormat:@"第%d关", [level intValue]];
    return title;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    self.shownLevels = [self.allLevels subarrayWithRange:(NSRange){buttonIndex, 1}];
    [self.dataTableView reloadData];
}


- (IBAction)clickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickFilterButton:(id)sender
{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"选择关卡" 
                                                       delegate:self 
                                              cancelButtonTitle:nil 
                                         destructiveButtonTitle:nil 
                                              otherButtonTitles:nil];
    for (NSNumber* level in self.allLevels) {
        NSString* title = [NSString stringWithFormat:@"第%d关", level.intValue];
        [sheet addButtonWithTitle:title];
    }
    [sheet addButtonWithTitle:@"返回"];
    [sheet setCancelButtonIndex:[self.allLevels count]];
    [sheet showInView:self.view];
    [sheet release];
}

@end
