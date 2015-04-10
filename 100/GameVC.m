//
//  GameVC.m
//  100
//
//  Created by apple on 24/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import "GameVC.h"
@implementation GameVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=kBGColor;
	
       

    _gameOverCount=0;
    _maxGameCount=0;
    _boardOverlay=[[BoardOverlay alloc]initWithFrame:CGRectMake(5.0, 100.0, self.view.frame.size.width-10.0, self.view.frame.size.width-10.0)];
    _boardOverlay.backgroundColor=[UIColor colorWithRed:223/255.0 green:213/255.0 blue:213/255.0 alpha:1];
    [self.view addSubview:_boardOverlay];
    [_boardOverlay resetTiles];
    
    UISwipeGestureRecognizer *_swipeLeftGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft:)];
    _swipeLeftGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [_boardOverlay addGestureRecognizer:_swipeLeftGesture];
    [_swipeLeftGesture release];
    
    UISwipeGestureRecognizer *_swipeRightGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
    _swipeRightGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [_boardOverlay addGestureRecognizer:_swipeRightGesture];
    [_swipeRightGesture release];
    
    UISwipeGestureRecognizer *_swipeTopGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeTop:)];
    _swipeTopGesture.direction=UISwipeGestureRecognizerDirectionUp;
    [_boardOverlay addGestureRecognizer:_swipeTopGesture];
    [_swipeTopGesture release];
    
    UISwipeGestureRecognizer *_swipeDownGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown:)];
    _swipeDownGesture.direction=UISwipeGestureRecognizerDirectionDown;
    [_boardOverlay addGestureRecognizer:_swipeDownGesture];
    [_swipeDownGesture release];
    
    CGFloat yOffset=0.0;
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        yOffset=0.0;
    
    UILabel *_label=[[UILabel alloc]initWithFrame:CGRectMake(5.0, 5.0+yOffset, 120.0, 20.0)];
    _label.backgroundColor=[UIColor clearColor];
    _label.textColor=[UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    _label.font=[UIFont fontWithName:@"Kreon-Bold" size:14.0];
    _label.text=@"BEST";
    [self.view addSubview:_label];
    [_label release];
    
    _scoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(48.0, 3.0+yOffset, 120.0, 60.0)];
    _scoreLabel.backgroundColor=[UIColor clearColor];
    _scoreLabel.textColor=[UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    _scoreLabel.font=[UIFont fontWithName:@"Kreon-Bold" size:20.0];
    _scoreLabel.text=@"0";
    [self.view addSubview:_scoreLabel];
    
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(5.0, 5.0+yOffset, 120.0, 60.0)];
    _label.backgroundColor=[UIColor clearColor];
    _label.textColor=[UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    _label.font=[UIFont fontWithName:@"Kreon-Bold" size:14.0];
    _label.text=@"SCORE";
    [self.view addSubview:_label];
    [_label release];
    
    _bestLabel=[[UILabel alloc]initWithFrame:CGRectMake(48.0, 5.0+yOffset, 120.0, 20.0)];
    _bestLabel.backgroundColor=[UIColor clearColor];
    _bestLabel.textColor=[UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    _bestLabel.font=[UIFont fontWithName:@"Kreon-Bold" size:20.0];
    _bestLabel.text=@"0";
    [self.view addSubview:_bestLabel];
    
    
    
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(192.0, yOffset+5, 120.0, 20.0)];
    _label.backgroundColor=[UIColor clearColor];
    _label.textColor=[UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
    _label.font=[UIFont fontWithName:@"Kreon-Bold" size:14.0];
    _label.text=@"NEXT TILE";
    [self.view addSubview:_label];
    [_label release];
    
    
    _numberTile=[[TileView alloc]initWithFrame:CGRectMake(200.0, yOffset+28, 50.16,50.16) style:TSBlank];
    [self.view addSubview:_numberTile];
    [self  updateNumberLabel];
    
    UIButton *_menuBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _menuBtn.frame=CGRectMake(self.view.frame.size.width-30,  5.0+yOffset, 20.0, 20.0);
    [_menuBtn setImage:[UIImage imageNamed:@"burger.png"] forState:UIControlStateNormal];
    [_menuBtn addTarget:self action:@selector(menuBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_menuBtn];
    
    
    _score=0;
    
    _menuView=[[MenuView alloc]initWithView:self.view];
    [self.view addSubview:_menuView];
    _menuView.menuOption=^(MenuOption option){
        
        if (option==MOExit)
            [self.navigationController popViewControllerAnimated:YES];
        else if (option==MONewGame){
            
            [self getBestScore];
            [_menuView hideMenuView];
            [self updateNumberLabel];
            [self startTimer];
            [_boardOverlay resetTiles];
        }
        else if (option==MOResume){
              [self resumeTimer];
            [_menuView hideMenuView];
        }
        else if (option==MOInstruction){
            [self stopTimer];
            InstructionsVC *_instructionVC=[[InstructionsVC alloc]init];
            [self.navigationController pushViewController:_instructionVC animated:YES];
            [_instructionVC release];
        }
    };
    
    _gamePopover=[[GamePopOver alloc]initWithView:self.view];
    [self.view addSubview:_gamePopover];
    _gamePopover.gamepopOverOption=^(GamepopoverOption option){
        if (option==GOExit)
            [self.navigationController popViewControllerAnimated:YES];
        else if (option==GONewGame){
            [_gamePopover hideMenuView];
            [self getBestScore];
            [self updateNumberLabel];
            [_boardOverlay resetTiles];
            [self startTimer];
        }
        else if (option==GOInstruction){
            [self stopTimer];
            InstructionsVC *_instructionVC=[[InstructionsVC alloc]init];
            [self.navigationController pushViewController:_instructionVC animated:YES];
            [_instructionVC release];
        }
    };
    _gameWonPopover=[[GameWonPopover alloc]initWithView:self.view];
    [self.view addSubview:_gameWonPopover];
    _gameWonPopover.gameWonpopOverOption=^(GamepopoverOption option){
        if (option==GOExit)
            [self.navigationController popViewControllerAnimated:YES];
        else if (option==GONewGame){
            [_gameWonPopover hideMenuView];
            [self getBestScore];
            [self updateNumberLabel];
            [self startTimer];
            [_boardOverlay resetTiles];
        }
        else if (option==GOInstruction){
            [self stopTimer];
            InstructionsVC *_instructionVC=[[InstructionsVC alloc]init];
            [self.navigationController pushViewController:_instructionVC animated:YES];
            [_instructionVC release];
        }
    };
    
    tileManager().gameOverCallBack=^(int maxCount,BOOL isWon){
        [self stopTimer];
        _gameOverCount++;
        
        if (_gameOverCount>_maxGameCount) {
            if (_maxGameCount==0) {
                _maxGameCount=5;
            }
            [self performSelector:@selector(showVugleAd) withObject:nil afterDelay:1.5];
           
        }
        if (isWon) {
            if(!_gameWonPopover.isPopoverEnable){
                [self saveScore:0];
               
                [_gameWonPopover showMenuView];
            }
            
            if (_bestScore>_score) {
                _bestScore=_score;
            }
            if (_bestScore==0) {
                _bestScore=_score;
            }
            [_gameWonPopover  setScore:_score bestScore:_bestScore];
             [self submitScoreToLeaderboard];
        }
        else{
            if(!_gamePopover.isPopoverEnable){
                [self saveScore:((kNumberOfTiles *kNumberOfTiles)-(maxCount))];
                [_gamePopover showMenuView];
            }
            if (_bestScore>_score) {
                _bestScore=_score;
            }
            if (_bestScore==0) {
                _bestScore=_score;
            }
            [_gamePopover setscore:_score bestScore:_bestScore numberOfMissingTiles:((kNumberOfTiles *kNumberOfTiles)-(maxCount))];
             [self submitScoreToLeaderboard];
        }
    };
    
    [self getBestScore];
    [self startTimer];
    
    
    // Initialize the banner at the bottom of the screen.
    
    //iAd Banner
    _iAdBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height-50, self.view.frame.size.width, 50.0)];
    [self.view   insertSubview:_iAdBanner belowSubview:_menuView];
    _iAdBanner.delegate=self;
    [_iAdBanner setHidden:YES];
    
    //AdMob
    CGPoint origin = CGPointMake(0.0,self.view.frame.size.height -CGSizeFromGADAdSize(kGADAdSizeBanner).height);
    _adMobBanner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:origin];
    _adMobBanner.adUnitID = kAdMobId;
    _adMobBanner.delegate = self;
    _adMobBanner.frame=CGRectMake(0.0, self.view.frame.size.height-50.0, self.view.frame.size.width, 50.0);
    _adMobBanner.rootViewController = self;
    [self.view   insertSubview:_adMobBanner belowSubview:_menuView];
    [_adMobBanner loadRequest:[self request]];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopTimer];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)resumeTimer{
    [self stopTimer];
    _timer=[[NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(updateScore) userInfo:nil repeats:YES]retain];
}
-(void)startTimer{
    [self stopTimer];
    _score=0;
    _timer=[[NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(updateScore) userInfo:nil repeats:YES]retain];
}
-(void)updateScore{
    _score++;
    _scoreLabel.text=[self timeStringForTimeInterval:_score];
    
}
-(void)stopTimer{
    if (_timer) {
        [_timer invalidate];
        [_timer release];
        _timer=nil;
    }
}
-(void)menuBtnAction{
    [self stopTimer];
    [_menuView showMenuView];
}
-(void)getBestScore{
    _bestScore=0;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"BestScores"]==NULL) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSMutableArray arrayWithCapacity:10] forKey:@"BestScores"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else{
        NSMutableArray *_scoreArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"BestScores"];
        if (_scoreArray.count>0) {
           NSNumber * min = [_scoreArray valueForKeyPath:@"@min.intValue"];
            _bestScore=[min intValue];
        }
    }
    if (_bestScore>0) {
        _bestLabel.text=[self timeStringForTimeInterval:_bestScore];
    }
    else
        _bestLabel.text=[NSString stringWithFormat:@"00:00:00"];

    
}
-(NSString *)timeStringForTimeInterval:(int)timeinterval{
    int  minutes = floor((timeinterval/10)/60);
    int  seconds = round((timeinterval/10) - minutes * 60);
    int  miliseconds = round((timeinterval -seconds*10-minutes*60*10));
    
    NSString * _min=@"";
    if (minutes>9)
        _min=[NSString stringWithFormat:@"%i",minutes];
    else
        _min=[NSString stringWithFormat:@"0%i",minutes];
    
    NSString * _sec=@"";
    if (seconds>9)
        _sec=[NSString stringWithFormat:@"%i",seconds];
    else
        _sec=[NSString stringWithFormat:@"0%i",seconds];
    
    NSString * _milisec=@"";
    _milisec=[NSString stringWithFormat:@"%i",miliseconds];
      
    return [NSString stringWithFormat:@"%@:%@:%@",_min,_sec,_milisec];
}

