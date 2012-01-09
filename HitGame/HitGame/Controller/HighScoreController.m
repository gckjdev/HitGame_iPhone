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
@synthesize levelKeys = _levelKeys;

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
//    array = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//        NSNumber* num1 = (NSNumber*)obj1;
//        NSNumber* num2 = (NSNumber*)obj2;
//        
//        if (num1.intValue < num2.intValue) {
//            return NSOrderedAscending;
//        } else if (num1.intValue > num2.intValue) {
//            return NSOrderedDescending;
//        }
//        return NSOrderedSame;
//    }];
    array = [array sortedArrayUsingSelector:@selector(compare:)];
    self.levelKeys = array;

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
    NSNumber* level = [self.levelKeys objectAtIndex:indexPath.section];
    NSArray* scoreArray = [[HighScoreManager defaultManager] highScoresForLevel:level.intValue];
    NSNumber* score = [scoreArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%d",[score intValue]]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSNumber* levelIndex = [self.levelKeys objectAtIndex:section];
    NSArray* scoreArray = [self.dataList objectForKey:levelIndex];
    int count = [scoreArray count];
    return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.dataList allKeys] count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSNumber* level = [self.levelKeys objectAtIndex:section];
    NSString* title = [NSString stringWithFormat:@"第%d关", [level intValue]];
    return title;
}

- (IBAction)clickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickFilterButton:(id)sender
{
    
}

@end
