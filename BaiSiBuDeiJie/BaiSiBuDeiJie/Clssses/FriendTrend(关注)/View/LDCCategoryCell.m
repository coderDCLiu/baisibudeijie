//
//  LDCCategoryCell.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 2016/11/1.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCCategoryCell.h"
#import "LDCCategoryItem.h"

@interface LDCCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation LDCCategoryCell

-(void)setCategoryItem:(LDCCategoryItem *)categoryItem
{
    _categoryItem = categoryItem;
    _categoryLabel.text = categoryItem.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //取消选中样式
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    _indicator.hidden = !selected;
    _categoryLabel.textColor = selected ? [UIColor redColor] : [UIColor blackColor];
}

@end
