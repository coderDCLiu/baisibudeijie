//
//  LDCMeCollectionViewCell.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/22.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCMeCollectionViewCell.h"
#import "LDCMeItem.h"

#import <UIImageView+WebCache.h>

@interface LDCMeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LDCMeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setLdcMeItem:(LDCMeItem *)ldcMeItem
{
    _ldcMeItem = ldcMeItem;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:ldcMeItem.icon]];
    
    self.titleLabel.text = ldcMeItem.name;
}

@end
