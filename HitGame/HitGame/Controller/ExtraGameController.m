//
//  ExtraGameController.m
//  HitGame
//
//  Created by Orange on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ExtraGameController.h"
#import "AnimationManager.h"
#import "GestureTraceView.h"
#import "Enum.h"

@implementation ExtraGameController
@synthesize currentImage = _currentImage;
@synthesize requestedImage = _requestedImage;

- (void)dealloc {
    [_currentImage release];
    [_requestedImage release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _gameEngine = [[HitGameEngine alloc] initWithActionTime:10];
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



- (void)viewDidUnload
{
    [self setCurrentImage:nil];
    [self setRequestedImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)moveLeft:(id)sender
{
    
    CABasicAnimation * animX = [CABasicAnimation 
                                animationWithKeyPath:@"transform.rotation.z"]; 
    animX.byValue = [NSNumber numberWithFloat:-M_PI/2];
    //[animX setFromValue:[NSNumber numberWithFloat:_gameEngine.currentAction.y * M_PI/2]];
    [animX setRemovedOnCompletion:NO];
    //[animX setAutoreverses:NO];
    [animX setFillMode:kCAFillModeForwards];
    self.currentImage.layer.transform = CATransform3DMakeRotation(_gameEngine.currentAction.y * M_PI/2, 0, 0, 1);
    
    CABasicAnimation * animY = [CABasicAnimation 
                                animationWithKeyPath:@"transform.rotation.y"]; 
    animY.toValue = [NSNumber numberWithFloat:_gameEngine.currentAction.y * M_PI];
    [animY setFillMode:kCAFillModeForwards];
    [animY setRemovedOnCompletion:NO];
    
    //[self.currentImage.layer removeAllAnimations];
    [self.currentImage.layer addAnimation:animX forKey:@"roateX"];
    //[self.currentImage.layer addAnimation:animY forKey:@"roateY"];
    
    [_gameEngine makeAction:(HGAction){0, -1}];
    NSLog(@"current action is (%d, %d)", _gameEngine.currentAction.x, _gameEngine.currentAction.y);
}

- (IBAction)moveRight:(id)sender
{
    
    CABasicAnimation * animX = [CABasicAnimation 
                                animationWithKeyPath:@"transform.rotation.z"]; 
    animX.byValue = [NSNumber numberWithFloat:M_PI/2];
    //[animX setFromValue:[NSNumber numberWithFloat:_gameEngine.currentAction.y * M_PI/2]];
    [animX setRemovedOnCompletion:NO];
    //[animX setAutoreverses:NO];
    [animX setFillMode:kCAFillModeForwards];
    self.currentImage.layer.transform = CATransform3DMakeRotation(_gameEngine.currentAction.y * M_PI/2, 0, 0, 1);
    CABasicAnimation * animY = [CABasicAnimation 
                                animationWithKeyPath:@"transform.rotation.y"]; 
    
    animY.byValue = [NSNumber numberWithFloat:_gameEngine.currentAction.y * M_PI];
    [animY setFillMode:kCAFillModeForwards];
    [animY setRemovedOnCompletion:NO];
    
    //[self.currentImage.layer removeAllAnimations];
    [self.currentImage.layer addAnimation:animX forKey:@"roateX"];
    //[self.currentImage.layer addAnimation:animY forKey:@"roateY"];
    
    [_gameEngine makeAction:(HGAction){0, 1}];
    NSLog(@"current action is (%d, %d)", _gameEngine.currentAction.x, _gameEngine.currentAction.y);
}
- (IBAction)moveUp:(id)sender
{
    

    CABasicAnimation * animX = [CABasicAnimation 
                                animationWithKeyPath:@"transform.rotation.x"]; 
    //animX.fromValue = [NSNumber numberWithFloat:_gameEngine.currentAction.x * M_PI];
    animX.byValue = [NSNumber numberWithFloat:M_PI];
    self.currentImage.layer.transform = CATransform3DMakeRotation(_gameEngine.currentAction.x * M_PI, 1, 0, 0);
    [animX setRemovedOnCompletion:NO];
    //[animX setAutoreverses:NO];
    [animX setFillMode:kCAFillModeForwards];
    CABasicAnimation * animY = [CABasicAnimation 
                                animationWithKeyPath:@"transform.rotation.z"]; 
    animY.fromValue = [NSNumber numberWithFloat:_gameEngine.currentAction.y * M_PI/2];
    [animY setFillMode:kCAFillModeForwards];
    [animY setRemovedOnCompletion:NO];
    
    //[self.currentImage.layer removeAllAnimations];
    [self.currentImage.layer addAnimation:animX forKey:@"roateX"];
    //[self.currentImage.layer addAnimation:animY forKey:@"roateY"];
    
   
    [_gameEngine makeAction:(HGAction){1, 0}];
     NSLog(@"current action is (%d, %d)", _gameEngine.currentAction.x, _gameEngine.currentAction.y);
}
- (IBAction)moveDown:(id)sender
{
    
    CABasicAnimation * animX = [CABasicAnimation 
                                animationWithKeyPath:@"transform.rotation.x"]; 
    //animX.fromValue = [NSNumber numberWithFloat:_gameEngine.currentAction.x * M_PI];
    animX.byValue = [NSNumber numberWithFloat:-M_PI];
    self.currentImage.layer.transform = CATransform3DMakeRotation(_gameEngine.currentAction.x * M_PI, 1, 0, 0);
    [animX setRemovedOnCompletion:NO];
    //[animX setAutoreverses:NO];
    [animX setFillMode:kCAFillModeForwards];
    CABasicAnimation * animY = [CABasicAnimation 
                                animationWithKeyPath:@"transform.rotation.z"]; 
    animY.fromValue = [NSNumber numberWithFloat:_gameEngine.currentAction.y * M_PI/2];
    [animY setFillMode:kCAFillModeForwards];
    [animY setRemovedOnCompletion:NO];
    
    //[self.currentImage.layer removeAllAnimations];
    [self.currentImage.layer addAnimation:animX forKey:@"roateX"];
    //[self.currentImage.layer addAnimation:animY forKey:@"roateY"];
    
    [_gameEngine makeAction:(HGAction){-1, 0}];
    NSLog(@"current action is (%d, %d)", _gameEngine.currentAction.x, _gameEngine.currentAction.y);
}

- (IBAction)tapA:(id)sender
{
    [_gameEngine sumitAction];
    CGPoint pointA = self.currentImage.center;
    CGPoint pointB = self.requestedImage.center;
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath:@"position"];
    [move setDuration:2];
    [move setFromValue:[NSValue valueWithCGPoint:pointA]];
    [move setToValue:[NSValue valueWithCGPoint:pointB]];
    [move setFillMode:kCAFillModeForwards];
    [move setRemovedOnCompletion:NO];    
    move.delegate = self;
    
}

- (void)goodAction
{
    NSLog(@"正确");
}

- (void)badAction
{
    NSLog(@"错误");
}

- (void)missAnAction
{
    NSLog(@"miss!");
}

- (void)showActionRequest:(HGAction)anAction reactionTime:(float)anReactionTime
{
//    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hamburger.png"]];
    
    CABasicAnimation * animX = [CABasicAnimation 
                               animationWithKeyPath:@"transform.rotation.x"]; 
    animX.toValue = [NSNumber numberWithFloat:anAction.x * M_PI];
    [animX setRemovedOnCompletion:NO];
    [animX setFillMode:kCAFillModeForwards];
    CABasicAnimation * animY = [CABasicAnimation 
                                animationWithKeyPath:@"transform.rotation.z"]; 
    animY.toValue = [NSNumber numberWithFloat:anAction.y * M_PI/2];
    [animY setFillMode:kCAFillModeForwards];
    [animY setRemovedOnCompletion:NO];

    [self.requestedImage.layer removeAllAnimations];
    [self.currentImage.layer removeAllAnimations];
    [self.requestedImage.layer addAnimation:animX forKey:@"roateX"];
    [self.requestedImage.layer addAnimation:animY forKey:@"roateY"];
    NSLog(@"action req %d, %d", anAction.x, anAction.y);
    
}

#pragma mark - game gesture process

- (void)performSwipeGesture:(UISwipeGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded){
        
    }
}
- (void)performRotationGesture:(UIRotationGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded){
        
    }
}

