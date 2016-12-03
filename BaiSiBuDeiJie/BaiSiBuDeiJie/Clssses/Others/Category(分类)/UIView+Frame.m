//
//  UIView+Frame.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/16.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

//x
-(void)setLdc_x:(CGFloat)ldc_x
{
    CGRect frame = self.frame;
    frame.origin.x = ldc_x;
    self.frame = frame;
}
-(CGFloat)ldc_x
{
    return self.frame.origin.x;
}

//y
-(void)setLdc_y:(CGFloat)ldc_y
{
    CGRect frame = self.frame;
    frame.origin.y = ldc_y;
    self.frame = frame;
}
-(CGFloat)ldc_y
{
    return self.frame.origin.y;
}

//width
-(void)setLdc_width:(CGFloat)ldc_width
{
    CGRect frame = self.frame;
    frame.size.width = ldc_width;
    self.frame = frame;
}
-(CGFloat)ldc_width
{
    return self.frame.size.width;
}

//height
-(void)setLdc_height:(CGFloat)ldc_height
{
    CGRect frame = self.frame;
    frame.size.height = ldc_height;
    self.frame = frame;
}
-(CGFloat)ldc_height
{
    return self.frame.size.height;
}

//centerX
-(void)setLdc_centerX:(CGFloat)ldc_centerX
{
    CGPoint center = self.center;
    center.x = ldc_centerX;
    self.center = center;
}
-(CGFloat)ldc_centerX
{
    return self.center.x;
}

//centerY
-(void)setLdc_centerY:(CGFloat)ldc_centerY
{
    CGPoint center = self.center;
    center.y = ldc_centerY;
    self.center = center;
}
-(CGFloat)ldc_centerY
{
    return self.center.y;
}
@end
