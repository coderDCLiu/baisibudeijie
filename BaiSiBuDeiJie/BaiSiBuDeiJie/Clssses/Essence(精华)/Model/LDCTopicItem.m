//
//  LDCTopicItem.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/25.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCTopicItem.h"
#import "LDCTopicCommentItem.h"

#import <MJExtension.h>

@implementation LDCTopicItem

-(void)setTop_cmt:(NSArray *)top_cmt
{
    _top_cmt = top_cmt;
    
    if (top_cmt.count) {
        
        NSDictionary *dict = top_cmt.firstObject;
        
        _commentItem = [LDCTopicCommentItem mj_objectWithKeyValues:dict];
        
    }
}

@end
