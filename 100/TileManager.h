//
//  TileManager.h
//  100
//
//  Created by GP on 25/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TileView.h"
#import "Tile.h"

@interface TileManager : NSObject

@property(nonatomic, retain) NSMutableArray *tilesArray;
@property(nonatomic, assign) float   topValue;
@property(nonatomic, assign) float   bottomValue;
@property(nonatomic, assign) float   rightValue;
@property(nonatomic, assign) float   leftValue;
@property(nonatomic, assign) float   selectedValue;

@property(nonatomic, assign) NSInteger leftViewTag;
@property(nonatomic, assign) NSInteger rightViewTag;
@property(nonatomic, assign) NSInteger bottomViewTag;
@property(nonatomic, assign) NSInteger topViewTag;
@property(nonatomic, copy) void(^gameOverCallBack)(int,BOOL);

+ (TileManager *)tileManagerSingleton;
- (void)reset;
- (void)updateDataWithRespectToTile:(TileView *)tileView;
- (void)updateArrayAtIndex:(int)index withValue:(int)value;
- (void)checkGameStatus;
@end
TileManager *tileManager(void);
