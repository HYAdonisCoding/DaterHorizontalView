//
//  HYDateHorizontalCollectionView.h
//  Adam_20191028_DatePickerHorizontal
//
//  Created by Adonis_HongYang on 2019/10/29.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYDateHeader.h"


NS_ASSUME_NONNULL_BEGIN

@interface HYDateHorizontalCollectionView : UIView

/// 选中的日期
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/// 数据
@property (nonatomic, copy) NSArray *dataArray;

/// 回调
@property (nonatomic, copy) HYMonthDaySelectedBlock block;


/// 刻度尺日期选择器
/// @param frame frame
/// @param date 日期
/// @param dataArray 数据源
/// @param selectedIndexPath 选中的日期
/// @param block 回调
- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date dataArray:(NSArray *)dataArray selectedIndexPath:(NSIndexPath *)selectedIndexPath completion:(HYMonthDaySelectedBlock)block;

@end

NS_ASSUME_NONNULL_END
