//
//  LDCAllCellMiddleView.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/26.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCAllCellMiddleView.h"
#import "LDCTopicItem.h"
#import <DALabeledCircularProgressView.h>
#import "LDCSeeBigPictureController.h"

#import <UIImageView+WebCache.h>


@interface LDCAllCellMiddleView ()

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *loadView;

@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;

@property (weak, nonatomic) IBOutlet UIButton *readButton;

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@end

@implementation LDCAllCellMiddleView


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LDCSeeBigPictureController *seeBigPictureC = [[LDCSeeBigPictureController alloc]init];
    seeBigPictureC.ldcTopItem = self.ldcTopicItem;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigPictureC animated:YES completion:nil];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _loadView.progressTintColor = [UIColor whiteColor];
    _loadView.trackTintColor = [UIColor lightGrayColor];
    _loadView.roundedCorners = 5;
    
    _loadView.progressLabel.textColor = [UIColor lightGrayColor];
    
}

-(void)setLdcTopicItem:(LDCTopicItem *)ldcTopicItem
{
    [super setLdcTopicItem:ldcTopicItem];
    
    _loadView.progress = 0;
    _loadView.progressLabel.text = @"0%";
    
    //检查沙盒中有没有相应的图片
    NSString *fileName = [ldcTopicItem.image0 stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:data];
    
    if (image) {
        ldcTopicItem.localImage = image;
        _middleImageView.image = image;
    } else {
        
        [_middleImageView sd_setImageWithURL:[NSURL URLWithString:ldcTopicItem.image0] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            if (expectedSize == -1) return ;
            
            CGFloat progress = 1.0 * receivedSize / expectedSize;
            
            NSString *str = [NSString stringWithFormat:@"%.0f%%",progress *100];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _loadView.progressLabel.text = str;
                
                [_loadView setProgress:progress animated:YES];
                
            });
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image.size.height < 10000) return ;
            
            //对大图进行处理
            CGFloat imageW = LDCScreenW - 20;
            CGFloat imageH = imageW / image.size.width * image.size.height;
            
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            
            [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            _middleImageView.image = newImage;
            
            //保存到沙盒中
            NSString *fileName = [ldcTopicItem.image0 stringByReplacingOccurrencesOfString:@"/" withString:@""];
            NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
            
            NSData *data = UIImagePNGRepresentation(newImage);
            
            [data writeToFile:filePath atomically:YES];
            
        }];
    
    }
    
 
    
    
    
    _gifImageView.hidden = !ldcTopicItem.is_gif;
    
    //对大图做处理
    _readButton.hidden = !ldcTopicItem.isBigPicture;
    if (ldcTopicItem.isBigPicture) {
        
        _middleImageView.contentMode = UIViewContentModeTop;
        _middleImageView.clipsToBounds = YES;
        
    }else {
    
        _middleImageView.contentMode = UIViewContentModeScaleToFill;
        _middleImageView.clipsToBounds = NO;
    }
    
}
@end
