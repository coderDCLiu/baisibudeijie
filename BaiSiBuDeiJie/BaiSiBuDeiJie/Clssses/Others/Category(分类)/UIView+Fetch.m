//
//  UIView+Fetch.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 2016/10/31.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "UIView+Fetch.h"

@implementation UIView (Fetch)

-(UITableView*)fetchTableView
{
    for (UIView *childView in self.subviews) {
        if ([childView isKindOfClass:[UITableView class]]) {
            return (UITableView*)childView;
        }
        UITableView *tableView = [childView fetchTableView];
        if (tableView) {
            return tableView;
        }
    }
    return nil;
}

@end
