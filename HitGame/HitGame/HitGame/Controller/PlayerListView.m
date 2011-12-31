//
//  PlayerListView.m
//  HitGameTest
//
//  Created by  on 11-12-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlayerListView.h"
#import "Player.h"

@implementation PlayerListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
#define PLAYER_HEIGHT 48
#define PLAYER_COUNT_PER_PAGE 5

- (id)initWithFrame:(CGRect)frame playerList:(NSArray *)playerList
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        CGFloat playerHeight = MIN((height * 0.8), (width / (PLAYER_COUNT_PER_PAGE + 1)));
        CGFloat space = (width - PLAYER_COUNT_PER_PAGE * playerHeight) / (PLAYER_COUNT_PER_PAGE + 1);
        int i = 0;
        CGFloat y = (height - playerHeight) / 2;
        for (Player *player in playerList) {
            CGFloat x = space + (i ++) * (space + playerHeight); 
            UIImageView *playerView = [[UIImageView alloc] initWithImage:player.avatar];
            [playerView setFrame:CGRectMake(x, y, playerHeight, playerHeight)];
            [self addSubview:playerView];
            [playerView release];
        }
        [self setBackgroundColor:[UIColor grayColor]];
    }
    return self;
}


@end
