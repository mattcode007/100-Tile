//
//  ScoreVC.h
//  100
//
//  Created by GP on 30/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface ScoreVC : UIViewController<UITableViewDataSource,UITableViewDelegate,GKLeaderboardViewControllerDelegate>
{
    UITableView     *_tableView;
    NSMutableArray  *_scoreArray;

}

@end
