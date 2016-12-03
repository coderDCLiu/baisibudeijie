//
//  UIBarButtonItem+Item.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/16.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

+(instancetype)barButtonItemWithImage:(UIImage*)image hightLightImage:(UIImage*)hightLightImage target:(id)target action:(SEL)action;

+(instancetype)barButtonItemWithImage:(UIImage*)image selectedImage:(UIImage*)selectedImage target:(id)target action:(SEL)action;

@end
