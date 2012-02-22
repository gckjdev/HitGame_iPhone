//
//  HighScoreCell.m
//  HitGame
//
//  Created by Orange on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HighScoreCell.h"

@implementation HighScoreCell
@synthesize playerName = _playerName;
@synthesize score = _score;
@synthesize line = _line;

+ (HighScoreCell *)createHighScoreCellByName:(NSString*)aName score:(int)aScore
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HighScoreCell" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).  
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <HighScoreCell> but cannot find cell object from Nib");
        return nil;
    }
    HighScoreCell* cell =  (HighScoreCell*)[topLevelObjects objectAtIndex:0];
    [cell.playerName setText:aName];
    [cell.score setText:[NSString stringWithFormat:@"%d", aScore]];
    //[view.contentView.layer addAnimation:rollAnimation forKey:@"rolling"];
    return cell;
    
}

+ (NSString*)getCellIdentifier
{
    return @"HighScoreCell";
}

+ (CGFloat)getCellHeight
{
    return 44;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
