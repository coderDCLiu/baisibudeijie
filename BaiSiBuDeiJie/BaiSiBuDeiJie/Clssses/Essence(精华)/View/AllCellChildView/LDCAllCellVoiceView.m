//
//  LDCAllCellVoiceView.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/26.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCAllCellVoiceView.h"
#import "LDCTopicItem.h"
#import <AVFoundation/AVFoundation.h>

#import <UIImageView+WebCache.h>

@interface LDCAllCellVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLable;

@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) NSString *voiceurl;
@end

@implementation LDCAllCellVoiceView

-(AVPlayer*)player {
    
    
        NSURL *url = [NSURL URLWithString:self.ldcTopicItem.voiceuri];
//        self.voiceurl = self.ldcTopicItem.voiceuri;
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
        self.player = player;
    
        return self.player;
    
}
- (IBAction)playMusicClick:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    NSLog(@"%d",sender.isSelected);
//    sender.selected != sender.isSelected;
    
    [[UIScrollView alloc]init]
    
//    if (sender.selected == YES) {
//        
//        [self.player play];
//    } else {
//    
//        [self.player pause];
//    }
//    if (self.voiceurl != self.ldcTopicItem.voiceuri) {
//        
//        self.player = nil;
//    }
    
    NSLog(@"音乐播放%@",self.ldcTopicItem.voiceuri);
//    [self.player play];
}

-(void)setLdcTopicItem:(LDCTopicItem *)ldcTopicItem
{
    [super setLdcTopicItem:ldcTopicItem];
    
    [_voiceView sd_setImageWithURL:[NSURL URLWithString:ldcTopicItem.image0]];
    
    NSUInteger second = ldcTopicItem.voicetime % 60;
    NSUInteger minute = ldcTopicItem.voicetime / 60;
    _playTimeLable.text = [NSString stringWithFormat:@"%02ld:%02ld",minute,second];
    
    CGFloat count = [ldcTopicItem.playcount floatValue];
    NSString *countStr = nil;
    if (count >= 10000) {
        count = count / 1000.0;
        countStr = [NSString stringWithFormat:@"%.1f万次播放",count];
    }else if (count < 10000) {
    
        countStr = [NSString stringWithFormat:@"%f次播放",count];
    }
    countStr = [countStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    _playCountLabel.text = countStr;
    
    
    
}

@end
