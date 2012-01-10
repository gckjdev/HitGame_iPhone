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
    [_okButton setFrame:CGRectMake(self.frame.size.width-buttonWidth, self.frame.size.height-buttonHeight, buttonWidth, buttonHeight)];
    [_okButton setTitle:@"OK" forState:UIControlStateNormal];
    [_okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_okButton addTarget:self action:@selector(clickOk:) forControlEvents:UIControlEventTouchUpInside];
    //[_okButton setBackgroundColor:[UIColor redColor]];
    [self addSubview:_okButton];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
