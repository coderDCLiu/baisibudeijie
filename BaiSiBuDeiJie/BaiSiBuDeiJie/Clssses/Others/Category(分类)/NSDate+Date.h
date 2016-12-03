//
//  NSDate+Date.h
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/27.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Date)

-(BOOL)isThisYear;

-(BOOL)isThisDay;

-(BOOL)isYesterday;

-(NSDateComponents*)datelWithNow;

@end
