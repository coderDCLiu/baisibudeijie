//
//  LDCTopicCommentItem.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/27.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCTopicCommentItem.h"
#import "LDCTopicCommentUserItem.h"

@implementation LDCTopicCommentItem

-(NSString *)totalContent
{
    return [NSString stringWithFormat:@"%@:%@",_user.username,_content];
}


@end
