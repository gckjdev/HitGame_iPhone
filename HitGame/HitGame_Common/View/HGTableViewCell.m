//
//  HGTableViewCell.m
//  Dipan
//
//  Created by qqn_pipi on 11-6-29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HGTableViewCell.h"


@implementation HGTableViewCell

@synthesize indexPath;
@synthesize delegate;
@synthesize tableViewController;

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

- (void)dealloc
{
    [indexPath release];
    [tableViewController release];
    [super dealloc];
}

// the following code is just for copy

- (void)setCellStyle
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;		   
}

- (void)awakeFromNib{
    [self setCellStyle];
}

// just replace HGTableViewCell by the new Cell Class Name
+ (HGTableViewCell*)createCell:(id)delegate
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HGTableViewCell" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).  
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <HGTableViewCell> but cannot find cell object from Nib");
        return nil;
    }
    HGTableViewCell *cell = (HGTableViewCell*)[topLevelObjects objectAtIndex:0];
    cell.delegate = delegate;
    return cell;
}

+ (NSString*)getCellIdentifier
{
    return @"HGTableViewCell";
}

+ (CGFloat)getCellHeight
{
    return 44.0f;
}

@end
