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
@property (strong, nonatomic) UIButton *playButton;

@end

@implementation LDCAllCellVoiceView


- (IBAction)playMusicClick:(UIButton *)sender {
    
    if (self.playButton == nil) {
       self.playButton = sender;
    }
    NSLog(@"%d",self.playButton == sender);
    
    if (!(self.playButton == sender)) {
        self.playButton.selected = NO;
        self.playButton = sender;
        NSLog(@"不同按钮");
    }
    
    
    sender.selected = !sender.isSelected;
    NSLog(@"按钮---%@",sender);
    if ([self.voiceurl isEqualToString:self.ldcTopicItem.voiceuri]) {
        
//        self.player = nil;
        NSLog(@"url不同");
        
    } else if (![self.voiceurl isEqualToString:self.ldcTopicItem.voiceuri]) {
        
        NSURL *url = [NSURL URLWithString:self.ldcTopicItem.voiceuri];
        self.voiceurl = self.ldcTopicItem.voiceuri;
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
        self.player = player;
        NSLog(@"创建%@",self.player);
    }
    
    
    if (sender.isSelected == 1) {
        
        [self.player play];
        NSLog(@"播放%@",self.player);

    } else if (sender.isSelected == 0){
    
        [self.player pause];
        NSLog(@"暂停%@",self.player);
    }
    
    
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
