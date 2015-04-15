//
//  GamePopOver.m
//  100
//
//  Created by GP on 27/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import "GamePopOver.h"

@implementation GamePopOver


- (id)initWithView:(UIView *)view{
    self = [super initWithFrame:view.bounds];
    if (self) {
      
        self.backgroundColor=[UIColor colorWithRed:0/255.0 green:130/255.0 blue:255/255.0 alpha:0.6];
        self.alpha=0.0;
        _isPopoverEnable=NO;
               CGFloat yOffset=self.frame.size.height/2+10.0-200;
        CGFloat headerFontSize=50.0;
        CGFloat headerLblHeight=40.0;
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
            yOffset=self.frame.size.height/2-300.0;
            headerFontSize=80.0;
            headerLblHeight=90.0;
        }
        
        UILabel *_label=[[UILabel alloc]initWithFrame:CGRectMake(5.0, yOffset, self.frame.size.width-10.0, headerLblHeight)];
        _label.backgroundColor=[UIColor clearColor];
        _label.textColor=[UIColor whiteColor];
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=[UIFont fontWithName:@"Kreon-Light" size:headerFontSize];
        _label.text=@"Game Over";
        _label.hidden = YES;
        
        
        [self addSubview:_label];
        [_label release];
        
         yOffset+=headerLblHeight;
        
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(15.0, yOffset,150.0, 40.0)];
        _label.backgroundColor=[UIColor clearColor];
        _label.textColor=[UIColor whiteColor];
        _label.textAlignment=NSTextAlignmentLeft;
        _label.font=[UIFont fontWithName:@"Kreon-Light" size:15.0];
        _label.text=@"Tiles Not Cleared:";
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
            _label.frame=CGRectMake(5.0, yOffset, self.frame.size.width/2-20.0, 60.0);
            _label.textAlignment=NSTextAlignmentRight;
            _label.font=[UIFont fontWithName:@"Kreon-Light" size:30.0];
        }
        [self addSubview:_label];
        [_label release];
        
       
        _numberOfTileLbl=[[UILabel alloc]initWithFrame:CGRectMake(124.0, yOffset,200, 40.0)];
        _numberOfTileLbl.backgroundColor=[UIColor clearColor];
        _numberOfTileLbl.textColor=[UIColor whiteColor];
        _numberOfTileLbl.textAlignment=NSTextAlignmentLeft;
        _numberOfTileLbl.font=[UIFont fontWithName:@"Kreon-Bold" size:20.0];
        _numberOfTileLbl.text=@"36=";
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
            _numberOfTileLbl.frame=CGRectMake(self.frame.size.width/2-15.0, yOffset, self.frame.size.width/2-10.0, 60.0);
            _numberOfTileLbl.font=[UIFont fontWithName:@"Kreon-Bold" size:40.0];
        }
        [self addSubview:_numberOfTileLbl];
        
        
        _penalityMinsLbl=[[UILabel alloc]initWithFrame:CGRectMake(160.0, yOffset,200, 40.0)];
        _penalityMinsLbl.backgroundColor=[UIColor clearColor];
        _penalityMinsLbl.textColor=[UIColor blackColor];
        _penalityMinsLbl.textAlignment=NSTextAlignmentLeft;
        _penalityMinsLbl.font=[UIFont fontWithName:@"Kreon-Light" size:20.0];
        _penalityMinsLbl.text=@"144 penalty mins";
        
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
            _penalityMinsLbl.frame=CGRectMake(self.frame.size.width/2+55.0, yOffset, self.frame.size.width/2-10.0, 60.0);
            _penalityMinsLbl.font=[UIFont fontWithName:@"Hevetica" size:35.0];
        }
        [self addSubview:_penalityMinsLbl];
        
        yOffset+=_penalityMinsLbl.frame.size.height+10.0;
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(15.0, yOffset,150.0, 40.0)];
        _label.backgroundColor=[UIColor clearColor];
        _label.textColor=[UIColor whiteColor];
        _label.textAlignment=NSTextAlignmentLeft;
        _label.font=[UIFont fontWithName:@"Kreon-Light" size:15.0];
        _label.text=@"Time:";
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
            _label.frame=CGRectMake(5.0, yOffset, self.frame.size.width/2-10.0, 60.0);
            _label.font=[UIFont fontWithName:@"Kreon-Light" size:30.0];
            _label.textAlignment=NSTextAlignmentRight;
        }
        [self addSubview:_label];
        [_label release];
        
        
        _yourTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(111.0, yOffset,200, 40.0)];
        _yourTimeLabel.backgroundColor=[UIColor clearColor];
        _yourTimeLabel.textColor=[UIColor whiteColor];
        _yourTimeLabel.textAlignment=NSTextAlignmentLeft;
        _yourTimeLabel.font=[UIFont fontWithName:@"Kreon-Bold" size:25.0];
        _yourTimeLabel.text=@"0";
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
            _yourTimeLabel.frame=CGRectMake(self.frame.size.width/2+5.0, yOffset-3.0, self.frame.size.width/2-10.0, 60.0);
            _yourTimeLabel.font=[UIFont fontWithName:@"Kreon-Light" size:35.0];
            _yourTimeLabel.textAlignment=NSTextAlignmentLeft;
        }
        [self addSubview:_yourTimeLabel];
        
        yOffset+=_yourTimeLabel.frame.size.height+10.0;
        
        
        UIView *_whiteContainerView=[[UIView alloc]initWithFrame:CGRectMake(10.0, yOffset, self.frame.size.width-20.0, 40.0)];
        _whiteContainerView.backgroundColor=[UIColor whiteColor];
        _whiteContainerView.layer.cornerRadius=2.0;
        [self addSubview:_whiteContainerView];
        [_whiteContainerView release];
        
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(15.0, yOffset,150.0, 40.0)];
        _label.backgroundColor=[UIColor clearColor];
        _label.textColor=[UIColor blackColor];
        _label.textAlignment=NSTextAlignmentLeft;
        _label.font=[UIFont fontWithName:@"Kreon-Light" size:15.0];
        _label.text=@"Final Time:";
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
            _label.frame=CGRectMake(5.0, yOffset-10, self.frame.size.width/2-10.0, 60.0);
            _label.font=[UIFont fontWithName:@"Kreon-Light" size:30.0];
            _label.textAlignment=NSTextAlignmentRight;
        }
        [self addSubview:_label];
        [_label release];
        
    
        _finalTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(111.0, yOffset,200, 40.0)];
        _finalTimeLabel.backgroundColor=[UIColor clearColor];
        _finalTimeLabel.textColor=[UIColor blackColor];
        _finalTimeLabel.textAlignment=NSTextAlignmentLeft;
        _finalTimeLabel.font=[UIFont fontWithName:@"Kreon-Bold" size:25.0];
        _finalTimeLabel.text=@"0";
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
            _finalTimeLabel.frame=CGRectMake(self.frame.size.width/2+5.0, yOffset-10.0, self.frame.size.width/2-10.0, 60.0);
            _finalTimeLabel.font=[UIFont fontWithName:@"Kreon-Light" size:35.0];
            _finalTimeLabel.textAlignment=NSTextAlignmentLeft;
        }
        [self addSubview:_finalTimeLabel];
        
         yOffset+=_yourTimeLabel.frame.size.height+10.0;
        
       
        _label=[[UILabel alloc]initWithFrame:CGRectMake(15.0, yOffset,150.0, 40.0)];
        _label.backgroundColor=[UIColor clearColor];
        _label.textColor=[UIColor whiteColor];
        _label.textAlignment=NSTextAlignmentLeft;
        _label.font=[UIFont fontWithName:@"Kreon-Light" size:15.0];
        _label.text=@"Best Time:";
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
            _label.frame=CGRectMake(5.0, yOffset-10, self.frame.size.width/2-10.0, 60.0);
            _label.font=[UIFont fontWithName:@"Kreon-Light" size:30.0];
            _label.textAlignment=NSTextAlignmentRight;
        }
        [self addSubview:_label];
        [_label release];
        
        
        _bestTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(111.0, yOffset,200, 40.0)];
        _bestTimeLabel.backgroundColor=[UIColor clearColor];
        _bestTimeLabel.textColor=[UIColor whiteColor];
        _bestTimeLabel.textAlignment=NSTextAlignmentLeft;
        _bestTimeLabel.font=[UIFont fontWithName:@"Kreon-Bold" size:25.0];
        _bestTimeLabel.text=@"0";
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
            _bestTimeLabel.frame=CGRectMake(self.frame.size.width/2+5.0, yOffset-10.0, self.frame.size.width/2-10.0, 60.0);
            _bestTimeLabel.font=[UIFont fontWithName:@"Kreon-Light" size:35.0];
            _bestTimeLabel.textAlignment=NSTextAlignmentLeft;
        }
        [self addSubview:_bestTimeLabel];
        
    
        yOffset+=_bestTimeLabel.frame.size.height+10.0;;
        CGFloat height=50.0;
        NSArray *_buttonArray=[NSArray arrayWithObjects:@"Play Again",@"Instructions",@"Exit", nil];
        for (int i =0; i<_buttonArray.count; i++) {
            UIButton *_button=[UIButton buttonWithType:UIButtonTypeCustom];
            _button.backgroundColor=[UIColor clearColor];
            _button.frame=CGRectMake(50.0, yOffset, self.frame.size.width-100.0, height);
            [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _button.titleLabel.font=[UIFont fontWithName:@"Kreon-Light" size:26.0];
            [_button setTitle:[_buttonArray objectAtIndex:i] forState:UIControlStateNormal];
            _button.layer.borderColor=[UIColor whiteColor].CGColor;
            _button.tag=i;
            [_button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            _button.layer.borderWidth=3.0;
            [self addSubview:_button];
            yOffset+=height+10.0;
        }
       
        
        self.transform=CGAffineTransformMakeScale(0.7, 0.7);
        
    }
    return self;
}
-(void)showMenuView{
    _isPopoverEnable=YES;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.1];
    self.alpha=1.0;
    self.transform=CGAffineTransformIdentity;
    [UIView commitAnimations];
    
}
-(void)hideMenuView{
    _isPopoverEnable=NO;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.1];
    self.alpha=0.0;
    self.transform=CGAffineTransformMakeScale(0.7, 0.7);
    [UIView commitAnimations];
    
}
- (void)setScore:(int)score{
   
}
- (void)setscore:(int)score bestScore:(int)bestScore numberOfMissingTiles:(int)numberOfMissingTiles{
    _numberOfTileLbl.text=[NSString stringWithFormat:@"%i=",numberOfMissingTiles];
    _penalityMinsLbl.text=[NSString stringWithFormat:@"%i penalty mins",numberOfMissingTiles*2];
    
    _yourTimeLabel.text=[self timeStringForTimeInterval:score-numberOfMissingTiles*2*60*10];
    _finalTimeLabel.text=[self timeStringForTimeInterval:score];
    _bestTimeLabel.text=[self timeStringForTimeInterval:bestScore];
}
-(void)btnAction:(UIButton *)sender{
    GamepopoverOption _option;
    if(sender.tag==1)
        _option=GOInstruction;
    else if (sender.tag==0)
        _option=GONewGame;
    else 
        _option=GOExit;

    if (_gamepopOverOption)
        _gamepopOverOption(_option);
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
    
    return [NSString stringWithFormat:@"%@m:%@s:%@ms",_min,_sec,_milisec];
}



@end
