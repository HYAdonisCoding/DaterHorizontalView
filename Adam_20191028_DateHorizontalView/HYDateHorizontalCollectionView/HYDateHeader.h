//
//  HYDateHeader.h
//  Adam_20191028_DateHorizontalView
//
//  Created by Adonis_HongYang on 2019/10/31.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#ifndef HYDateHeader_h
#define HYDateHeader_h

/// 选择月份天回调
typedef void(^HYMonthDaySelectedBlock)(NSDate *date, NSInteger month, NSInteger day, NSString *year);

/// 选择日期回调
typedef void(^HYDateSelectedBlock)(NSDate *date, NSInteger month, NSInteger day, NSString *year, NSString *monthYear);

//将self转换成弱引用
#define WK(weakSelf) \
    __weak __typeof(self)weakSelf = self;

//将weakSelf转换成强引用
#define SG(strongSelf) \
    __strong __typeof(self)strongSelf = weakSelf;

#endif /* HYDateHeader_h */
