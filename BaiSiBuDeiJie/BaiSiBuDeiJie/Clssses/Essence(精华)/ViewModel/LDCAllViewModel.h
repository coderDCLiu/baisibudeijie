//
//  LDCAllViewModel.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/25.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LDCTopicItem;

@interface LDCAllViewModel : NSObject

@property (strong, nonatomic) LDCTopicItem *ldcTopicItem;

@property (assign,nonatomic) CGRect topViewFrame;

@property (assign, nonatomic) CGRect middleFrame;

@property (assign, nonatomic) CGRect commentFrame;

@property (assign, nonatomic) CGRect bottomFrame;

@property (assign,nonatomic) CGFloat cellH;

@end
