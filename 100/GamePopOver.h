//
//  GamePopOver.h
//  100
//
//  Created by GP on 27/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//
typedef enum {
    GONewGame,
    GOInstruction,
    GOExit
}GamepopoverOption;

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
@interface GamePopOver : UIView{
    UILabel *_numberOfTileLbl;
    UILabel *_penalityMinsLbl;
    UILabel *_yourTimeLabel;
    UILabel *_finalTimeLabel;
    UILabel *_bestTimeLabel;
}
@property (nonatomic,assign)BOOL isPopoverEnable;
@property (nonatomic,copy)void(^gamepopOverOption)(GamepopoverOption);
- (id)initWithView:(UIView *)view;
- (void)setScore:(int)score;
- (void)setscore:(int)score bestScore:(int)bestScore numberOfMissingTiles:(int)numberOfMissingTiles;
- (void)showMenuView;
- (void)hideMenuView;
@end
