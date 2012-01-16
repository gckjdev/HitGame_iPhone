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

@interface HelpView : UIView{
    UIButton* _okButton;    
    id<HelpViewDelegate> _delegate;
    NSArray*    _helpImages;
    int _imageTag;
}
@property (retain, nonatomic) UIButton* okButton;
@property (retain, nonatomic) UIView* contentView;
@property (retain, nonatomic) NSArray* helpImages;

- (id)initWithFrame:(CGRect)frame withDelegate:(id<HelpViewDelegate>)aDelegate;

@end
