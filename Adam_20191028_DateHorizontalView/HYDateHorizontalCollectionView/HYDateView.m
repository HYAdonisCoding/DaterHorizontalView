//
//  HYDateView.m
//  Adam_20191028_DateHorizontalView
//
//  Created by Adonis_HongYang on 2019/10/31.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#import "HYDateView.h"
#import "HYDateUtils.h"
#import "HYUsefulUtils.h"

@interface HYDateView ()

/// 日期
@property (nonatomic, strong) NSDate *date;
/// 日期选择器
@property (nonatomic, strong) UIDatePicker *datePicker;

/// 背景
@property (nonatomic, strong) UIView *backView;

/// 回调
@property (nonatomic, copy) HYDateSelectedBlock block;

/// 确定按钮
@property (nonatomic, strong) UIButton *ensureButton;


@end

@implementation HYDateView

- (instancetype)initWithDate:(NSDate *)date frame:(CGRect)frame completion:(nonnull HYDateSelectedBlock)completion {
    self = [super initWithFrame:frame];
    if (self) {
        self.date = date;
        self.block = completion;
        [self makeInterface];
    }
    return self;
}

- (void)makeInterface {
    
    UIView *backView = [[UIView alloc] initWithFrame:self.frame];
    backView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:backView];
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width, 400)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.date = self.date;
    self.datePicker = datePicker;
    [backView addSubview:datePicker];
    
    UIButton *ensureButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ensureButton setTitle:@"确定" forState:(UIControlStateNormal)];
    ensureButton.frame = CGRectMake(0, 600, self.frame.size.width, 40);
    [ensureButton addTarget:self action:@selector(ensureButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:ensureButton];
    
    self.ensureButton = ensureButton;
    
    self.backView = backView;
    
    [backView bringSubviewToFront: ensureButton];
    
    
}

- (void)ensureButtonClicked:(UIButton *)sender {
    NSDate *date = self.datePicker.date;
    self.date = date;
    NSString *yearString = [HYDateUtils getYearWith:date];
    NSString *monthYearString = [HYDateUtils getMonthYearWith:date];
    NSInteger month = [HYDateUtils getMonthNumberDaysWithDate:date];
    NSInteger days = [HYDateUtils getMonthNumberDaysWithDate:date];
    NSLog(@"%ld", (long)days);

    if (self.block) {
        self.block(date, month, days, yearString, monthYearString);
    }
    
    [self removeFromSuperview];
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if([hitView isKindOfClass:[UIButton class]]){
        
    }
    return hitView;
}


@end
