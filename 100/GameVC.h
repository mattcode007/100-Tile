//
//  GameVC.h
//  100
//
//  Created by apple on 24/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

typedef enum {
    TDTop,
    TDBottom,
    TDLeft,
    TDRight
}TileDirection;

#import <UIKit/UIKit.h>
#import "BoardOverlay.h"
#import "MenuView.h"
#import "GamePopOver.h"
#import <AudioToolbox/AudioToolbox.h>
#import "GameWonPopover.h"
#import "InstructionsVC.h"
#import <iAd/iAd.h>
#import "GADRequest.h"
#import "GADBannerView.h"
#import "Constant.h"
#import <GameKit/GameKit.h>
#import <VungleSDK/VungleSDK.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
@interface GameVC : UIViewController<ADBannerViewDelegate,GADBannerViewDelegate>{
    BoardOverlay *_boardOverlay;
    TileView     *_selectedTile;
    CGRect       _initialRect;
    TileDirection _direction;
    
    TileView      *_numberTile;
    int            _lastShownValue;
    
    UILabel       *_scoreLabel;
    UILabel       *_bestLabel;
    int            _score;
    MenuView      *_menuView;
    GamePopOver   *_gamePopover;
    GameWonPopover *_gameWonPopover;
    int            _bestScore;
    NSTimer        *_timer;
    ADBannerView    *_iAdBanner;
    GADBannerView   *_adMobBanner;
    int              _gameOverCount;
    int              _maxGameCount;

}
@end
