//
//  MenuView.m
//  100
//
//  Created by GP on 27/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView
- (void)postToFacebook {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"Playing  ' 100 ' on my iphone ! Try and beat me , get it Free  "];
        [controller addURL:[NSURL URLWithString:@"http://tinyurl.com/mpv2f56"]];
        [controller addImage:[UIImage imageNamed:@"Icon-76@2x.png"]];
        [self.window.rootViewController presentViewController:controller animated:YES completion:nil];

    }
}

- (id)initWithView:(UIView *)view{
    self = [super initWithFrame:view.bounds];
    if (self) {
        
         self.backgroundColor=[UIColor colorWithRed:0/255.0 green:130/255.0 blue:255/255.0 alpha:0.6];
        self.alpha=0.0;
        
        
        //Intailize Variables
        CGFloat yOffset=self.frame.size.height/2-110.0;
        CGFloat xOffset=50.0;
        CGFloat height=50.0;
        CGFloat textSize=26.0;
        CGFloat width=self.frame.size.width-100.0;
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
            yOffset=self.frame.size.height/2-160.0;
            height=90;
            textSize=36.0;
            width=self.frame.size.width-300.0;
            xOffset=150;
        }
        
        //Add OPtions Buttons
        NSArray *_buttonArray=[NSArray arrayWithObjects:@"Resume",@"New Game",@"Instructions",@"Exit",@" Please Share", nil];
        for (int i =0; i<_buttonArray.count; i++) {
            UIButton *_button=[UIButton buttonWithType:UIButtonTypeCustom];
            _button.backgroundColor=[UIColor clearColor];
            _button.frame=CGRectMake(xOffset, yOffset, width, height);
            [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _button.titleLabel.font=[UIFont fontWithName:@"Kreon-Light" size:textSize];
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
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.1];
    self.alpha=1.0;
    self.transform=CGAffineTransformIdentity;
    [UIView commitAnimations];
    
}
-(void)hideMenuView{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.1];
    self.alpha=0.0;
    self.transform=CGAffineTransformMakeScale(0.7, 0.7);
    [UIView commitAnimations];
    
}
-(void)btnAction:(UIButton *)sender{
    MenuOption _option;
    if(sender.tag==0)
        _option=MOResume;
    else if (sender.tag==1)
        _option=MONewGame;
    else if (sender.tag==2)
        _option=MOInstruction;
    else if (sender.tag==4)
        [self postToFacebook];
    else
        _option=MOExit;
    if (_menuOption) 
        _menuOption(_option);
    
}

@end
