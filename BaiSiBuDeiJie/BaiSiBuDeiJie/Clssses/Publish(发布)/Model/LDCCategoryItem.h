//
//  LDCCategoryItem.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 2016/11/1.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDCCategoryItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSMutableArray *user;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) NSUInteger total_page;

@end
