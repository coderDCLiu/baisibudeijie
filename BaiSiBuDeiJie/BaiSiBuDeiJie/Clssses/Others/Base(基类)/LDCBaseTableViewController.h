//
//  LDCBaseTableViewController.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/31.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCTopicItem.h"

@interface LDCBaseTableViewController : UITableViewController

@property (strong,nonatomic) NSNumber *type;

-(void)reload;

@end
