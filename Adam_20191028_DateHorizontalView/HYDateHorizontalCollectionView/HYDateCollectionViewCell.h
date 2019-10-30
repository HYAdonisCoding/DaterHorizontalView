//
//  HYDateCollectionViewCell.h
//  Adam_20191028_DatePickerHorizontal
//
//  Created by Adonis_HongYang on 2019/10/29.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYDateCollectionViewCell : UICollectionViewCell

/// 日期
@property (nonatomic, strong) UILabel *dateLabel;

/// 黄色刻度线
@property (nonatomic, strong) UIView *ruleView;

@end

NS_ASSUME_NONNULL_END
