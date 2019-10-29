//
//  HYDateHorizontalCollectionView.h
//  Adam_20191028_DatePickerHorizontal
//
//  Created by Adonis_HongYang on 2019/10/29.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HYMonthSelectedBlock)(NSInteger month);

NS_ASSUME_NONNULL_BEGIN

@interface HYDateHorizontalCollectionView : UIView

/// 选中的日期
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/// 数据
@property (nonatomic, copy) NSArray *dataArray;

/// 回调
@property (nonatomic, copy) HYMonthSelectedBlock block;


@end

NS_ASSUME_NONNULL_END
