//
//  GameWonPopover.m
//  100
//
//  Created by GP on 29/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import "GameWonPopover.h"

@implementation GameWonPopover

- (id)initWithView:(UIView *)view{
    self = [super initWithFrame:view.bounds];
    if (self) {
            self.backgroundColor=[UIColor colorWithRed:141.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:1.0];
        self.alpha=0.0;
        _isPopoverEnable=NO;
        
        CGFloat yOffset=self.frame.size.height/2+10.0;
        
        
        UILabel *_label=[[UILabel alloc]initWithFrame:CGRectMake(5.0, yOffset-160, self.frame.size.width-10.0, 40.0)];
        _label.backgroundColor=[UIColor clearColor];
        _label.textColor=[UIColor whiteColor];
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=[UIFont fontWithName:@"Kreon-Light" size:38.0];
        _label.text=@"Mission Completed";
        [self addSubview:_label];
        [_label release];
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(20.0, yOffset-110,150.0, 40.0)];
        _label.backgroundColor=[UIColor clearColor];
        _label.textColor=[UIColor whiteColor];
        _label.textAlignment=NSTextAlignmentLeft;
        _label.font=[UIFont fontWithName:@"Kreon-Light" size:20.0];
        _label.text=@"Your Time:";
        [self addSubview:_label];
        [_label release];
        
        
        _yourTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(111.0, yOffset-113,200, 40.0)];
        _yourTimeLabel.backgroundColor=[UIColor clearColor];
        _yourTimeLabel.textColor=[UIColor whiteColor];
        _yourTimeLabel.textAlignment=NSTextAlignmentLeft;
        _yourTimeLabel.font=[UIFont fontWithName:@"Kreon-Bold" size:30.0];
        _yourTimeLabel.text=@"0";
        [self addSubview:_yourTimeLabel];
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(20.0, yOffset-75,150.0, 40.0)];
        _label.backgroundColor=[UIColor clearColor];
        _label.textColor=[UIColor whiteColor];
        _label.textAlignment=NSTextAlignmentLeft;
        _label.font=[UIFont fontWithName:@"Kreon-Light" size:20.0];
        _label.text=@"Best Time:";
        [self addSubview:_label];
        [_label release];
        
        
        _bestTimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(111.0, yOffset-78,200, 40.0)];
        _bestTimeLabel.backgroundColor=[UIColor clearColor];
        _bestTimeLabel.textColor=[UIColor whiteColor];
        _bestTimeLabel.textAlignment=NSTextAlignmentLeft;
        _bestTimeLabel.font=[UIFont fontWithName:@"Kreon-Bold" size:30.0];
        _bestTimeLabel.text=@"";
        [self addSubview:_bestTimeLabel];
        
        
        CGFloat height=50.0;
        NSArray *_buttonArray=[NSArray arrayWithObjects:@"New Game",@"Instructions",@"Exit", nil];
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
- (void)setScore:(int)yourScore bestScore:(int)bestScore{
    _yourTimeLabel.text=[self timeStringForTimeInterval:yourScore];

    _bestTimeLabel.text=[self timeStringForTimeInterval:bestScore];
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
-(void)btnAction:(UIButton *)sender{
    GamepopoverOption _option;
    if(sender.tag==1)
        _option=GOInstruction;
    else if (sender.tag==0)
        _option=GONewGame;
    else
        _option=GOExit;
    
    if (_gameWonpopOverOption)
        _gameWonpopOverOption(_option);
}


@end
