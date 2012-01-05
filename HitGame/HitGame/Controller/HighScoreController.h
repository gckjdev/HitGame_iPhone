//
//  HighScoreController.h
//  HitGame
//
//  Created by Orange on 12-1-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreController : UIViewController {
    NSArray* _dataList;
}
@property (retain, nonatomic) IBOutlet UITableView *dataTableView;
@property (retain, nonatomic) NSArray* dataList;

@end
