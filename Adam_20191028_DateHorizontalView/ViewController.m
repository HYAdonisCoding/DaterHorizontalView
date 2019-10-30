//
//  ViewController.m
//  Adam_20191028_DatePickerHorizontal
//
//  Created by Adonis_HongYang on 2019/10/28.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#import "ViewController.h"
#import "HYDateHorizontalCollectionView.h"
#import "HYDateUtils.h"

@interface ViewController ()
/// 时间按钮
@property (nonatomic, strong) UIButton *dateButton;

/// back
@property (nonatomic, strong) UIView *backView;
/// 日期选择器
@property (nonatomic, strong) UIDatePicker *datePicker;
/// 年
@property (nonatomic, copy) NSString *year;

/// 日期
@property (nonatomic, strong) NSDate *date;
/// 时间选择
@property (nonatomic, strong) HYDateHorizontalCollectionView *dateHorizontalCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.year = [HYDateUtils getYearWith:[NSDate date]];
    self.date = [NSDate date];
    
    HYDateHorizontalCollectionView *view = [[HYDateHorizontalCollectionView alloc] initWithFrame:CGRectMake(10, 400, self.view.frame.size.width-20, 120)];
    view.dataArray = [HYDateUtils getAllDaysWith:[NSDate date]];
    view.selectedIndexPath = [HYDateUtils getIndexPathWith:[NSDate date]];
    
    ViewController * __block weakSelf = self;
    view.block = ^(NSInteger month, NSInteger day) {
        [weakSelf.dateButton setTitle:[NSString stringWithFormat:@"%02ld.%@", (long)month+1, self.year] forState:(UIControlStateNormal)];
        weakSelf.date = [HYDateUtils getDateWithDateString:[NSString stringWithFormat:@"%@-%02ld-%02ld", self.year, (long)month+1, (long)day+1]];
    };
    
    [self.view addSubview:view];
    self.dateHorizontalCollectionView = view;
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:[HYDateUtils getMonthYearWith:[NSDate date]] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor magentaColor] forState:(UIControlStateNormal)];
    button.frame = CGRectMake(0, 540, self.view.bounds.size.width, 50);
    [self.view addSubview:button];
    self.dateButton = button;
    [button addTarget:self action:@selector(dateButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)dateButtonClicked:(UIButton *)sender {
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor cyanColor];
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 400)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.date = self.date;
    [view addSubview:datePicker];
    
    UIButton *ensureButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ensureButton setTitle:@"确定" forState:(UIControlStateNormal)];
    ensureButton.frame = CGRectMake(0, 600, self.view.bounds.size.width, 40);
    [ensureButton addTarget:self action:@selector(ensureButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:ensureButton];
    [self.view addSubview:view];
    self.datePicker = datePicker;
    self.backView = view;
}


- (void)ensureButtonClicked:(UIButton *)sender {
    NSDate *date = self.datePicker.date;
    self.year = [HYDateUtils getYearWith:date];
    self.date = date;
    [self.dateButton setTitle:[HYDateUtils getMonthYearWith:date] forState:(UIControlStateNormal)];
    NSInteger days = [HYDateUtils getMonthNumberDaysWithDate:date];
    NSLog(@"%ld", (long)days);
    
    self.dateHorizontalCollectionView.dataArray = [HYDateUtils getAllDaysWith:date];
    self.dateHorizontalCollectionView.selectedIndexPath = [HYDateUtils getIndexPathWith:date];
    
    [self.backView removeFromSuperview];
    
}



@end