-(void)saveScore:(int)numberOfMissingTiles{
    if (numberOfMissingTiles>0) {
        _score+=numberOfMissingTiles*60*2*10;
    }
    NSMutableArray *_scoreArray=[NSMutableArray arrayWithCapacity:100];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"BestScores"]!=NULL)
        [_scoreArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"BestScores"]];
    [_scoreArray addObject:[NSString stringWithFormat:@"%i",_score]];
    
    NSSortDescriptor *_sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self.intValue" ascending:YES];
    [_scoreArray sortUsingDescriptors:[NSArray arrayWithObject:_sortDescriptor]];
    
    NSMutableArray *_tempSavedArray=[NSMutableArray arrayWithCapacity:10];
    for (int i=0; i<10; i++) {
        if (i<_scoreArray.count) {
            [_tempSavedArray addObject:[_scoreArray objectAtIndex:i]];
        }
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSMutableArray arrayWithArray:_tempSavedArray] forKey:@"BestScores"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void) playSlidingSound{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"soundDisabled"]==NO){
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"button-31" ofType:@"mp3"];
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
        AudioServicesPlaySystemSound (soundID);

    }
}
-(void)playErrorSound{
     if ([[NSUserDefaults standardUserDefaults]boolForKey:@"soundDisabled"]==NO){
         NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"button-33a" ofType:@"mp3"];
         SystemSoundID soundID;
         AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
         AudioServicesPlaySystemSound (soundID);
     }
}
-(void)playBonusSound{
     if ([[NSUserDefaults standardUserDefaults]boolForKey:@"soundDisabled"]==NO){
         NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"button-43" ofType:@"mp3"];
         SystemSoundID soundID;
         AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
         AudioServicesPlaySystemSound (soundID);
     }
}

