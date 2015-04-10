//
//  MenuView.h
//  100
//
//  Created by GP on 27/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//
#import <Social/Social.h>
#import <Accounts/Accounts.h>
typedef enum {
    MOResume,
    MONewGame,
    MOInstruction,
    MOExit
}MenuOption;


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MenuView : UIView
- (id)initWithView:(UIView *)view;
-(void)showMenuView;
-(void)hideMenuView;
@property (nonatomic,copy)void(^menuOption)(MenuOption);
@end

