//
//  LDCAllTableViewCell.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/25.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCAllTableViewCell.h"
#import "LDCTopicItem.h"

#import "LDCAllCellTopView.h"
#import "LDCAllCellMiddleView.h"
#import "LDCAllCellVideoView.h"
#import "LDCAllCellVoiceView.h"
#import "LDCAllCellCommentView.h"
#import "LDCAllCellBottomView.h"

#import "LDCAllViewModel.h"

@interface LDCAllTableViewCell ()

@property (weak,nonatomic) LDCAllCellTopView *ldcAllCellTopView;

@property (weak, nonatomic) LDCAllCellMiddleView *ldcAllCellMiddleView;

@property (weak, nonatomic) LDCAllCellVideoView *ldcAllCellVideoView;

@property (weak, nonatomic) LDCAllCellVoiceView *ldcAllCellVoiceView;

@property (weak, nonatomic) LDCAllCellCommentView *ldcAllCellCommentView;

@property (weak, nonatomic) LDCAllCellBottomView *ldcAllCellBottomView;

@end

@implementation LDCAllTableViewCell

-(void)setFrame:(CGRect)frame
{
    frame.origin.y += 10;
    frame.size.height -= 10;
    [super setFrame:frame];
}

//通过注册的方式创建的cell会调用这个方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        //1.添加上面顶部的topView
        LDCAllCellTopView *topView = [LDCAllCellTopView viewForXib];
        self.ldcAllCellTopView = topView;
        [self.contentView addSubview:topView];
        
        //2.添加中间的middleView
        LDCAllCellMiddleView *middleView = [LDCAllCellMiddleView viewForXib];
        self.ldcAllCellMiddleView = middleView;
        [self.contentView addSubview:middleView];
        
        //2.1添加视频播放的View
        LDCAllCellVideoView *videoView = [LDCAllCellVideoView viewForXib];
        self.ldcAllCellVideoView = videoView;
        [self.contentView addSubview:videoView];
        
        //2.2添加声音播放的View
        LDCAllCellVoiceView *voiceView = [LDCAllCellVoiceView viewForXib];
        self.ldcAllCellVoiceView = voiceView;
        [self.contentView addSubview:voiceView];
        
        //3.添加最热评论的View
        LDCAllCellCommentView *commentView = [LDCAllCellCommentView viewForXib];
        self.ldcAllCellCommentView = commentView;
        [self.contentView addSubview:commentView];
        
        //4.添加底部的View
        LDCAllCellBottomView *bottomView = [LDCAllCellBottomView viewForXib];
        self.ldcAllCellBottomView = bottomView;
        [self.contentView addSubview:bottomView];
        
        
    }
    return self;
}

-(void)setLdcAllViewModel:(LDCAllViewModel *)ldcAllViewModel
{
    _ldcAllViewModel = ldcAllViewModel;
    
    //处理topView
    self.ldcAllCellTopView.ldcTopicItem = ldcAllViewModel.ldcTopicItem;
    self.ldcAllCellTopView.frame = ldcAllViewModel.topViewFrame;
    
    //处理middleView
    if (ldcAllViewModel.ldcTopicItem.type == LDCTopicItemTypePicture) {
        
        _ldcAllCellMiddleView.ldcTopicItem = ldcAllViewModel.ldcTopicItem;
        
        _ldcAllCellMiddleView.frame = ldcAllViewModel.middleFrame;
        
        _ldcAllCellVideoView.hidden = YES;
        _ldcAllCellVoiceView.hidden = YES;
        _ldcAllCellMiddleView.hidden = NO;
    } else if (ldcAllViewModel.ldcTopicItem.type == LDCTopicItemTypeVideo){
    
        _ldcAllCellVideoView.ldcTopicItem = ldcAllViewModel.ldcTopicItem;
        
        _ldcAllCellVideoView.frame = ldcAllViewModel.middleFrame;
        
        _ldcAllCellMiddleView.hidden = YES;
        _ldcAllCellVoiceView.hidden = YES;
        _ldcAllCellVideoView.hidden = NO;
    } else if (ldcAllViewModel.ldcTopicItem.type == LDCTopicItemTypeVoice){
        
        _ldcAllCellVoiceView.ldcTopicItem = ldcAllViewModel.ldcTopicItem;
        
        _ldcAllCellVoiceView.frame = ldcAllViewModel.middleFrame;
        
        _ldcAllCellMiddleView.hidden = YES;
        _ldcAllCellVideoView.hidden = YES;
        _ldcAllCellVoiceView.hidden = NO;
    }else {
    
        _ldcAllCellMiddleView.hidden = YES;
        _ldcAllCellVideoView.hidden = YES;
        _ldcAllCellVoiceView.hidden = YES;
    }
    
    //处理commentView
    if (ldcAllViewModel.ldcTopicItem.commentItem) {
        
        _ldcAllCellCommentView.ldcTopicItem = ldcAllViewModel.ldcTopicItem;
        _ldcAllCellCommentView.frame = ldcAllViewModel.commentFrame;
        
        _ldcAllCellCommentView.hidden = NO;
        
    }else {
    
        _ldcAllCellCommentView.hidden = YES;
    }
    
    //处理底部bottomView
    _ldcAllCellBottomView.frame = ldcAllViewModel.bottomFrame;
    _ldcAllCellBottomView.ldcTopicItem = ldcAllViewModel.ldcTopicItem;
   
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
