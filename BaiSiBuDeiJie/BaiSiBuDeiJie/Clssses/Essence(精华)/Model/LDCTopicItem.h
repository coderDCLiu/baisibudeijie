//
//  LDCTopicItem.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/25.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LDCTopicCommentItem;

typedef enum : NSUInteger {
    LDCTopicItemTypeAll = 1,
    LDCTopicItemTypePicture = 10,
    LDCTopicItemTypeVideo = 41,
    LDCTopicItemTypeVoice = 31,
    LDCTopicItemTypeText = 29
} LDCTopicItemType;

@interface LDCTopicItem : NSObject

//topView的模型
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *text;
@property (strong,nonatomic) NSString *create_time;
@property (strong,nonatomic) NSString *profile_image;

//middleView的模型
@property (strong,nonatomic) NSString *image0;
@property (assign,nonatomic) BOOL is_gif;
@property (assign,nonatomic) BOOL isBigPicture;
@property (assign,nonatomic) CGFloat width;
@property (assign,nonatomic) CGFloat height;
@property (assign,nonatomic) LDCTopicItemType type;

@property (strong, nonatomic) UIImage *localImage;

//middleView中的视频
@property (nonatomic, strong) NSString *videouri;
@property (nonatomic, assign) NSInteger videotime;
@property (nonatomic, strong) NSString *playcount;

//middleView中的声音
@property (nonatomic, strong) NSString *voiceuri;
@property (nonatomic, assign) NSInteger voicetime;

//最热评论
@property (strong, nonatomic) NSArray *top_cmt;
@property (strong, nonatomic) LDCTopicCommentItem *commentItem;

//最底部的点赞评论条
@property (nonatomic, assign) CGFloat cai;
@property (nonatomic, assign) CGFloat ding;
@property (nonatomic, assign) CGFloat comment;
@property (nonatomic, assign) CGFloat repost;


@end
