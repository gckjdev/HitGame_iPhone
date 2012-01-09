//
//  HighScoreController.h
//  HitGame
//
//  Created by Orange on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
    NSDictionary* _dataList;
    UITableView* _dataTableView;
    NSArray* _shownLevels;
}
@property (retain, nonatomic) IBOutlet UITableView *dataTableView;
@property (retain, nonatomic) NSDictionary* dataList;
@property (copy, nonatomic) NSArray* shownLevels;
@property (copy, nonatomic) NSArray* allLevels;


@end
