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

/// 日期
@property (nonatomic, strong) NSDate *date;
/// 时间选择
@property (nonatomic, strong) HYDateHorizontalCollectionView *dateHorizontalCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.date = [NSDate date];
    
    ViewController * __block weakSelf = self;
    HYDateHorizontalCollectionView *view = [[HYDateHorizontalCollectionView alloc] initWithFrame:CGRectMake(10, 400, self.view.frame.size.width-20, 120 + 50) date:self.date dataArray:[HYDateUtils getAllDaysWith:[NSDate date]] selectedIndexPath:[HYDateUtils getIndexPathWith:self.date] completion:^(NSDate *date, NSInteger month, NSInteger day, NSString *year) {
        weakSelf.date = date;
        NSLog(@"%@", date);
    }];
    
    [self.view addSubview:view];
    self.dateHorizontalCollectionView = view;
}



@end
