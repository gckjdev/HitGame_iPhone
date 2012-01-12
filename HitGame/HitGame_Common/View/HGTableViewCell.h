//
//  HGTableViewCell.h
//  HitGameTest
//
//  Created by  on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGTableViewCell : UITableViewCell {
    NSIndexPath *indexPath;    
    id delegate;
    UITableViewController *tableViewController;
    
}

// copy and override three methods below
+ (HGTableViewCell*)createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;

- (void)setCellStyle;
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain) UITableViewController *tableViewController;

@end
