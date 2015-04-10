//
//  GameWonPopover.h
//  100
//
//  Created by GP on 29/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GamePopOver.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
@interface GameWonPopover : UIView{
    UILabel *_yourTimeLabel;
    UILabel *_bestTimeLabel;
}

@property (nonatomic,assign)BOOL isPopoverEnable;
@property (nonatomic,copy)void(^gameWonpopOverOption)(GamepopoverOption);
- (id)initWithView:(UIView *)view;
- (void)setScore:(int)yourScore bestScore:(int)bestScore;
- (void)showMenuView;
- (void)hideMenuView;
@end