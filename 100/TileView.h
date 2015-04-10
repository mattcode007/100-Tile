//
//  Tile.h
//  100
//
//  Created by apple on 24/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

typedef enum {
    TSBlank,
    TS10,
    TS20,
    TS30,
    TS40,
    TS50,
    TS60,
    TS70,
    TS80,
    TS90,
    TS100
}TileStyle;

#import <UIKit/UIKit.h>

@interface TileView : UIView{
    CGFloat     R,G,B,Alpha;
    UILabel     *_titleLabel;
}
@property (nonatomic,readwrite)TileStyle tileStyle;
- (id)initWithFrame:(CGRect)frame style:(TileStyle)style;
- (void)setNumber:(NSString *)txt;
@end
