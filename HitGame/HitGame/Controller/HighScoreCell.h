//
//  HighScoreCell.h
//  HitGame
//
//  Created by Orange on 12-2-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel* playerName;
@property (retain, nonatomic) IBOutlet UILabel* score;
@property (retain, nonatomic) IBOutlet UILabel* line;
+ (HighScoreCell *)createHighScoreCellByName:(NSString*)aName score:(int)aScore;
+ (NSString*)getCellIdentifier;
@end
