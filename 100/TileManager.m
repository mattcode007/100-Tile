//
//  TileManager.m
//  100
//
//  Created by GP on 25/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import "TileManager.h"

@implementation TileManager

static TileManager * _sharedTileManager = nil;

#pragma mark----------------------------
#pragma Singleton

+ (TileManager *)tileManagerSingleton{
    @synchronized([TileManager class]){
		if (!_sharedTileManager){
            [[self alloc] init];
        }
		return _sharedTileManager;
	}
	return nil;
}
+(id)alloc{
	@synchronized([TileManager class]){
		_sharedTileManager = [super alloc];
		return _sharedTileManager;
	}
	return nil;
}
- (id)autorelease {
    return self;
}
-(id)init{
    if ([super init]) {
        _tilesArray=[[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark----------------------------
#pragma Operations

- (void)reset{
    [_tilesArray removeAllObjects];
    _topValue       =0.0;
    _bottomValue    =0.0;
    _leftValue      =0.0;
    _rightValue     =0.0;
    _selectedValue  =0.0;
}

- (void)updateDataWithRespectToTile:(TileView *)tileView{
    NSMutableArray *_tmpTileArray=[NSMutableArray arrayWithArray:_tilesArray];
    [_tmpTileArray filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        Tile *_tile=(Tile *) evaluatedObject;
        return (_tile.tag==tileView.tag);
    }]];
    if (_tmpTileArray.count>0) {
        Tile *_tile=(Tile *)[_tmpTileArray objectAtIndex:0];
        _selectedValue=_tile.value;
       
        NSInteger horizontalTileIndex=_tile.tag%kNumberOfTiles;
        NSInteger verticalTileIndex=_tile.tag/kNumberOfTiles;
        NSInteger _factor=kNumberOfTiles;
        NSInteger bottomIndex=((verticalTileIndex+1)*_factor)+horizontalTileIndex;
        NSInteger topIndex   =((verticalTileIndex-1)*_factor)+horizontalTileIndex;
        if (topIndex<0)
            topIndex=kNumberOfTiles *kNumberOfTiles+10;
        
        NSInteger leftIndex=horizontalTileIndex-1;
        NSInteger rightIndex=horizontalTileIndex+1;
        if (leftIndex<0)
            leftIndex=kNumberOfTiles *kNumberOfTiles+10;
        else
            leftIndex=_tile.tag-1;
        
        if (rightIndex>=kNumberOfTiles)
            rightIndex=kNumberOfTiles *kNumberOfTiles+10;
        else
            rightIndex=_tile.tag+1;
        
        _bottomViewTag  =bottomIndex;
        _topViewTag     =topIndex;
        _leftViewTag    =leftIndex;
        _rightViewTag   =rightIndex;

        if (topIndex<kNumberOfTiles *kNumberOfTiles) {
            NSMutableArray *_tmpTileArray=[NSMutableArray arrayWithArray:_tilesArray];
            [_tmpTileArray filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                Tile *_tile=(Tile *) evaluatedObject;
                return (_tile.tag==topIndex);
            }]];
            if (_tmpTileArray.count>0) {
                Tile *_tile=(Tile *)[_tmpTileArray objectAtIndex:0];
                _topValue=_tile.value;
            }
        }
        else
            _topValue=0.0;
        
        if (bottomIndex<kNumberOfTiles *kNumberOfTiles) {
            NSMutableArray *_tmpTileArray=[NSMutableArray arrayWithArray:_tilesArray];
            [_tmpTileArray filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                Tile *_tile=(Tile *) evaluatedObject;
                return (_tile.tag==bottomIndex);
            }]];
            if (_tmpTileArray.count>0) {
                Tile *_tile=(Tile *)[_tmpTileArray objectAtIndex:0];
                _bottomValue=_tile.value;
            }
        }
        else
            _bottomValue=0.0;
        
        if (rightIndex<kNumberOfTiles *kNumberOfTiles) {
            NSMutableArray *_tmpTileArray=[NSMutableArray arrayWithArray:_tilesArray];
            [_tmpTileArray filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                Tile *_tile=(Tile *) evaluatedObject;
                return (_tile.tag==rightIndex);
            }]];
            if (_tmpTileArray.count>0) {
                Tile *_tile=(Tile *)[_tmpTileArray objectAtIndex:0];
                _rightValue=_tile.value;
            }
        }
        else
            _rightValue=0.0;
        if (leftIndex<kNumberOfTiles *kNumberOfTiles) {
            NSMutableArray *_tmpTileArray=[NSMutableArray arrayWithArray:_tilesArray];
            [_tmpTileArray filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                Tile *_tile=(Tile *) evaluatedObject;
                return (_tile.tag==leftIndex);
            }]];
            if (_tmpTileArray.count>0) {
                Tile *_tile=(Tile *)[_tmpTileArray objectAtIndex:0];
                _leftValue=_tile.value;
            }
        }
        else
            _leftValue=0.0;

    }
}
- (void)updateArrayAtIndex:(int)index withValue:(int)value{
    NSMutableArray *_tmpTileArray=[NSMutableArray arrayWithArray:_tilesArray];
    [_tmpTileArray filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        Tile *_tile=(Tile *) evaluatedObject;
        return (_tile.tag==index);
    }]];
    if (_tmpTileArray.count>0) {
        NSInteger index=[_tilesArray indexOfObject:[_tmpTileArray objectAtIndex:0]];
        if (index<_tilesArray.count) {
            Tile *_tile=(Tile *)[_tilesArray objectAtIndex:index];
            _tile.value=value;
        }
    }
   
}
-(void)checkGameStatus{
    BOOL _gameOver=NO;
    for (Tile *_tile in _tilesArray) {
        NSInteger horizontalTileIndex=_tile.tag%kNumberOfTiles;
        NSInteger verticalTileIndex=_tile.tag/kNumberOfTiles;
        NSInteger _factor=kNumberOfTiles;
        NSInteger bottomIndex=((verticalTileIndex+1)*_factor)+horizontalTileIndex;
        NSInteger rightIndex=horizontalTileIndex+1;
        if (rightIndex>=kNumberOfTiles)
            rightIndex=kNumberOfTiles *kNumberOfTiles+10;
        else
            rightIndex=_tile.tag+1;
        
        if (bottomIndex<kNumberOfTiles *kNumberOfTiles) {
            NSMutableArray *_tmpTileArray=[NSMutableArray arrayWithArray:_tilesArray];
            [_tmpTileArray filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                Tile *_tile=(Tile *) evaluatedObject;
                return (_tile.tag==bottomIndex);
            }]];
            if (_tmpTileArray.count>0) {
                Tile *_bottomTile=(Tile *)[_tmpTileArray objectAtIndex:0];
                if(_bottomTile.value+_tile.value<=kMaximunTileLimit){
                    _gameOver=NO;
                    break;
                }
                else
                    _gameOver=YES;
                   
            }
        }
        
        if (rightIndex<kNumberOfTiles *kNumberOfTiles) {
            NSMutableArray *_tmpTileArray=[NSMutableArray arrayWithArray:_tilesArray];
            [_tmpTileArray filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
                Tile *_tile=(Tile *) evaluatedObject;
                return (_tile.tag==rightIndex);
            }]];
            if (_tmpTileArray.count>0) {
                Tile *_rightTile=(Tile *)[_tmpTileArray objectAtIndex:0];
                if(_rightTile.value+_tile.value<=kMaximunTileLimit){
                    _gameOver=NO;
                    break;
                }
                else
                    _gameOver=YES;
                
            }
        }
    }
    if (_gameOver) {
        BOOL Won=NO;
        NSMutableArray *_tmpTileArray=[NSMutableArray arrayWithArray:_tilesArray];
        [_tmpTileArray filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            Tile *_tile=(Tile *) evaluatedObject;
            return (_tile.value==kMaximunTileLimit);
        }]];
        if (_tmpTileArray.count+2>=(kNumberOfTiles *kNumberOfTiles)) {
            NSSet *set1 = [NSSet setWithArray:_tmpTileArray];
            NSMutableSet *set2 = [NSMutableSet setWithArray:_tilesArray];
            [set2 minusSet:set1];
            if ([set2 allObjects].count==1) {
                Won=YES;
            }
            else if([set2 allObjects].count==2){
                NSArray  *_objects=[set2 allObjects];
                Tile *_tile1=(Tile *) [_objects objectAtIndex:0];
                Tile *_tile2=(Tile *) [_objects objectAtIndex:1];
               
                NSInteger horizontalTileIndex=_tile1.tag%kNumberOfTiles;
                NSInteger verticalTileIndex=_tile1.tag/kNumberOfTiles;
                NSInteger _factor=kNumberOfTiles;
                NSInteger bottomIndex=((verticalTileIndex+1)*_factor)+horizontalTileIndex;
                NSInteger topIndex   =((verticalTileIndex-1)*_factor)+horizontalTileIndex;
                if (topIndex<0)
                    topIndex=kNumberOfTiles *kNumberOfTiles+10;
                
                NSInteger leftIndex=horizontalTileIndex-1;
                NSInteger rightIndex=horizontalTileIndex+1;
                if (leftIndex<0)
                    leftIndex=kNumberOfTiles *kNumberOfTiles+10;
                else
                    leftIndex=_tile1.tag-1;
                
                if (rightIndex>=kNumberOfTiles)
                    rightIndex=kNumberOfTiles *kNumberOfTiles+10;
                else
                    rightIndex=_tile1.tag+1;
                
                if (bottomIndex==_tile2.tag||topIndex==_tile2.tag||rightIndex==_tile2.tag||leftIndex==_tile2.tag) {
                    Won=YES;
                }
                
            }
        }
        if(_gameOverCallBack)
            _gameOverCallBack(_tmpTileArray.count,Won);
    }
}
@end
TileManager *tileManager(void){
    return [TileManager tileManagerSingleton];
}