//
//  GameFinishView.m
//  HitGame
//
//  Created by Orange on 12-1-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameFinishView.h"

@implementation GameFinishView
@synthesize contentView = _contentView;
@synthesize leftButton = _leftButton;
@synthesize middleButton = _middleButton;
@synthesize rightButton = _rightButton;
@synthesize titleLabel = _titleLabel;
@synthesize messageLabel = _messageLabel;
@synthesize nameField = _nameField;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (GameFinishView *)creatGameFinishViewWithDelegate:(id<GameFinishViewDelegate>)aDelegate 
                                         shouldRank:(BOOL)shouldRank 
                                       isSuccessful:(BOOL)isSuccessful 
                                             score:(int)aScore
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GameFinishView" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).  
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <GameFinishView> but cannot find cell object from Nib");
        return nil;
    }
    GameFinishView* view =  (GameFinishView*)[topLevelObjects objectAtIndex:0];
    view.delegate = aDelegate;  
    [view.leftButton addTarget:view action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [view.rightButton addTarget:view action:@selector(nextLevel) forControlEvents:UIControlEventTouchUpInside];
    
    if (isSuccessful) {
        if (shouldRank) {
            [view.middleButton addTarget:view action:@selector(sumit:) forControlEvents:UIControlEventTouchUpInside];
            [view.messageLabel setText:NSLocalizedString(@"请输入你的大名", @"高分榜名字")];
            [view.titleLabel setText:NSLocalizedString(@"恭喜刷新纪录", @"刷新高分榜")];
            //
        } else {
            [view.titleLabel setText:NSLocalizedString(@"恭喜过关", @"过关提示")];
            [view.messageLabel setText:NSLocalizedString(@"很遗憾未能刷新纪录", @"过关提示")];
            [view.middleButton setTitle:NSLocalizedString(@"重玩", @"重玩") forState:UIControlStateNormal];
            [view.nameField setHidden:YES];
            [view.middleButton addTarget:view action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
            //
        }
        //
    } else {
        [view.titleLabel setText:NSLocalizedString(@"OH~NO~囧rz", @"过关失败标题")];
        [view.messageLabel setText:NSLocalizedString(@"一回生，两回熟，下次一定能过", @"过关失败")];
        [view.middleButton setTitle:NSLocalizedString(@"重玩", @"") forState:UIControlStateNormal];
        [view.nameField setHidden:YES];
        [view.middleButton addTarget:view action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
        [view.middleButton setFrame:view.rightButton.frame];
        [view.rightButton setHidden:YES];
        //
    }
    return view;
    
}

- (void)restart
{
    if (_delegate && [_delegate respondsToSelector:@selector(restartLevel)]) {
        [_delegate restartLevel];
    }
    [self removeFromSuperview];
}

- (void)clickBack
{
    [self removeFromSuperview];
}

- (void)sumit:(id)sender
{
    NSString* name = _nameField.text;
    if (_delegate && [_delegate respondsToSelector:@selector(sumitHighScore:)]) {
        [_delegate sumitHighScore:name];
    }
    UIButton* btn = (UIButton*)sender;
    [btn setHidden:YES];
    
}

- (void)nextLevel
{
    if (_delegate && [_delegate respondsToSelector:@selector(nextLevel)]) {
        [_delegate nextLevel];
    }
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