-(void)updateNumberLabel{
    NSArray *_valuesArray=[NSArray arrayWithArray:kSownTilesArray];
    int _value=[[_valuesArray objectAtIndex:arc4random()%_valuesArray.count]intValue];
    _lastShownValue=_value;
    [_numberTile setNumber:[NSString stringWithFormat:@"%i",_value]];
}

-(void)swipeTop:(UISwipeGestureRecognizer *)recognizer{
    CGPoint _touchPoint = [recognizer locationInView:[recognizer view]];
    UIView* _subView = [_boardOverlay hitTest:_touchPoint withEvent:nil];
    if ([_subView isKindOfClass:[TileView class]]&&_subView.tag<(kNumberOfTiles *kNumberOfTiles)) {
        TileView *_tileView=(TileView *)_subView;
        _selectedTile=_tileView;
        [tileManager() updateDataWithRespectToTile:_tileView];
        _initialRect=_tileView.frame;
        if (recognizer.state == UIGestureRecognizerStateEnded){
            if (tileManager().topValue>0.0 && tileManager().selectedValue+tileManager().topValue<=kMaximunTileLimit) {
             
                if (tileManager().selectedValue+tileManager().topValue==kMaximunTileLimit)
                    [self playBonusSound];
                else
                    [self playSlidingSound];
                [self moveTileAtRect:CGRectMake(_selectedTile.frame.origin.x, _selectedTile.frame.origin.y-_selectedTile.frame.size.height, _selectedTile.frame.size.width, _selectedTile.frame.size.height) withView:_selectedTile];
                _direction=TDTop;
                [self performSelector:@selector(updateTileData) withObject:nil afterDelay:0.2];
               
            }
            else{
                [self playErrorSound];
            }
        }
    }
}
-(void)swipeDown:(UISwipeGestureRecognizer *)recognizer{
    CGPoint _touchPoint = [recognizer locationInView:[recognizer view]];
    UIView* _subView = [_boardOverlay hitTest:_touchPoint withEvent:nil];
    if ([_subView isKindOfClass:[TileView class]]&&_subView.tag<(kNumberOfTiles *kNumberOfTiles)) {
        TileView *_tileView=(TileView *)_subView;
        _selectedTile=_tileView;
        _initialRect=_tileView.frame;
        [tileManager() updateDataWithRespectToTile:_tileView];
        if (recognizer.state == UIGestureRecognizerStateEnded){
            if (tileManager().bottomValue>0.0 && tileManager().selectedValue+tileManager().bottomValue<=kMaximunTileLimit) {
                if (tileManager().selectedValue+tileManager().bottomValue==kMaximunTileLimit)
                    [self playBonusSound];
                else
                    [self playSlidingSound];
                
                [self moveTileAtRect:CGRectMake(_selectedTile.frame.origin.x, _selectedTile.frame.origin.y+_selectedTile.frame.size.height, _selectedTile.frame.size.width, _selectedTile.frame.size.height) withView:_selectedTile];
                _direction=TDBottom;
                [self performSelector:@selector(updateTileData) withObject:nil afterDelay:0.2];
            }
            else{
                [self playErrorSound];
            }
        }
    }
}
-(void)swipeLeft:(UISwipeGestureRecognizer *)recognizer{
  
    CGPoint _touchPoint = [recognizer locationInView:[recognizer view]];
    UIView* _subView = [_boardOverlay hitTest:_touchPoint withEvent:nil];
    if ([_subView isKindOfClass:[TileView class]]&&_subView.tag<(kNumberOfTiles *kNumberOfTiles)) {
        TileView *_tileView=(TileView *)_subView;
        _selectedTile=_tileView;
        _initialRect=_tileView.frame;
        [tileManager() updateDataWithRespectToTile:_tileView];
        if (recognizer.state == UIGestureRecognizerStateEnded){
            if (tileManager().leftValue>0.0 && tileManager().selectedValue+tileManager().leftValue<=kMaximunTileLimit) {
             
                if (tileManager().selectedValue+tileManager().leftValue==kMaximunTileLimit)
                    [self playBonusSound];
                else
                    [self playSlidingSound];
                [self moveTileAtRect:CGRectMake(_selectedTile.frame.origin.x-_selectedTile.frame.size.width, _selectedTile.frame.origin.y, _selectedTile.frame.size.width, _selectedTile.frame.size.height) withView:_selectedTile];
                _direction=TDLeft;
                [self performSelector:@selector(updateTileData) withObject:nil afterDelay:0.2];
                

            }
            else{
                [self playErrorSound];
            }
        }
    }
}
-(void)swipeRight:(UISwipeGestureRecognizer *)recognizer{
    
    CGPoint _touchPoint = [recognizer locationInView:[recognizer view]];
    UIView* _subView = [_boardOverlay hitTest:_touchPoint withEvent:nil];
    if ([_subView isKindOfClass:[TileView class]]&&_subView.tag<(kNumberOfTiles *kNumberOfTiles)) {
        TileView *_tileView=(TileView *)_subView;
        _selectedTile=_tileView;
        _initialRect=_tileView.frame;
        [tileManager() updateDataWithRespectToTile:_tileView];
        if (recognizer.state == UIGestureRecognizerStateEnded){
            if (tileManager().rightValue>0.0 && tileManager().selectedValue+tileManager().rightValue<=kMaximunTileLimit) {
              
                if (tileManager().selectedValue+tileManager().rightValue==kMaximunTileLimit)
                    [self playBonusSound];
                else
                    [self playSlidingSound];
                [self moveTileAtRect:CGRectMake(_selectedTile.frame.origin.x+_selectedTile.frame.size.width, _selectedTile.frame.origin.y, _selectedTile.frame.size.width, _selectedTile.frame.size.height) withView:_selectedTile];
                _direction=TDRight;
                [self performSelector:@selector(updateTileData) withObject:nil afterDelay:0.2];
                
            }
            else{
                [self playErrorSound];
            }
        }
    }
}

