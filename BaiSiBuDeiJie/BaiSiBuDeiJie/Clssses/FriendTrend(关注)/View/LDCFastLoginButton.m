//
//  LDCFastLoginButton.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/22.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCFastLoginButton.h"


@implementation LDCFastLoginButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.ldc_centerX = self.frame.size.width * 0.5;
    self.imageView.ldc_y = 3;
    
    //设置中心点之前一定要先设置尺寸
    [self.titleLabel sizeToFit];
    self.titleLabel.ldc_centerX = self.frame.size.width * 0.5;
    self.titleLabel.ldc_y = self.ldc_height - self.titleLabel.ldc_height;
    
}

@end
