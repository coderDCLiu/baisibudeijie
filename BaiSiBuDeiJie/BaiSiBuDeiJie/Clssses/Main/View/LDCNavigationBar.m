//
//  LDCNavigationBar.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/17.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCNavigationBar.h"
#import "LDCBackView.h"

@implementation LDCNavigationBar

-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        if ( [view isKindOfClass:[LDCBackView class]]) {
            view.ldc_x = 0;
        }
    }
}

@end
