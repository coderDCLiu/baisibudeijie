//
//  LDCTopicCommentItem.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/27.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LDCTopicCommentUserItem;

@interface LDCTopicCommentItem : NSObject

@property (nonatomic, strong) NSString *voiceuri;
@property (nonatomic, strong) NSString *voicetime;
@property (nonatomic, strong) NSString *content;
@property (strong, nonatomic) LDCTopicCommentUserItem *user;

@property (strong, nonatomic) NSString *totalContent;


@end
