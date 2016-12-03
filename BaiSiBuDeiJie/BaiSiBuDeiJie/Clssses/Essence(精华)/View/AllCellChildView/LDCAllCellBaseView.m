//
//  LDCAllCellBaseView.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/26.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCAllCellBaseView.h"

@implementation LDCAllCellBaseView

+(instancetype)viewForXib
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

@end
