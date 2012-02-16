//
//  GameFinishView.m
//  HitGame
//
//  Created by Orange on 12-1-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameFinishView.h"
#define LOC(x) NSLocalizedString(x, @"")
@implementation GameFinishView
@synthesize contentView;
@synthesize titleLabel;
@synthesize messageLabel;
@synthesize nextLevelButton;
@synthesize replayButton;
@synthesize backButton;
@synthesize inputNameView;
@synthesize inputNameTitle;
@synthesize inputNameMessage;
@synthesize nameField = _nameField;
@synthesize clickButton;
@synthesize noInputNameButton;
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
    
    if (isSuccessful) {
        if (shouldRank) {
            [view.inputNameView setHidden:NO];
            [view.inputNameView setCenter:view.contentView.center];
            //[view.middleButton addTarget:view action:@selector(sumit:) forControlEvents:UIControlEventTouchUpInside];
            [view.inputNameMessage setText:LOC(@"请输入你的大名")];
            [view.inputNameTitle setText:LOC(@"恭喜刷新纪录")];
            [view.titleLabel setText:LOC(@"恭喜过关")];
            [view.messageLabel setText:nil];
            //
        } else {
            [view.inputNameView setHidden:YES];
            [view.titleLabel setText:LOC(@"恭喜过关")];
            [view.messageLabel setText:LOC(@"很遗憾未能刷新纪录")];
            //[view.middleButton setTitle:NSLocalizedString(@"重玩", @"重玩") forState:UIControlStateNormal];
            [view.nameField setHidden:YES];
            //[view.middleButton addTarget:view action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
            //
        }
        //
    } else {
        [view.inputNameView setHidden:YES];
        [view.titleLabel setText:LOC(@"OH~NO~囧rz")];
        [view.messageLabel setText:LOC(@"一回生，两回熟，下次一定能过")];
        //[view.middleButton setTitle:NSLocalizedString(@"重玩", @"") forState:UIControlStateNormal];
        [view.nameField setHidden:YES];
        //[view.middleButton addTarget:view action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
        [view.replayButton setCenter:view.nextLevelButton.center];
        [view.nextLevelButton setHidden:YES];
        //
    }
    return view;
    
}

- (IBAction)restart:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(restartLevel)]) {
        [_delegate restartLevel];
    }
    [self removeFromSuperview];
}

- (IBAction)clickBack:(id)sender
{
    [self removeFromSuperview];
    if (_delegate && [_delegate respondsToSelector:@selector(backToLevelSelection)]) {
        [_delegate backToLevelSelection];
    }
}

- (IBAction)nextLevel:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(nextLevel)]) {
        [_delegate nextLevel];
    }
    [self removeFromSuperview];
}

- (IBAction)sumit:(id)sender
{
    NSString* name = _nameField.text;
    if (_delegate && [_delegate respondsToSelector:@selector(sumitHighScore:)]) {
        [_delegate sumitHighScore:name];
//        UIAlertView* view = [[[UIAlertView alloc] initWithTitle:LOC(@"提交成功", @"") message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil] autorelease];
//        [view show];
    }
    [self.inputNameView setHidden:YES];
    
}

- (IBAction)noSumit:(id)sender
{
    [self.inputNameView setHidden:YES];
    
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
