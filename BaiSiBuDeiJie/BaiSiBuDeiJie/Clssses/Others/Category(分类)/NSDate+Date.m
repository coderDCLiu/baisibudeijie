//
//  NSDate+Date.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/27.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "NSDate+Date.h"

@implementation NSDate (Date)

-(BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *create = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDate *date = [NSDate date];
    
    NSDateComponents *current = [calendar components:NSCalendarUnitYear fromDate:date];
    
   return  create.year == current.year;
    
}

-(BOOL)isThisDay
{
   NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDateInToday:self];
}

-(BOOL)isYesterday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar isDateInYesterday:self];
}

-(NSDateComponents*)datelWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:self toDate:[NSDate date] options:NSCalendarWrapComponents];
}

@end
