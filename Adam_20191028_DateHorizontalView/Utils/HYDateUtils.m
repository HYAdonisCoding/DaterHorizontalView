//
//  HYDateUtils.m
//  Adam_20191028_DateHorizontalView
//
//  Created by Adonis_HongYang on 2019/10/29.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#import "HYDateUtils.h"
#import <UIKit/UIKit.h>

@implementation HYDateUtils

+ (NSMutableArray *)getAllDaysWith:(NSDate *)date {
    NSString *year = [self getYearWith:date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //设置转换后的目标日期时区
    NSTimeZone *toTimeZone = [NSTimeZone defaultTimeZone];
    //转换后源日期与世界标准时间的偏移量
    NSInteger toGMTOffset = [toTimeZone secondsFromGMTForDate:[NSDate date]];
    [dateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT:toGMTOffset]];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:12];
    for (int i = 1; i < 13; i++) {
        NSString *firstDay = [year stringByAppendingFormat:@"-%02d-01", i];
        NSDate *date = [dateFormatter dateFromString:firstDay];
        NSInteger days = [self getInMonthNumberDaysWithDate:date];
        NSMutableArray *daysArray = [NSMutableArray arrayWithCapacity:days];
        for (int j = 1; j <= days; j++) {
            [daysArray addObject:[NSString stringWithFormat:@"%02d", j]];
        }
        array[i-1] = daysArray;
    }
    return array;
}

+ (NSString *)getMonthYearWith:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
    NSLog(@"Date = %@ ,year = %ld ,month=%ld, day=%ld",date,year,month,day);
    return [NSString stringWithFormat:@"%d.%d", month, year];
}


+ (NSInteger)getMonthWith:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
    return month;
}

+ (NSIndexPath *)getIndexPathWith:(NSDate *)date {
    return [NSIndexPath indexPathForItem:[HYDateUtils getDayWith:date]-1 inSection:[HYDateUtils getMonthWith:date]-1];
}

+ (NSInteger)getDayWith:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
    return day;
}

+ (NSString *)getYearWith:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
    NSLog(@"Date = %@ ,year = %ld ,month=%ld, day=%ld",date,year,month,day);
    return [NSString stringWithFormat:@"%ld", (long)year];
}

#pragma mark - 获取一个月的天数
+ (NSInteger)getInMonthNumberDaysWithDate:(NSDate *)date {
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:date];
    return range.length;
}

@end
