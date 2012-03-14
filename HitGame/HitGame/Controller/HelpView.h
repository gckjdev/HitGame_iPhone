//
//  HelpView.h
//  HitGame
//
//  Created by Orange on 12-1-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>


@protocol HelpViewDelegate <NSObject>
 @optional
- (void)clickOkButton;

@end

@interface HelpView : UIView <UIScrollViewDelegate> {
    UIButton* _okButton; 
    UIImageView* _contentView;
    id<HelpViewDelegate> _delegate;

}
@property (retain, nonatomic) IBOutlet UIButton* okButton;
@property (retain, nonatomic) IBOutlet UILabel* helpTitle;
@property (assign, nonatomic) id<HelpViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIScrollView* contentScrollView;
@property (retain, nonatomic) IBOutlet UIView* friuteHelp;
@property (retain, nonatomic) IBOutlet UIView* animalHelp;
@property (retain, nonatomic) IBOutlet UIView* foodHelp;
@property (retain, nonatomic) IBOutlet UIPageControl *helpPageControl;

+ (HelpView *)createHelpView;
+ (HelpView *)createHelpViewWithDelegate:(id<HelpViewDelegate>)aDelegate;
@end
