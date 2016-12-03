//
//  LDCLoginRegisterView.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/21.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCLoginRegisterView.h"

@interface LDCLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LDCLoginRegisterView

+(instancetype)ldcLoginView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"LDCLoginRegisterView" owner:nil options:nil]firstObject];
}

+(instancetype)ldcRegisterView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"LDCLoginRegisterView" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImage *image = self.loginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    
}

@end
