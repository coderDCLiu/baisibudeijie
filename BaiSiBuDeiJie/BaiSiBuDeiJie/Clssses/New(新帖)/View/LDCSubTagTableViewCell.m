//
//  LDCSubTagTableViewCell.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/20.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCSubTagTableViewCell.h"
#import "LDCSubTagItem.h"
#import <UIImageView+WebCache.h>

@interface LDCSubTagTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *subImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation LDCSubTagTableViewCell

-(void)setFrame:(CGRect)frame
{
//    NSLog(@"%@",NSStringFromCGRect(frame));

    frame.size.height -= 1;
    
    [super setFrame:frame];
}

-(void)setLdcSubTagItem:(LDCSubTagItem *)ldcSubTagItem
{
    _ldcSubTagItem = ldcSubTagItem;
    
    self.themeLabel.text = ldcSubTagItem.theme_name;
    
    //处理头像
    
    [self.subImageView sd_setImageWithURL:[NSURL URLWithString:ldcSubTagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //1.开启图形上下文
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //2.描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //3.裁剪图片
        [path addClip];
        //4.绘图
        [image drawAtPoint:CGPointZero];
        //5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        //6.关闭图形上下文
        UIGraphicsEndImageContext();
        
        self.subImageView.image = image;
    }];
    
    //处理订阅数字
    CGFloat count = [ldcSubTagItem.sub_number floatValue];
    NSString *countStr = [NSString stringWithFormat:@"%@人订阅",ldcSubTagItem.sub_number];
    if (count > 10000) {
        count = count / 10000;
        countStr = [NSString stringWithFormat:@"%.1f万人订阅",count];
        countStr = [countStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    self.countLabel.text = countStr;
}

+(instancetype)ldcSubTagCell
{
    return [[[NSBundle mainBundle]loadNibNamed:@"LDCSubTagTableViewCell" owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
