//
//  LDCLoginTextField.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/22.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCLoginTextField.h"
#import "UITextField+PlaceholderColor.h"

@implementation LDCLoginTextField

-(void)awakeFromNib
{
    self.tintColor = [UIColor whiteColor];
    
    
    //设置占位文字的颜色
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    NSAttributedString *str = [[NSAttributedString alloc]initWithString:self.placeholder attributes:dict];
//    
//    self.attributedPlaceholder = str;
    
    self.placeholderColor = [UIColor lightGrayColor];
    
}

-(BOOL)becomeFirstResponder
{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    NSAttributedString *str = [[NSAttributedString alloc]initWithString:self.placeholder attributes:dict];
//    
//    self.attributedPlaceholder = str;
    
    self.placeholderColor = [UIColor whiteColor];
    
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder
{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    NSAttributedString *str = [[NSAttributedString alloc]initWithString:self.placeholder attributes:dict];
//    
//    self.attributedPlaceholder = str;
    
    self.placeholderColor = [UIColor lightGrayColor];
    
    return [super resignFirstResponder];
}

@end
