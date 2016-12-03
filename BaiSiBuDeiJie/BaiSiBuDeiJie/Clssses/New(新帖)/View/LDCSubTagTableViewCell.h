//
//  LDCSubTagTableViewCell.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/20.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDCSubTagItem;

@interface LDCSubTagTableViewCell : UITableViewCell

@property (strong, nonatomic) LDCSubTagItem *ldcSubTagItem;

+(instancetype)ldcSubTagCell;

@end
