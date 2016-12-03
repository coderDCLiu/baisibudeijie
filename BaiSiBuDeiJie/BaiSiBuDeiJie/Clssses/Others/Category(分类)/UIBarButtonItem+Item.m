//
//  UIBarButtonItem+Item.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/16.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+(instancetype)barButtonItemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc]initWithFrame:button.bounds];
    [view addSubview:button];
    return [[UIBarButtonItem alloc]initWithCustomView:view];
}

+(instancetype)barButtonItemWithImage:(UIImage *)image hightLightImage:(UIImage *)hightLightImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:hightLightImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc]initWithFrame:button.bounds];
    [view addSubview:button];
    return [[UIBarButtonItem alloc]initWithCustomView:view];
}

@end