- (void)performLongPressGesture:(UILongPressGestureRecognizer *)recognizer
{    
    if(recognizer.state == UIGestureRecognizerStateEnded){
        
    }
}
- (void)performPinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded){
        
    }
}

- (void)performTapGesture:(UITapGestureRecognizer *)recognizer
{
//    if(recognizer.state == UIGestureRecognizerStateEnded){
//        FoodType foodType = [_foodManager foodTypeForGuesture:TapGameGesture];
//        FoodView *foodView = [self getFoodViewWithFoodType:foodType];
//        if (foodView == nil) {
//            [self dealWithWrongGesture];
//        }else{
//            [self addDefaultMissingAnimationTofoodView:foodView];
//        }
//    }
}


- (void)performPanGesture:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //[[AudioManager defaultManager] playSoundById:0];
        [_gestureTrace didStartGestrue:recognizer];
        [_gestureTrace didGestrue:recognizer MovedAtPoint:
         [recognizer locationInView:_gestureTrace]];
        
    }else if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        [_gestureTrace didGestrue:recognizer MovedAtPoint:
         [recognizer locationInView:_gestureTrace]];
        
    }else if(recognizer.state == UIGestureRecognizerStateEnded){
        [_gestureTrace didEndedGestrue:recognizer];
        //FoodType foodType = Illegal;
        CGPoint point = [recognizer translationInView:self.view];
        //左边
       // GameGestureType gameGestureType = IllegalGameGesture;
        if (point.x < 0) {
            //左扫
            if (ABS(point.x) >= ABS(point.y)) {
                //gameGestureType = LeftPanGameGesture;
                NSLog(@"left swap");
            }else if(point.y > 0){            //下扫
                //gameGestureType = DownPanGameGesture;  
                NSLog(@"down swap");
            }else{            //上扫
                //gameGestureType = UpPanGameGesture;
                NSLog(@"up swap");
            }
        }else{
            //右扫
            if (ABS(point.x) >= ABS(point.y)) {
                //gameGestureType = RightPanGameGesture;
                NSLog(@"right swap");
            }else if(point.y > 0){            //下扫
                //gameGestureType = DownPanGameGesture; 
                NSLog(@"down swap");
            }else{                              //上扫
                //gameGestureType = UpPanGameGesture;
                NSLog(@"up swap");
            }
        }
        //foodType = [_foodManager foodTypeForGuesture:gameGestureType];
        //FoodView *foodView = [self getFoodViewWithFoodType:foodType];
//        if (foodView == nil) {
//            [self dealWithWrongGesture];
//        }else{
//            [self addDefaultMissingAnimationTofoodView:foodView];
//        }
    }
}

