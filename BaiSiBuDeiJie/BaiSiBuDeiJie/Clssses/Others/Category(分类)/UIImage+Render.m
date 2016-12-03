//
//  UIImage+Render.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/16.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)

+(UIImage*)imageWithOriginalImage:(NSString*)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *oriImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return oriImage;
}

@end
