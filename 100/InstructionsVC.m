//
//  InstructionsVC.m
//  100
//
//  Created by GP on 30/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import "InstructionsVC.h"


@implementation InstructionsVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0/255.0 green:130/255.0 blue:255/255.0 alpha:1.0];
    
    CGFloat textSize=20.0;
    CGFloat lblFont= 14.0;
    CGFloat lblHeight=20.0;
    
    if([[UIDevice currentDevice].model isEqualToString:kDeviceType]){
        textSize=30.0;
        lblHeight=40.0;
        lblFont= 24.0;
    }
    
    //Header Label
    UILabel *_headerLabel=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 15.0, self.view.frame.size.width, 45.0)];
    _headerLabel.backgroundColor=[UIColor clearColor];
    _headerLabel.textAlignment=NSTextAlignmentCenter;
    _headerLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:13.0f];
    _headerLabel.textColor=[UIColor whiteColor];
    _headerLabel.text=@"INSTRUCTIONS";
    [self.view addSubview:_headerLabel];
    [_headerLabel release];
    
    //BAck button Actions
    UIButton *_backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame=CGRectMake(5.0, 18.0, 60.0, 44.0);
    [_backBtn setImage:[UIImage imageNamed:@"Left_Arrow.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    //Hints Array
    NSArray *_array=[NSArray arrayWithObjects:
                     @"Slide with tiles to get only one 100% Tile per each tile",
                     @"Value of tiles are counted.",
                     @"Each newly created 100% Tile is fixed and player cannot move it anymore.",
                     @"Example: 60% tile can be moved to 20% tile, but 60% tile can not be moved to 50% tile (total exceeds 100%)",
                     @"Player moves only with 1 tile in one move.",
                     @"New tile will appear on each tile which was moved in previous step.",
                     @"Game tip: Watch the Next Tile value upper left corner.",
                     @"Target is to create 100% Tiles in all tiles as fast as you can.",
                     @"Good luck!",
                     nil];
    CGFloat yOffset=65.0;
    for (int i=0; i<_array.count; i++) {
        UILabel *_lbl=[[UILabel alloc]initWithFrame:CGRectMake(10.0, yOffset, self.view.frame.size.width-20.0, lblHeight)];
        _lbl.backgroundColor=[UIColor clearColor];
        _lbl.textColor=[UIColor whiteColor];
        _lbl.font=[UIFont fontWithName:@"Helvetica-Bold" size:lblFont];
        _lbl.textColor=[UIColor whiteColor];
        _lbl.numberOfLines=0;
        _lbl.text=[NSString stringWithFormat:@"%i) %@",i+1,[_array objectAtIndex:i]];
        [self.view addSubview:_lbl];
        [_lbl sizeToFit];
        yOffset=_lbl.frame.origin.y+_lbl.frame.size.height+10;
        [_lbl release];
        
    }
}

//Back Button Action
-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
