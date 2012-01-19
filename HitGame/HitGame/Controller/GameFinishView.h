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
- (void)back;
- (void)sumitHighScore:(NSString*)name;

@end

@interface GameFinishView : UIView {

}
@property (retain, nonatomic) IBOutlet UIView* contentView;
@property (retain, nonatomic) IBOutlet UILabel* titleLabel;
@property (retain, nonatomic) IBOutlet UILabel* messageLabel;
@property (retain, nonatomic) IBOutlet UITextField* nameField;
@property (retain, nonatomic) IBOutlet UIButton* leftButton;
@property (retain, nonatomic) IBOutlet UIButton* middleButton;
@property (retain, nonatomic) IBOutlet UIButton* rightButton;
@property (retain, nonatomic) id<GameFinishViewDelegate> delegate;

+ (GameFinishView *)creatGameFinishViewWithDelegate:(id<GameFinishViewDelegate>)aDelegate 
                                         shouldRank:(BOOL)shouldRank 
                                       isSuccessful:(BOOL)isSuccessful 
                                              score:(int)aScore;

@end
