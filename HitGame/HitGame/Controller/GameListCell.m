//
//  GameListCell.m
//  HitGameTest
//
//  Created by  on 11-12-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "GameListCell.h"
#import "Game.h"
#import "Player.h"
#import "GameManager.h"

@implementation GameListCell
@synthesize creator;
@synthesize level;
@synthesize capacity;
@synthesize playerCount;
@synthesize status;
@synthesize joinButton;
@synthesize gameListCellDelegate = _gameListCellDelegate;

+ (GameListCell*)createCell:(id)delegate
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GameListCell" owner:self options:nil];
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <GameListCell> but cannot find cell object from Nib");
        return nil;
    }
    
    ((GameListCell*)[topLevelObjects objectAtIndex:0]).delegate = delegate;
    
    return (GameListCell*)[topLevelObjects objectAtIndex:0];
}

+ (NSString*)getCellIdentifier
{
    return @"GameListCell";
}

+ (CGFloat)getCellHeight
{
    return 80.0f;
}

- (IBAction)clickJoinButton:(id)sender {
    if (_gameListCellDelegate && [_gameListCellDelegate respondsToSelector:@selector(didClickJoinGameButtonOfIndexPath:)]) {
        [_gameListCellDelegate didClickJoinGameButtonOfIndexPath:indexPath];
    }
}

- (void)setCellInfo:(Game *)game
{
    if (game) {
        GameManager *gameManager = [GameManager defaultManager];
        NSString *creatorName = [NSString stringWithFormat:@"创建者: %@",
                                 [[game creator] name]];
        NSString *levelString = [NSString stringWithFormat:@"难度: %@",
                                 [gameManager levelStringForGame:game]];
        
        NSString *statusString = [NSString stringWithFormat:@"状态: %@",
                                  [gameManager statusStringForGame:game]];
        
        NSString *capacityString = [NSString stringWithFormat:@"可容纳: %d人",
                                    game.capacity];
        
        NSString *playerCountString = [NSString stringWithFormat:@"已加入: %d人", 
                                       [game.playerList count]];
        
        [creator setText:creatorName];
        [level setText:levelString];
        [status setText:statusString];
        [capacity setText:capacityString];
        [playerCount setText:playerCountString];
        if (game.status == GAME_STATUS_WAITTING) {
            [joinButton setHidden:NO];
        }else{
            [joinButton setHidden:YES];
        }
        
    }
}

- (void)dealloc {
    [creator release];
    [level release];
    [capacity release];
    [playerCount release];
    [status release];
    [joinButton release];

    [super dealloc];
}

@end
