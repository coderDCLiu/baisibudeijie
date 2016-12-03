//
//  LDCAllCellTopView.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/25.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCAllCellTopView.h"
#import "LDCTopicItem.h"

#import <UIImageView+WebCache.h>
#import "NSDate+Date.h"

@interface LDCAllCellTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation LDCAllCellTopView

- (IBAction)moreClick:(id)sender {
    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
//    
//    [actionSheet showInView:self];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:0];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    [alert addAction:action];
    [alert addAction:action1];
    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [vc presentViewController:alert animated:YES completion:nil];
    
    
}

-(void)setLdcTopicItem:(LDCTopicItem *)ldcTopicItem
{
    [super setLdcTopicItem:ldcTopicItem];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:ldcTopicItem.profile_image]];
    
    self.nameLabel.text = ldcTopicItem.name;
    
    self.textLabel.text = ldcTopicItem.text;
    
    self.createTimeLabel.text = [self timeStringWithCreateTime:ldcTopicItem.create_time];
    
}

-(NSString*)timeStringWithCreateTime:(NSString*)creatTime
{
    NSString *timeStr = creatTime;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createData = [formatter dateFromString:timeStr];
    
    NSDateComponents *components = [createData datelWithNow];
    
    if ([createData isThisYear]) {
        
        if ([createData isThisDay]) {
            
            if (components.hour >= 1) {
                
                timeStr = [NSString stringWithFormat:@"%ld小时前",components.hour];
                
            }else if (components.minute >= 1) {
                
                timeStr = [NSString stringWithFormat:@"%ld分钟前",components.minute];
            
            }else {
            
                timeStr = @"刚刚";
            }
        
        } else if ([createData isYesterday]) {
        
            formatter.dateFormat = @"昨天 HH:mm";
            timeStr = [formatter stringFromDate:createData];
        
        } else {
            
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            timeStr = [formatter stringFromDate:createData];
            
        }
        
    }
    
    
    return timeStr;
}

@end
