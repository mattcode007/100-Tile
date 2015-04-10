//
//  Tile.m
//  100
//
//  Created by apple on 24/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import "TileView.h"

@implementation TileView

- (id)initWithFrame:(CGRect)frame style:(TileStyle)style{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        _tileStyle=style;
     
        _titleLabel=[[UILabel alloc]initWithFrame:self.bounds];
        _titleLabel.tag=1002;
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.font=[UIFont fontWithName:@"Kreon-Bold" size:19.0];
        [self addSubview:_titleLabel];
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    [self getRGB];
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, R, G, B, Alpha);
    CGRect rrect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    CGFloat radius = 9.0;
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    CGContextClosePath(context);
    [[UIColor colorWithRed:R green:G blue:B alpha:Alpha] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}
-(void)getRGB{
    if (_tileStyle==TSBlank) {
        R=1.0;B=1.0;G=1.0;Alpha=1.0;
    }
    else if (_tileStyle==TS10){
         [k10Color getRed:&R green:&G blue:&B alpha:&Alpha];
    }
    else if (_tileStyle==TS20){
        [k20Color getRed:&R green:&G blue:&B alpha:&Alpha];
    }
    else if (_tileStyle==TS30){
         [k30Color getRed:&R green:&G blue:&B alpha:&Alpha];
    }
    else if (_tileStyle==TS40){
         [k40Color getRed:&R green:&G blue:&B alpha:&Alpha];
    }
    else if (_tileStyle==TS50){
         [k50Color getRed:&R green:&G blue:&B alpha:&Alpha];
    }
    else if (_tileStyle==TS60){
         [k60Color getRed:&R green:&G blue:&B alpha:&Alpha];
    }
    else if (_tileStyle==TS70){
         [k70Color getRed:&R green:&G blue:&B alpha:&Alpha];
    }
    else if (_tileStyle==TS80){
       [k80Color getRed:&R green:&G blue:&B alpha:&Alpha];
    }
    else if (_tileStyle==TS90){
        [k90Color getRed:&R green:&G blue:&B alpha:&Alpha];
    }
    else if (_tileStyle==TS100){
         [k100Color getRed:&R green:&G blue:&B alpha:&Alpha];
    }
}
- (void)setNumber:(NSString *)txt{
    _titleLabel.text=[NSString stringWithFormat:@"%@%%",txt];
    [self getStyle:[txt intValue]];
    [self setNeedsDisplay];
}
-(void)getStyle:(int)value{
    if (value==10)
        _tileStyle=TS10;
    else if (value==20)
        _tileStyle=TS20;
    else if (value==30)
        _tileStyle=TS30;
    else if (value==40)
        _tileStyle=TS40;
    else if (value==50)
        _tileStyle=TS50;
    else if (value==60)
        _tileStyle=TS60;
    else if (value==70)
        _tileStyle=TS70;
    else if (value==80)
        _tileStyle=TS80;
    else if (value==90)
        _tileStyle=TS90;
    else if (value==100)
        _tileStyle=TS100;
    else
        _tileStyle=TSBlank;
    
}
@end
