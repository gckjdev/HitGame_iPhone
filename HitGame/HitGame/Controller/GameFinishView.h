//
//  GameFinishView.h
//  HitGame
//
//  Created by Orange on 12-1-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameFinishViewDelegate <NSObject>
 @optional
- (void)nextLevel;
- (void)restartLevel;
- (void)backToLevelSelection;
- (void)sumitHighScore:(NSString*)name;

@end

@interface GameFinishView : UIView <UIAlertViewDelegate,UITextFieldDelegate>{

}
@property (retain, nonatomic) IBOutlet UIView* contentView;
@property (retain, nonatomic) IBOutlet UILabel* titleLabel;
@property (retain, nonatomic) IBOutlet UILabel* messageLabel;
@property (retain, nonatomic) IBOutlet UIButton* nextLevelButton;
@property (retain, nonatomic) IBOutlet UIButton* replayButton;
@property (retain, nonatomic) IBOutlet UIButton* backButton;
@property (retain, nonatomic) IBOutlet UIView* inputNameView;
@property (retain, nonatomic) IBOutlet UILabel* inputNameTitle;
@property (retain, nonatomic) IBOutlet UILabel* inputNameMessage;
@property (retain, nonatomic) IBOutlet UITextField* nameField;
@property (retain, nonatomic) IBOutlet UIButton* clickButton;
@property (retain, nonatomic) IBOutlet UIButton* noInputNameButton;

@property (retain, nonatomic) id<GameFinishViewDelegate> delegate;

+ (GameFinishView *)creatGameFinishViewWithDelegate:(id<GameFinishViewDelegate>)aDelegate 
                                         shouldRank:(BOOL)shouldRank 
                                       isSuccessful:(BOOL)isSuccessful 
                                              score:(int)aScore;

@end
