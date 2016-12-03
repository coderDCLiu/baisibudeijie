//
//  UITextField+PlaceholderColor.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/22.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "UITextField+PlaceholderColor.h"

@implementation UITextField (PlaceholderColor)

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    if (self.placeholder.length == 0) {
        self.placeholder = @" ";
    }
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

-(UIColor *)placeholderColor
{
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    return placeholderLabel.textColor;
}

@end
