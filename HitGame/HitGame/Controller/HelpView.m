//
//  HelpView.m
//  HitGame
//
//  Created by Orange on 12-1-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HelpView.h"

const float buttonWidth = 40.0f;
const float buttonHeight = 20.0f;

@implementation HelpView
@synthesize okButton = _okButton;
@synthesize contentView = _contentView;

- (void)clickOk:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickOkButton)]) {
        [_delegate clickOkButton];
    }
    [self setHidden:YES];
}

- (void)buttonInit
{
    _okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_okButton setFrame:CGRectMake(self.contentView.frame.size.width-buttonWidth, self.contentView.frame.size.height-buttonHeight, buttonWidth, buttonHeight)];
    [_okButton setTitle:@"OK" forState:UIControlStateNormal];
    [_okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_okButton addTarget:self action:@selector(clickOk:) forControlEvents:UIControlEventTouchUpInside];
    //[_okButton setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:_okButton];
}

- (void)contentInit:(CGRect)frame
{
    _contentView = [[UIView alloc] initWithFrame:frame];
    [_contentView setBackgroundColor:[UIColor grayColor]];
    [_contentView setCenter:CGPointMake(160, 240)];
    [self addSubview:_contentView];
    [_contentView release];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, 480)];
        [self setBackgroundColor:[UIColor clearColor]];
        [self contentInit:frame];
        [self buttonInit];
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withDelegate:(id<HelpViewDelegate>)aDelegate
{
    self = [self initWithFrame:frame];
    if (self) {
        _delegate = aDelegate;
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
   // [_okButton release];
    [super dealloc];
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
