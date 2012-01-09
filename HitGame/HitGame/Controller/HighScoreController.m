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
    NSNumber* section = [NSNumber numberWithInt:indexPath.section+1];
    NSArray* scoreArray = [self.dataList objectForKey:section];
    NSNumber* score = [scoreArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%d",[score intValue]]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSNumber* index = [NSNumber numberWithInt:section+1];
    NSArray* array = [self.dataList objectForKey:index];
    int count = [array count];
    return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.dataList allKeys] count];
}

- (IBAction)clickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSNumber* level = [[self.dataList allKeys] objectAtIndex:section];
    NSString* title = [NSString stringWithFormat:@"第%d关", [level intValue]];
    return title;
}


@end
