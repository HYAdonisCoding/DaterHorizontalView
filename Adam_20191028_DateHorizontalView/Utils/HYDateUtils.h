//
//  HYDateUtils.h
//  Adam_20191028_DateHorizontalView
//
//  Created by Adonis_HongYang on 2019/10/29.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYDateUtils : NSObject

/// 获取一年的所有天
+ (NSMutableArray *)getAllDaysWith:(NSDate *)date;

/// 获取该天的位置信息
+ (NSIndexPath *)getIndexPathWith:(NSDate *)date;

/// 获取月年
+ (NSString *)getMonthYearWith:(NSDate *)date;

/// 获取一个月的天数
+ (NSInteger)getInMonthNumberDaysWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
