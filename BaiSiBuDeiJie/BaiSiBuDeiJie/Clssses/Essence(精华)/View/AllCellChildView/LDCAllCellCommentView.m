//
//  LDCAllCellCommentView.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/27.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCAllCellCommentView.h"
#import "LDCTopicItem.h"
#import "LDCTopicCommentItem.h"
#import "LDCTopicCommentUserItem.h"

@interface LDCAllCellCommentView ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceCommentButton;

@end

@implementation LDCAllCellCommentView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setLdcTopicItem:(LDCTopicItem *)ldcTopicItem
{
    [super setLdcTopicItem:ldcTopicItem];
    
    if (ldcTopicItem.commentItem.content.length) {
        
        _voiceView.hidden = YES;
        _contentLabel.hidden = NO;
        
        _contentLabel.text = ldcTopicItem.commentItem.totalContent;
        
    } else {
        
        _contentLabel.hidden = YES;
        _voiceView.hidden = NO;
        
        _userNameLabel.text = ldcTopicItem.commentItem.user.username;
        
        NSUInteger voiceTime = [ldcTopicItem.commentItem.voicetime integerValue];
        
        NSUInteger second = voiceTime % 60;
        NSUInteger minute = voiceTime / 60;
        
        [_voiceCommentButton setTitle:[NSString stringWithFormat:@"%ld'%ld''",minute,second] forState:UIControlStateNormal];
        
       
    }
}

@end
