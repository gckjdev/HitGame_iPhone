//
//  LevelPickerController.h
//  HitGame
//
//  Created by  on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface LevelPickerController : UIViewController
{
    NSMutableArray *_levelArray;
    NSMutableArray *_buttonArray;
}

@property(nonatomic, retain)NSMutableArray *levelArray;
@property (retain, nonatomic) IBOutlet UIButton *backButton;
@property (retain, nonatomic) IBOutlet UILabel *pickLevelTitle;
- (IBAction)clickBackButton:(id)sender;
@end
