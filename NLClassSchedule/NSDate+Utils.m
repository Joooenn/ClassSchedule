//
//  NSDate+Utils.m
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/17.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)

+ (NSString *)getOneDay:(int)day date:(NSDate *)date {
    int year = 0, month = 0;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString *  monthDayString = [formatter stringFromDate:newdate];
    return monthDayString;
}

+ (int)dateMonday {
    
    /*日期 & 星期逻辑处理*/
    NSDate *theDate = [NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"EEE"];
    NSString *weekString = [dateformatter stringFromDate:theDate];
    [dateformatter setDateFormat:@"dd"];
    NSString *  dayString = [dateformatter stringFromDate:theDate];
    int day = [dayString intValue];
    
    // 判断当前天是周几，从而计算出当周的周一是几号（负数表示上个月月末）
    if ([weekString  isEqual: @"周一"] || [weekString  isEqualToString:@"Mon" ]) {
        day = 0;
    } else if ([weekString isEqual:@"周二"] || [weekString  isEqual:@"Tue"]) {
        day = -1;
    } else if ([weekString isEqual:@"周三"] || [weekString  isEqual:@"Wed"]) {
        day = -2;
    } else if ([weekString isEqual:@"周四"] || [weekString  isEqual:@"Thu"]) {
        day = -3;
    } else if ([weekString isEqual:@"周五"] || [weekString  isEqual:@"Fri"]) {
        day = -4;
    } else if ([weekString isEqual:@"周六"] || [weekString  isEqual:@"Sat"]) {
        day = -5;
    } else if ([weekString isEqual:@"周日"] || [weekString  isEqual:@"Sun"]) {
        day = -6;
    }
    
    return day;
}

+ (NSInteger)weekdayIndexFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @7, @1, @2, @3, @4, @5, @6, nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/BeiJing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [[weekdays objectAtIndex:theComponents.weekday] integerValue]-1;
    
}

@end
