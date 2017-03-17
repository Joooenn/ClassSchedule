//
//  NSDate+Utils.h
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/17.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utils)

+ (NSString *)getOneDay:(int)day date:(NSDate *)date;
+ (int)dateMonday;
+ (NSInteger)weekdayIndexFromDate:(NSDate*)inputDate;

@end
