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
@synthesize delegate = _delegate;
@synthesize helpTitle = _helpTitle;

+ (HelpView *)createHelpView
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HelpView" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).  
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <HelpView> but cannot find cell object from Nib");
        return nil;
    }
    HelpView* view =  (HelpView*)[topLevelObjects objectAtIndex:0];
    CAAnimation *runIn = [AnimationManager scaleAnimationWithFromScale:0.01 toScale:1 duration:0.3 delegate:self removeCompeleted:NO];
    //CAAnimation *rollAnimation = [AnimationManager rotationAnimationWithRoundCount:-3 duration:0.5];
    [view.layer addAnimation:runIn forKey:@"runIn"];
    [view.helpTitle setText:NSLocalizedString(@"Help", @"帮助")];
    //[view.contentView.layer addAnimation:rollAnimation forKey:@"rolling"];
    return view;
    
}

+ (HelpView *)createHelpViewWithDelegate:(id<HelpViewDelegate>)aDelegate
{
    HelpView* view = [HelpView createHelpView];
    view.delegate = aDelegate;
    return view;
    
}

- (IBAction)clickOk:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickOkButton)]) {
        [_delegate clickOkButton];
    }
    CAAnimation *runOut = [AnimationManager scaleAnimationWithFromScale:1 toScale:0.01 duration:0.3 delegate:self removeCompeleted:NO];
   // CAAnimation *rollAnimation = [AnimationManager rotationAnimationWithRoundCount:3 duration:0.5];
    [runOut setValue:@"runOut" forKey:@"AnimationKey"];
    [runOut setDelegate:self];
    [self.layer addAnimation:runOut forKey:@"runOut"];
    //[_contentView.layer addAnimation:rollAnimation forKey:@"rolling"];
    //[self removeFromSuperview];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString* value = [anim valueForKey:@"AnimationKey"];
    if ([value isEqualToString:@"runOut"]) {
        [self setHidden:YES];
        [self removeFromSuperview];
    }
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
