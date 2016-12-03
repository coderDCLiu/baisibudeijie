//
//  LDCAllViewModel.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/25.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCAllViewModel.h"

#import "LDCTopicItem.h"
#import "LDCTopicCommentItem.h"

@implementation LDCAllViewModel

-(void)setLdcTopicItem:(LDCTopicItem *)ldcTopicItem
{
    _ldcTopicItem = ldcTopicItem;
    
    //topView的frame
    CGFloat margin = 10;
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = LDCScreenW;
    CGFloat textY = 60;
    CGFloat textW = LDCScreenW - 2 * margin;
    CGFloat textH = [ldcTopicItem.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(textW, MAXFLOAT)].height;
    
    CGFloat topH = textY + textH;
    CGFloat cellH = textY + textH + margin;
    
    self.topViewFrame = CGRectMake(topX, topY, topW, topH);
    self.cellH = cellH;
    
    //middleView的frame
    if (ldcTopicItem.type != LDCTopicItemTypeText) {
        
        CGFloat middleX = margin;
        CGFloat middleY = _cellH;
        CGFloat middleW = textW;
        CGFloat middleH = textW / ldcTopicItem.width * ldcTopicItem.height;
        if (middleH > LDCScreenH) {
            ldcTopicItem.isBigPicture = YES;
            middleH = 300;
        }
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        self.cellH = CGRectGetMaxY(self.middleFrame) + margin;
        
    }
    
    //最热评论的view
    if (ldcTopicItem.commentItem) {
        
        CGFloat commentX = margin;
        CGFloat commentY = self.cellH;
        CGFloat commentW = textW;
        CGFloat commentH = 43;
        if (ldcTopicItem.commentItem.content.length) {
            
            CGFloat commentTextH = [ldcTopicItem.commentItem.totalContent sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(commentW, MAXFLOAT)].height;
            commentH = 21 + commentTextH;
            
        }
        
        _commentFrame = CGRectMake(commentX, commentY, commentW, commentH);
        self.cellH = CGRectGetMaxY(self.commentFrame) + margin;
        
    }
    
    //最底部的view
    CGFloat bottomX = 0;
    CGFloat bottomY = self.cellH;
    CGFloat botomW = LDCScreenW;
    CGFloat bottomH = 35;
    _bottomFrame = CGRectMake(bottomX, bottomY, botomW, bottomH);
    self.cellH = CGRectGetMaxY(_bottomFrame);
    
}



@end
