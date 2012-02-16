//
//  EntryController.h
//  HitGame
//
//  Created by  on 12-1-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface EntryController : UIViewController 
@property (retain, nonatomic) IBOutlet UIButton *startGame;
@property (retain, nonatomic) IBOutlet UIButton *resumeGame;
@property (retain, nonatomic) IBOutlet UIButton *gameSetting;
@property (retain, nonatomic) IBOutlet UIButton *highScore;
- (IBAction)enterGame:(id)sender;


- (void)showMenu;
@end
