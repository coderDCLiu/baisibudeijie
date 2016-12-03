//
//  LDCRecommandCell.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 2016/11/1.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCRecommandCell.h"
#import "LDCRecommandItem.h"
#import <UIImageView+WebCache.h>

@interface LDCRecommandCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation LDCRecommandCell

-(void)setRecommandItem:(LDCRecommandItem *)recommandItem
{
    _recommandItem = recommandItem;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:recommandItem.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIGraphicsBeginImageContext(image.size);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        
        [path addClip];
        
        [image drawAtPoint:CGPointZero];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        _iconImageView.image = image;
    }];
    
    _nameLabel.text = recommandItem.screen_name;
    
    CGFloat count = [recommandItem.fans_count floatValue];
    NSString *str;
    if (count >= 10000) {
        count = count / 10000.0;
        str = [NSString stringWithFormat:@"%.1f万人关注",count];
    } else if (count < 10000) {
        str = [NSString stringWithFormat:@"%.0f万人关注",count];
    }
    str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    
    _countLabel.text = str;
    
    
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
