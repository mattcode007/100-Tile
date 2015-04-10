//
//  HomeVC.m
//  100
//
//  Created by GP on 27/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import "HomeVC.h"
#import "AppDelegate.h"
@implementation HomeVC

//istruzioni iniziali


- (void)viewDidLoad{
    [super viewDidLoad];
   
    
   
      
    //Intialize GameCenter
    //Intialize GameCenter
    
    self.view.backgroundColor=[UIColor colorWithRed: 51/255.0 green:204/255.0 blue:254/255.0 alpha:0.6];
;
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error){
	}];
    
    //Intailize Variables
    CGFloat yOffset=self.view.frame.size.height/2-80.0;
    CGFloat xOffset=50.0;
    CGFloat height=50.0;
    CGFloat textSize=26.0;
    CGFloat width=self.view.frame.size.width-100.0;
    if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
        yOffset=self.view.frame.size.height/2-120.0;
        height=90;
        textSize=36.0;
        width=self.view.frame.size.width-300.0;
        xOffset=150;
    }
    UILabel *_headerLabel=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 60.0, self.view.frame.size.width, 45.0)];
    _headerLabel.backgroundColor=[UIColor clearColor];
    _headerLabel.textAlignment=NSTextAlignmentCenter;
   
   
    _headerLabel.font=[UIFont fontWithName:@"Kreon-Bold" size:35.0f];
    _headerLabel.textColor=[UIColor whiteColor];
    _headerLabel.text=@" Can you make 100 ?" ;
    _headerLabel.hidden=NO;
    [self.view addSubview:_headerLabel];
    
   /* UILabel *_Label=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 270.0, self.view.frame.size.width, 45.0)];
    _Label.backgroundColor=[UIColor clearColor];
    _Label.textAlignment=NSTextAlignmentCenter;
    _Label.font=[UIFont fontWithName:@"Kreon-Bold" size:10.0f];
    _Label.textColor=[UIColor whiteColor];
    _Label.text=@"Turn On/Off Audio ";
    [self.view addSubview:_Label];*/
    
    UILabel *_Label1=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 500.0, self.view.frame.size.width, 45.0)];
    _Label1.backgroundColor=[UIColor clearColor];
    _Label1.textAlignment=NSTextAlignmentCenter;
    _Label1.numberOfLines = 10;
    _Label1.font=[UIFont fontWithName:@"Helvetica" size:10.0f];
    _Label1.textColor=[UIColor whiteColor];
    _Label1.text=@"Make 100 in every tile to win the game . The next tile that will appare is shown on the top right section of the game under the name of 'next tile' ";
    [self.view addSubview:_Label1];

    //Add OPtions Buttons
    NSArray *_buttonArray=[NSArray arrayWithObjects:@"Play!", nil];
    for (int i =0; i<_buttonArray.count; i++) {
        UIButton *_button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor=[UIColor clearColor];
        _button.frame=CGRectMake(xOffset, yOffset, width, height);
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:textSize];
        [_button setTitle:[_buttonArray objectAtIndex:i] forState:UIControlStateNormal];
        _button.layer.borderColor=[UIColor whiteColor].CGColor;
        _button.tag=i;
        [_button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _button.layer.borderWidth=5.0;
        [self.view addSubview:_button];
        yOffset+=height+40.0;
    }
    
    //Sound Buttons
    UIButton *_soundButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _soundButton.backgroundColor=[UIColor clearColor];
    [_soundButton setImage:[UIImage imageNamed:@"soundOn.png"] forState:UIControlStateNormal];
    [_soundButton setImage:[UIImage imageNamed:@"soundOff.png"] forState:UIControlStateSelected];
    _soundButton.frame=CGRectMake(150.0, self.view.frame.size.height-240.0, 30.0, 30.0);
    if([[UIDevice currentDevice].model isEqualToString:kDeviceType])
          _soundButton.frame=CGRectMake(10.0, self.view.frame.size.height-60.0, 50.0, 50.0);
    [_soundButton addTarget:self action:@selector(soundBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_soundButton];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"soundDisabled"]) {
        _soundButton.selected=YES;
    }
}

//Menu Button OPtions
-(void)btnAction:(UIButton *)sender{
    if(sender.tag==0){
        GameVC *_gameVC=[[GameVC alloc]init];
        [self.navigationController pushViewController:_gameVC animated:YES];
        [_gameVC release];
    }
    else if (sender.tag==1){
        ScoreVC *_scoreVC=[[ScoreVC alloc]init];
        [self.navigationController pushViewController:_scoreVC animated:YES];
        [_scoreVC release];
        
    }
    else if (sender.tag==2){
        InstructionsVC *_instructionVC=[[InstructionsVC alloc]init];
        [self.navigationController pushViewController:_instructionVC animated:YES];
        [_instructionVC release];
    }
}
//Sound Button Action
-(void)soundBtnAction:(UIButton *)sender{
    if (sender.selected) {
        sender.selected=NO;
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"soundDisabled"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else{
        sender.selected=YES;
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"soundDisabled"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
//Status Bar
-(BOOL)prefersStatusBarHidden{
    return NO;
}
@end
