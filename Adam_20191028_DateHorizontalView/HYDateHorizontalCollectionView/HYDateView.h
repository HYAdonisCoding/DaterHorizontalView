//
//  HYDateView.h
//  Adam_20191028_DateHorizontalView
//
//  Created by Adonis_HongYang on 2019/10/31.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYDateHeader.h"


NS_ASSUME_NONNULL_BEGIN

@interface HYDateView : UIView

/// 创建时间选择器
/// @param date 日期
- (instancetype)initWithDate:(NSDate *)date frame:(CGRect)frame completion:(nonnull HYDateSelectedBlock)completion;



@end

NS_ASSUME_NONNULL_END