- (void)view:(UIView *)view addGestureRecognizer:(NSInteger)type 
    delegate:(id<UIGestureRecognizerDelegate>)delegate
{
    UIGestureRecognizer *recognizer = nil;
    SEL action = nil;
    switch (type) {
        case LongPressGestureRecognizer:
            action = @selector(performLongPressGesture:);
            recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case PanGestureRecognizer:
            action = @selector(performPanGesture:);
            recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case PinchGestureRecognizer:
            action = @selector(performPinchGesture:);
            recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case RotationGestureRecognizer:
            action = @selector(performRotationGesture:);
            recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case SwipeGestureRecognizer:
            action = @selector(performSwipeGesture:);
            recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case TapGestureRecognizer:
            action = @selector(performTapGesture:);
            recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
            ((UITapGestureRecognizer *)recognizer).numberOfTapsRequired = 1;
            break;
        default:
            return;
    }
    recognizer.delegate = delegate;
    [view addGestureRecognizer:recognizer];
    [recognizer release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _gameEngine.delegate = self;
    [_gameEngine gameStart];
    [self.currentImage setImage:[UIImage imageNamed:@"hamburger.png"]];
    [self.requestedImage setImage:[UIImage imageNamed:@"hamburger.png"]];
    for (int type = LongPressGestureRecognizer; type < GestureRecognizerTypeCount; ++ type) {
        [self view:self.view addGestureRecognizer:type delegate:self];
    }
    // Do any additional setup after loading the view from its nib.
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
      if (touch.view == self.view) {
          return YES;
      }
    return NO;
}


@end
