//
//  LDCAllCellBaseView.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/26.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDCTopicItem;

@interface LDCAllCellBaseView : UIView

@property (strong, nonatomic) LDCTopicItem *ldcTopicItem;

+(instancetype)viewForXib;

@end
