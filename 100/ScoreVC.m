//
//  ScoreVC.m
//  100
//
//  Created by GP on 30/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import "ScoreVC.h"

@implementation ScoreVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:141.0/255.0 green:198.0/255.0 blue:63.0/255.0 alpha:0.9];
   
    
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
    _headerLabel.font=[UIFont fontWithName:@"Helvetica" size:textSize];
    _headerLabel.textColor=[UIColor whiteColor];
    _headerLabel.text=@"Score";
    [self.view addSubview:_headerLabel];
    [_headerLabel release];
    
    //BAck button Actions
    UIButton *_backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame=CGRectMake(5.0, 18.0, 60.0, 44.0);
    [_backBtn setImage:[UIImage imageNamed:@"Left_Arrow.png"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    _scoreArray=[[NSMutableArray alloc]init];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"BestScores"]!=NULL) {
         NSMutableArray *_tempScoreArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"BestScores"];
        [_scoreArray addObjectsFromArray:_tempScoreArray];
        NSSortDescriptor *_sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self.intValue" ascending:YES];
        [_scoreArray sortUsingDescriptors:[NSArray arrayWithObject:_sortDescriptor]];
    }
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0, 45.0, self.view.frame.size.width, self.view.frame.size.height-45.0) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
    //Leaderboard Button
    UIButton *_leaderBoardBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _leaderBoardBtn.frame=CGRectMake(self.view.frame.size.width-100.0, 18.0, 90.0, 30.0);
    _leaderBoardBtn.backgroundColor=[UIColor colorWithWhite:1.0 alpha:0.1];
    [_leaderBoardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leaderBoardBtn setTitle:@"LeaderBoard" forState:UIControlStateNormal];
    _leaderBoardBtn.titleLabel.font=[UIFont fontWithName:@"Kreon-Light" size:14.0];
    [_leaderBoardBtn addTarget:self action:@selector(showLeaderboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leaderBoardBtn];
}
#pragma mark TableView Delegate/Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _scoreArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[UIDevice currentDevice].model isEqualToString:kDeviceType])
        return 80.0;
    else
        return 50.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *_cellIdentifier=@"cell";
    UITableViewCell *_cell=[tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell==nil) {
        _cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:_cellIdentifier]autorelease];
        _cell.backgroundColor=[UIColor clearColor];
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;
        _cell.textLabel.textColor=[UIColor whiteColor];
        _cell.textLabel.font=[UIFont fontWithName:@"Kreon-Bold" size:14.0];
        if([[UIDevice currentDevice].model isEqualToString:kDeviceType])
          _cell.textLabel.font=[UIFont fontWithName:@"Kreon-Bold" size:24.0];
        
        
        UILabel *_dividerLbl=[[UILabel alloc]initWithFrame:CGRectMake(15.0, [self tableView:tableView heightForRowAtIndexPath:indexPath]-1.0, self.view.frame.size.width-30.0, 0.5)];
        _dividerLbl.backgroundColor=[UIColor whiteColor];
        [_cell.contentView addSubview:_dividerLbl];
        [_dividerLbl release];
        
    }
    _cell.textLabel.text=[NSString stringWithFormat:@"   %@",[self timeStringForTimeInterval:[[_scoreArray objectAtIndex:indexPath.row]intValue]]];
    return _cell;
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
    if (miliseconds>9)
        _milisec=[NSString stringWithFormat:@"%i",miliseconds];
    else
        _milisec=[NSString stringWithFormat:@"0%i",miliseconds];
    
    
    return [NSString stringWithFormat:@"%@:%@:%@",_min,_sec,_milisec];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *_footerView=[[[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 320.0, 1.0)]autorelease];
    _footerView.backgroundColor=[UIColor clearColor];
    return _footerView;
}
#pragma mark Button Actions
/***
 *LeaderBoard button Action
 **/
-(void)showLeaderboard{
    // Check Player Authetication
	[[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error){
		if (!error){
            GKLeaderboardViewController *_leaderBoard = [[GKLeaderboardViewController alloc] init];
            if(_leaderBoard != nil){
                _leaderBoard.leaderboardDelegate = self;
                [self presentModalViewController:_leaderBoard animated:YES];
            }
        }
        else
            [self showAuthenticationFailAlert];
	}];
}
-(void)showAuthenticationFailAlert{
    UIAlertView *_alertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"There is some error in leaderboard right now.Please try after some time!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [_alertView show];
    [_alertView release];
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController{
	[self dismissModalViewControllerAnimated: YES];
	[viewController release];
}
-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
