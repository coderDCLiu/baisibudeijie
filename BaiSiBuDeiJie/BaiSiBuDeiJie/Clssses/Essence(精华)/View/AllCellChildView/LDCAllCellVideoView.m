//
//  LDCAllCellVideoView.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/26.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCAllCellVideoView.h"
#import "LDCTopicItem.h"

#import <UIImageView+WebCache.h>

@interface LDCAllCellVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@end

@implementation LDCAllCellVideoView
- (IBAction)playVideoClick:(UIButton *)sender {
    
    NSLog(@"播放视频%@",self.ldcTopicItem.videouri);
     
}

-(void)setLdcTopicItem:(LDCTopicItem *)ldcTopicItem
{
    [super setLdcTopicItem:ldcTopicItem];
    
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:ldcTopicItem.image0]];
    
    NSUInteger second = ldcTopicItem.videotime % 60;
    NSUInteger minute = ldcTopicItem.videotime / 60;
    _playTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",minute,second];
    
    CGFloat count = [ldcTopicItem.playcount floatValue];
    NSString *countStr = nil;
    if (count >= 10000) {
        count = count / 10000.0;
        countStr = [NSString stringWithFormat:@"%.1f万次播放",count];
    }else if (count < 10000) {
        
        countStr = [NSString stringWithFormat:@"%d次播放",(int)count];
    }
    countStr = [countStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    _playCountLabel.text = countStr;
}

@end
