//
//  HelpView.m
//  HitGame
//
//  Created by Orange on 12-1-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HelpView.h"
#import <QuartzCore/QuartzCore.h>
#import "AnimationManager.h"
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
    //self.contentView.layer.transform = CATransform3DMakeTranslation(5, 5, 1);
    //self.contentView.layer.duration = 1;
    [self addSubview:_contentView];
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1)];
//    scaleAnimation.duration = 1;
//    scaleAnimation.fillMode = kCAFillModeForwards;
//    scaleAnimation.removedOnCompletion = NO;
    CAAnimation *scaleAnimation1 = [AnimationManager scaleAnimationWithScale:0.001 duration:0 delegate:self removeCompeleted:YES];
    scaleAnimation1.beginTime = 0;
    CAAnimation *scaleAnimation = [AnimationManager scaleAnimationWithScale:1 duration:1 delegate:self removeCompeleted:YES];
    scaleAnimation.beginTime = 0;
    [_contentView.layer addAnimation:scaleAnimation1 forKey:@"scale1"];
    //[_contentView.layer addAnimation:scaleAnimation forKey:@"scale"];
//    scaleAnimation.fillMode = kCAFillModeForwards;
//    scaleAnimation.removedOnCompletion = NO;
    //self.contentView.layer.duration = 1;
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
