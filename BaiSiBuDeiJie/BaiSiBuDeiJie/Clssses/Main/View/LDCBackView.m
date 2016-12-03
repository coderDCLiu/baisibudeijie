//
//  LDCBackView.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/17.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCBackView.h"

@implementation LDCBackView

+(instancetype)backViewWithImage:(UIImage*)image hightLightImage:(UIImage*)hightLightImage title:(NSString*)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:hightLightImage forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    LDCBackView *backView = [[LDCBackView alloc]initWithFrame:button.bounds];
    [backView addSubview:button];
    return backView;
}

@end
