//
//  HGTableViewController.h
//  HitGameTest
//
//  Created by  on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGTableViewController : UITableViewController
{
    NSArray *dataList;
    UITableView *dataTableView;
}


@property(nonatomic, retain) NSArray *dataList;
@property(nonatomic, retain) IBOutlet UITableView *dataTableView;

@end
