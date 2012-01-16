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
const int HELP_IMAGE_OFFSET = 20120116;

@implementation HelpView
@synthesize okButton = _okButton;
@synthesize contentView = _contentView;
@synthesize helpImages = _helpImages;

- (void)clickOk:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickOkButton)]) {
        [_delegate clickOkButton];
    }
    CAAnimation *scaleAnimation = [AnimationManager scaleAnimationWithFromScale:1 toScale:0.1 duration:0.5 delegate:self removeCompeleted:NO];
    CAAnimation *rollAnimation = [AnimationManager rotationAnimationWithRoundCount:3 duration:0.5];
    [scaleAnimation setValue:@"minify" forKey:@"AnimationKey"];
    [scaleAnimation setDelegate:self];
    [_contentView.layer addAnimation:scaleAnimation forKey:@"minify"];
    [_contentView.layer addAnimation:rollAnimation forKey:@"rolling"];
}

- (void)nextImage
{
    int imageCount = [self.helpImages count];
    if (_imageTag == imageCount-1) {
        return;
    }
    for (int i=0; i<[self.helpImages count]; i++) {
        UIImageView* view = (UIImageView*)[self.contentView viewWithTag:HELP_IMAGE_OFFSET+i];
        if (view) {
            if (i == _imageTag+1) {
                [view setHidden:NO];
            } else {
                [view setHidden:YES];
            }
            
        }
    }
    _imageTag++;
}

- (void)previousImage
{
    if (_imageTag == 0) {
        return;
    }
    for (int i=0; i<[self.helpImages count]; i++) {
        UIImageView* view = (UIImageView*)[self.contentView viewWithTag:HELP_IMAGE_OFFSET+i];
        if (view) {
            if (i == _imageTag-1) {
                [view setHidden:NO];
            } else {
                [view setHidden:YES];
            }
            
        }
    }
    _imageTag--;
}

- (void)showFisrtImage
{
    for (int i=0; i<[self.helpImages count]; i++) {
        UIImageView* view = (UIImageView*)[self.contentView viewWithTag:HELP_IMAGE_OFFSET+i];
        if (view) {
            if (i == 0) {
                [view setHidden:NO];
            } else {
                [view setHidden:YES];
            }
            
        }
    }
    _imageTag = 0;
}

- (void)buttonInit
{
    _okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_okButton setFrame:CGRectMake(self.contentView.frame.size.width-buttonWidth, self.contentView.frame.size.height-buttonHeight, buttonWidth, buttonHeight)];
    [_okButton setTitle:@"OK" forState:UIControlStateNormal];
    [_okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_okButton addTarget:self action:@selector(clickOk:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_okButton];
    
    UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [leftBtn setFrame:CGRectMake((self.contentView.frame.size.width-buttonWidth)/2-20, self.contentView.frame.size.height-20, 20, 20)];
    [rightBtn setFrame:CGRectMake((self.contentView.frame.size.width-buttonWidth)/2+20, self.contentView.frame.size.height-20, 20, 20)];
    [leftBtn setTitle:@"<<" forState:UIControlStateNormal];
    [rightBtn setTitle:@">>" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(previousImage) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(nextImage) forControlEvents:UIControlEventTouchUpInside];
    
    [_contentView addSubview:leftBtn];
    [_contentView addSubview:rightBtn];
}




- (void)ImageInit
{
    UIImage* help1 = [UIImage imageNamed:@"helpImg1"];
    UIImage* help2 = [UIImage imageNamed:@"helpImg2"];
    int flag = 0;
    self.helpImages = [NSArray arrayWithObjects:help2, help1, nil];
    for (UIImage* image in self.helpImages) {
        UIImageView* view = [[UIImageView alloc] initWithImage:image];
        [view setCenter:self.center];
        [view setTag:(HELP_IMAGE_OFFSET+flag)];
        [self.contentView addSubview:view];
        [view setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        [view release];
        flag++;
    }
    [self showFisrtImage];
}

- (void)contentInit:(CGRect)frame
{
    _contentView = [[UIView alloc] initWithFrame:frame];
    [_contentView setBackgroundColor:[UIColor colorWithRed:(0x35)/255.0 
                                                     green:(0x42)/255.0 
                                                      blue:(0x53)/255.0 
                                                     alpha:0.33]];
    [_contentView setCenter:CGPointMake(160, 240)];
    [self addSubview:_contentView];
    CAAnimation *scaleAnimation = [AnimationManager scaleAnimationWithFromScale:0.1 toScale:1 duration:0.5 delegate:self removeCompeleted:NO];
    CAAnimation *rollAnimation = [AnimationManager rotationAnimationWithRoundCount:-3 duration:0.5];
    [_contentView.layer addAnimation:scaleAnimation forKey:@"enlarge"];
    [_contentView.layer addAnimation:rollAnimation forKey:@"rolling"];
    [_contentView release];
    
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString* value = [anim valueForKey:@"AnimationKey"];
    if ([value isEqualToString:@"minify"]) {
        [self setHidden:YES];
    }
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, 480)];
        [self setBackgroundColor:[UIColor clearColor]];
        [self contentInit:frame];
        [self ImageInit];
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
