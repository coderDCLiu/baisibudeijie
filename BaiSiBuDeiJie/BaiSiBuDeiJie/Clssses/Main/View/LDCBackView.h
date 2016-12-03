//
//  LDCBackView.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/17.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCBackView : UIView

+(instancetype)backViewWithImage:(UIImage*)image hightLightImage:(UIImage*)hightLightImage title:(NSString*)title target:(id)target action:(SEL)action;

@end
