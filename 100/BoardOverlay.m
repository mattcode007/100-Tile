//
//  BoardOverlay.m
//  100
//
//  Created by apple on 24/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import "BoardOverlay.h"

@implementation BoardOverlay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag=1001;
        CGFloat width=self.frame.size.width/kNumberOfTiles-4.0;
        CGFloat height=self.frame.size.width/kNumberOfTiles-4.0;
        CGFloat xOffSet=0.0;
        CGFloat yOffSet=0.0;
        for (int i=0; i<kNumberOfTiles; i++) {
            for (int j=0;j<kNumberOfTiles ; j++) {
                TileView *_tileView=[[TileView alloc]initWithFrame:CGRectMake(xOffSet+2.0, yOffSet+2.0, width, height) style:TSBlank];
                _tileView.tag=234;;
                [self addSubview:_tileView];
                xOffSet+=self.frame.size.width/kNumberOfTiles;
            }
            xOffSet=0.0;
            yOffSet+=self.frame.size.width/kNumberOfTiles;
        }
    }
    return self;
}
- (void)resetTiles{
    for (UIView *_subview in self.subviews) {
        if (_subview.tag<234) {
            [_subview removeFromSuperview];
            [_subview release];
            _subview=nil;
        }
    }
    [tileManager() reset];
    
    CGFloat width=self.frame.size.width/kNumberOfTiles-4.0;
    CGFloat height=self.frame.size.width/kNumberOfTiles-4.0;
    CGFloat xOffSet=0.0;
    CGFloat yOffSet=0.0;
    NSArray *_valuesArray=[NSArray arrayWithArray:kTilesArray];
    for (int i=0; i<kNumberOfTiles; i++) {
        for (int j=0;j<kNumberOfTiles ; j++) {
            NSString *_value=[_valuesArray objectAtIndex:arc4random()%_valuesArray.count];
            TileView *_tileView=[[TileView alloc]initWithFrame:CGRectMake(xOffSet+2.0, yOffSet+2.0, width, height) style:TS10];
            [_tileView setNumber:_value];
            [self addSubview:_tileView];
            _tileView.tag=i*kNumberOfTiles+j;
            xOffSet+=self.frame.size.width/kNumberOfTiles;
            
            Tile *_tile=[[Tile alloc]init];
            _tile.tag=i*kNumberOfTiles+j;
            _tile.value=[_value intValue];
            [tileManager().tilesArray addObject:_tile];
            
        }
        xOffSet=0.0;
        yOffSet+=self.frame.size.width/kNumberOfTiles;
    }
}

@end
