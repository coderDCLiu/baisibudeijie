//
//  LDCAllCellBottomView.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/27.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCAllCellBottomView.h"
#import "LDCTopicItem.h"

@interface LDCAllCellBottomView ()

@property (weak, nonatomic) IBOutlet UIButton *dingButton;

@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation LDCAllCellBottomView

-(void)setLdcTopicItem:(LDCTopicItem *)ldcTopicItem
{
    [super setLdcTopicItem:ldcTopicItem];
    
    [self setUpButton:_dingButton count:ldcTopicItem.ding title:@"顶"];
    [self setUpButton:_caiButton count:ldcTopicItem.cai title:@"踩"];
    [self setUpButton:_shareButton count:ldcTopicItem.repost title:@"转发"];
    [self setUpButton:_commentButton count:ldcTopicItem.comment title:@"评论"];
    
}

-(void)setUpButton:(UIButton*)button count:(CGFloat)count title:(NSString*)title
{
    NSString *countStr = nil;
    if (count >= 10000) {
        count = count / 10000;
        countStr = [NSString stringWithFormat:@"%.1f",count];
    }else if (count < 10000) {
        countStr = [NSString stringWithFormat:@"%.0f",count];
    }
    countStr = [countStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    NSString *buttonTitle = [NSString stringWithFormat:@"%@%@",title,countStr];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
}

@end
