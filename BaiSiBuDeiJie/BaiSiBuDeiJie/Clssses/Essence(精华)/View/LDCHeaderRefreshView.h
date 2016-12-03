//
//  LDCHeaderRefreshView.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/30.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCHeaderRefreshView : UIView

@property (assign, nonatomic) BOOL isNeedLoad;

@property (assign, nonatomic) BOOL isRefresh;

+(instancetype)ldcHeaderRefreshView;

@end