-(void)moveTileAtRect:(CGRect)rect withView:(UIView *)tileView{
    self.view.userInteractionEnabled=NO;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.2];
    tileView.frame=rect;
    tileView.alpha=0.0;
    [UIView commitAnimations];
    [self performSelector:@selector(resetTile:) withObject:tileView  afterDelay:0.2];
    
}
-(void)resetTile:(UIView *)tileView{
    tileView.frame=_initialRect;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.2];
    tileView.alpha=1.0;
    [UIView commitAnimations];
    self.view.userInteractionEnabled=YES;
}
-(void)updateTileData{
    if (_direction==TDLeft) {
        TileView *_tileView=(TileView *)[_boardOverlay viewWithTag:tileManager().leftViewTag];
        [_tileView setNumber:[NSString stringWithFormat:@"%i",(int)(tileManager().leftValue+tileManager().selectedValue)]];
        [tileManager() updateArrayAtIndex:(int)tileManager().leftViewTag withValue:(int)(tileManager().leftValue+tileManager().selectedValue)];

    }
    else if (_direction==TDRight){
        TileView *_tileView=(TileView *)[_boardOverlay viewWithTag:tileManager().rightViewTag];
        [_tileView setNumber:[NSString stringWithFormat:@"%i",(int)(tileManager().rightValue+tileManager().selectedValue)]];
        [tileManager() updateArrayAtIndex:(int)tileManager().rightViewTag withValue:(int)(tileManager().rightValue+tileManager().selectedValue)];
    }
    else if (_direction==TDTop){
        TileView *_tileView=(TileView *)[_boardOverlay viewWithTag:tileManager().topViewTag];
        [_tileView setNumber:[NSString stringWithFormat:@"%i",(int)(tileManager().topValue+tileManager().selectedValue)]];
        [tileManager() updateArrayAtIndex:(int)tileManager().topViewTag withValue:(int)(tileManager().topValue+tileManager().selectedValue)];
        
    }
    else{
        TileView *_tileView=(TileView *)[_boardOverlay viewWithTag:tileManager().bottomViewTag];
        [_tileView setNumber:[NSString stringWithFormat:@"%i",(int)(tileManager().bottomValue+tileManager().selectedValue)]];
        [tileManager() updateArrayAtIndex:(int)tileManager().bottomViewTag withValue:(int)(tileManager().bottomValue+tileManager().selectedValue)];
    }
   
    TileView *_tileView=(TileView *)[_boardOverlay viewWithTag:(int)_selectedTile.tag];
    [_tileView setNumber:[NSString stringWithFormat:@"%i",_lastShownValue]];
    [tileManager() updateArrayAtIndex:(int)_selectedTile.tag withValue:_lastShownValue];
    [self updateNumberLabel];
    
    [tileManager() checkGameStatus];
    
}
-(void)showVugleAd{
    _gameOverCount=0;
    VungleSDK* sdk = [VungleSDK sharedSDK];
    [sdk playAd:self];
}
#pragma mark - Score Sharing
-(void)shareScore{
	[[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error){
		if (!error)
            [self submitScoreToLeaderboard];
	}];
}
-(void)submitScoreToLeaderboard{
    GKScore *_scoreValue = [[[GKScore alloc] initWithCategory:kLeaderBoardKey] autorelease];
    _scoreValue.value = _score;
    [_scoreValue reportScoreWithCompletionHandler:^(NSError *error){
    }];
}
#pragma mark GADRequest generation
- (GADRequest *)request {
    GADRequest *request = [GADRequest request];
    request.testDevices = @[GAD_SIMULATOR_ID];
    return request;
}

#pragma mark GADBannerViewDelegate implementation
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
}

#pragma mark iAd Delegate
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    [_iAdBanner setHidden:YES];
    [_adMobBanner setHidden:NO];
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    [_iAdBanner setHidden:YES];
    [_adMobBanner setHidden:NO];
}
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    BOOL shouldExecuteAction = YES;
    if (!willLeave && shouldExecuteAction){
    }
    return shouldExecuteAction;
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
