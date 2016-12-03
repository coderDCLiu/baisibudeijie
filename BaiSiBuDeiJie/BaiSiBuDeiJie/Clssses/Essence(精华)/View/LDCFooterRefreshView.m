//
//  LDCFooterRefreshView.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/29.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCFooterRefreshView.h"

@interface LDCFooterRefreshView ()

@property (weak, nonatomic) IBOutlet UIView *loadMoreView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation LDCFooterRefreshView

-(void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh = isRefresh;
    _loadMoreView.hidden = !isRefresh;
    _label.hidden = isRefresh;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone ;
}

+(instancetype)ldcFooterRefreshView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

@end
