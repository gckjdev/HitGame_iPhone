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

@interface HelpView : UIView {
    UIButton* _okButton; 
    UIImageView* _contentView;
    id<HelpViewDelegate> _delegate;

}
@property (retain, nonatomic) IBOutlet UIButton* okButton;
@property (retain, nonatomic) IBOutlet UIImageView* contentView;
@property (retain, nonatomic) IBOutlet UILabel* helpTitle;
@property (assign, nonatomic) id<HelpViewDelegate> delegate;

+ (HelpView *)createHelpView;
+ (HelpView *)createHelpViewWithDelegate:(id<HelpViewDelegate>)aDelegate;
@end
