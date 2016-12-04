//
//  LDCCenterTitleBtn.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 2016/12/3.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCCenterTitleBtn : UIButton

//图片名称
@property (nonatomic, copy) NSString *imageName;
//标题
@property (nonatomic, copy) NSString *title;

+ (instancetype)centerTitleBtnWithImageName:(NSString *)imageN titleName:(NSString *)title;


@end
