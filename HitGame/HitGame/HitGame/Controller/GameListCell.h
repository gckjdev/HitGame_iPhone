//
//  GameListCell.h
//  HitGameTest
//
//  Created by  on 11-12-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGTableViewCell.h"

@class Game;

@protocol GameListCellDelegate <NSObject>

@required
- (void)didClickJoinGameButtonOfIndexPath:(NSIndexPath *)indexpath;

@end

@interface GameListCell : HGTableViewCell
{
    id<GameListCellDelegate> _gameListCellDelegate;
}

+ (GameListCell*)createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;

- (IBAction)clickJoinButton:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *creator;
@property (retain, nonatomic) IBOutlet UILabel *level;
@property (retain, nonatomic) IBOutlet UILabel *capacity;
@property (retain, nonatomic) IBOutlet UILabel *playerCount;
@property (retain, nonatomic) IBOutlet UILabel *status;
@property (retain, nonatomic) IBOutlet UIButton *joinButton;
@property (assign, nonatomic) id<GameListCellDelegate> gameListCellDelegate;

- (void)setCellInfo:(Game *)game;

@end
