//
//  HelpView.h
//  HitGame
//
//  Created by Orange on 12-1-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HelpViewDelegate <NSObject>
 @optional
- (void)clickOkButton;

@end

@interface HelpView : UIView {
    UIButton* _okButton;    
    id<HelpViewDelegate> _delegate;
}
@property (retain, nonatomic) UIButton* okButton;
- (id)initWithFrame:(CGRect)frame withDelegate:(id<HelpViewDelegate>)aDelegate;

@end
