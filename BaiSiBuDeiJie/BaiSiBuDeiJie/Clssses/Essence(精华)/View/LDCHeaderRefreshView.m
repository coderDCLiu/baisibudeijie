//
//  LDCHeaderRefreshView.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/30.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCHeaderRefreshView.h"

@interface LDCHeaderRefreshView ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIView *loadView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end

@implementation LDCHeaderRefreshView

-(void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh = isRefresh;
    _label.hidden = isRefresh;
    _arrowImageView.hidden = isRefresh;
    _loadView.hidden = !isRefresh;
}

-(void)setIsNeedLoad:(BOOL)isNeedLoad
{
    _isNeedLoad = isNeedLoad;
    
//    _loadView.hidden = YES;
    
    _label.text = isNeedLoad?@"松开立即刷新":@"下拉可以刷新";
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _arrowImageView.transform = isNeedLoad?CGAffineTransformMakeRotation(-M_PI):CGAffineTransformIdentity;
        
    }];
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

+(instancetype)ldcHeaderRefreshView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

@end
