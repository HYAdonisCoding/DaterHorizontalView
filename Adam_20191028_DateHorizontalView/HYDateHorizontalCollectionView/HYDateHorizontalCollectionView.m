//
//  HYDateHorizontalCollectionView.m
//  Adam_20191028_DatePickerHorizontal
//
//  Created by Adonis_HongYang on 2019/10/29.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#import "HYDateHorizontalCollectionView.h"
#import "HYDateCollectionViewCell.h"
#import "HYCollectionViewFlowLayout.h"
#import "HYDateUtils.h"
#import "HYDateView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface HYDateHorizontalCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource> {
    CGFloat _offer;
    NSIndexPath * middleIndexPath;
}

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

/// 时间按钮
@property (nonatomic, strong) UIButton *dateButton;

/// 年
@property (nonatomic, copy) NSString *year;

/// 日期
@property (nonatomic, strong) NSDate *date;

/// 日期控件
@property (nonatomic, strong) HYDateView *dateView;

@end

@implementation HYDateHorizontalCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeInterface];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date dataArray:(NSArray *)dataArray selectedIndexPath:(NSIndexPath *)selectedIndexPath completion:(HYMonthDaySelectedBlock)block {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeInterface];
        self.date = date;
        self.year = [HYDateUtils getYearWith:date];
        self.block = block;
        self.dataArray = dataArray;
        self.selectedIndexPath = selectedIndexPath;
    }
    return self;
}

- (void)makeInterface {
    CGRect collectionViewFrame = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height-10-50);
    
    HYCollectionViewFlowLayout *flowLayout = [[HYCollectionViewFlowLayout alloc] init];
    // 设置UICollectionView为横向滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 每一行cell之间的间距
    flowLayout.minimumLineSpacing = 0;
    // 每一列cell之间的间距
     flowLayout.minimumInteritemSpacing = 0;
    // 设置第一个cell和最后一个cell,与父控件之间的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;// 根据需要编写
    flowLayout.minimumInteritemSpacing = 0;// 根据需要编写
    CGFloat height = (collectionViewFrame.size.height);
    CGFloat width = ceilf(collectionViewFrame.size.width *.2);

    flowLayout.itemSize = CGSizeMake(width, height);// 该行代码就算不写,item也会有默认尺寸
    
    UIView *backView = [[UIView alloc] initWithFrame:collectionViewFrame];
    backView.layer.shadowOffset = CGSizeMake(3,3);//往x方向偏移0，y方向偏移0
    backView.layer.shadowOpacity = 0.3;//设置阴影透明度
    backView.layer.shadowColor= [UIColor grayColor].CGColor;//设置阴影颜色
    backView.layer.shadowRadius = 5;//设置阴影半径
    [self addSubview:backView];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, collectionViewFrame.size.width, collectionViewFrame.size.height) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.multipleTouchEnabled = NO;
    collectionView.scrollsToTop=NO;

    collectionView.showsVerticalScrollIndicator=NO;

    collectionView.showsHorizontalScrollIndicator=NO;

    collectionView.pagingEnabled=YES;
    self.collectionView = collectionView;
    [backView addSubview:collectionView];
    
    [self.collectionView registerClass:[HYDateCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HYDateCollectionViewCell class])];
    
    /// 增加模糊效果
    CGFloat space = 10;
    CGFloat widthRatio = 0.15;
    CGFloat viewHeight = self.collectionView.frame.size.height;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleExtraLight)];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.5;
    effectView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y + space, self.frame.size.width * widthRatio, viewHeight);
    [self addSubview:effectView];
    
    UIVisualEffectView *effectView1 = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView1.alpha = 0.5;
    effectView1.frame = CGRectMake(CGRectGetWidth(self.collectionView.frame)-self.frame.size.width * widthRatio, self.collectionView.frame.origin.y + space, self.frame.size.width * widthRatio, viewHeight);
    [self addSubview:effectView1];
    
    /// 增加渐变效果
    UIColor *color = [UIColor lightGrayColor];
    CAGradientLayer *viewALayer = [CAGradientLayer layer];
    viewALayer.frame = effectView1.bounds;
    viewALayer.colors = [NSArray arrayWithObjects:
                       (id)[UIColor whiteColor].CGColor,
                       (id)color.CGColor, nil];
    viewALayer.startPoint = CGPointMake(0, 0);
    viewALayer.endPoint = CGPointMake(1, 0);
    [effectView1.layer addSublayer: viewALayer];

    CAGradientLayer *viewBLayer = [CAGradientLayer layer];
    viewBLayer.frame = effectView.bounds;
    viewBLayer.colors = [NSArray arrayWithObjects:
                       (id)color.CGColor,
                       (id)[UIColor whiteColor].CGColor, nil];
    viewBLayer.startPoint = CGPointMake(0, 0);
    viewBLayer.endPoint = CGPointMake(1, 0);
    [effectView.layer addSublayer: viewBLayer];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:[HYDateUtils getMonthYearWith:[NSDate date]] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor magentaColor] forState:(UIControlStateNormal)];
    button.frame = CGRectMake(0, self.bounds.size.height-50, self.bounds.size.width, 40);
    [self addSubview:button];
    self.dateButton = button;
    [button addTarget:self action:@selector(dateButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)dateButtonClicked:(UIButton *)sender {
    WK(weakSelf);
    CGRect bounds = [UIScreen mainScreen].bounds;
    HYDateView *dateView = [[HYDateView alloc] initWithDate:self.date frame:bounds completion:^(NSDate *date, NSInteger month, NSInteger day, NSString *year, NSString *monthYear) {
        SG(strongSelf);
        strongSelf.dataArray = [HYDateUtils getAllDaysWith:date];
        strongSelf.selectedIndexPath = [HYDateUtils getIndexPathWith:date];
        [strongSelf.dateButton setTitle:monthYear forState:(UIControlStateNormal)];
        strongSelf.year = year;
    }];
    self.dateView = dateView;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview: dateView];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view bringSubviewToFront:dateView];
}


- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if([hitView isKindOfClass:[UIVisualEffectView class]]){
        return self.collectionView;
    }
    return hitView;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ((NSMutableArray *)self.dataArray[section]).count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYDateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HYDateCollectionViewCell class]) forIndexPath:indexPath];
    cell.dateLabel.text = ((NSMutableArray *)self.dataArray[indexPath.section])[indexPath.row];
    if (indexPath == middleIndexPath) {
        cell.dateLabel.font = [UIFont boldSystemFontOfSize:18];
        cell.dateLabel.textColor = [UIColor purpleColor];
        cell.ruleView.hidden = NO;
    } else {
        cell.dateLabel.font = [UIFont systemFontOfSize:13];
        cell.dateLabel.textColor = [UIColor grayColor];
        cell.ruleView.hidden = YES;
    }
    return cell;
}

- (void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath {
    /// 选中数据后放到中间组显示
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndexPath.row inSection:selectedIndexPath.section+12];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
}

- (void)setDataArray:(NSArray *)dataArray {
    /// 创建三组数据,避免边界值不能选择的问题
    NSMutableArray *mutableArray = dataArray.mutableCopy;
    [mutableArray addObjectsFromArray:dataArray];
    [mutableArray addObjectsFromArray:dataArray];
    _dataArray = mutableArray.copy;
    [self.collectionView reloadData];
}

#pragma mark -- scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //系统方法返回处于collectionView某坐标处的cell的indexPath
    middleIndexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(scrollView.contentOffset.x + self.collectionView.frame.size.width/2, self.collectionView.frame.origin.y)];
//    NSLog(@"1 中间的cell：第 %ld 组 %ld个", middleIndexPath.section, middleIndexPath.row);
    [self.collectionView reloadData];
    NSInteger section = middleIndexPath.section;
    if (section > 11 && section < 24) {
        section -= 12;
    } else if (section >= 24) {
        section -= 24;
    }
    [self.dateButton setTitle:[NSString stringWithFormat:@"%02ld.%@", (long)section+1, self.year] forState:(UIControlStateNormal)];
    self.date = [HYDateUtils getDateWithDateString:[NSString stringWithFormat:@"%@-%ld-%ld", self.year, (long)section+1, middleIndexPath.row+1]];
    if (self.block) {
        self.block(self.date, section, middleIndexPath.row, self.year);
    }
    
    [self playSystemSound];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView{
    
    _offer= scrollView.contentOffset.x;
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView*)scrollView{

    [self.collectionView scrollToItemAtIndexPath:middleIndexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
//    NSLog(@"2 中间的cell：第 %ld 组 %ld个", middleIndexPath.section, middleIndexPath.row);

}

- (void)scrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset{

    [self.collectionView scrollToItemAtIndexPath:middleIndexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
//    NSLog(@"3 中间的cell：第 %ld 组 %ld个", middleIndexPath.section, middleIndexPath.row);
}

//滚动时不允许确认
- (BOOL)anySubViewScrolling:(UIView *)view {
    
    if ([view isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UIScrollView *)view;
        
        if (scrollView.dragging || scrollView.decelerating) {
            return YES;
        }
    }
    
    for (UIView *theSubView in view.subviews) {
        if ([self anySubViewScrolling:theSubView]) {
            return YES;
        }
    }
    return NO;
}

- (void)playSystemSound {
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  // 震动
    // 普通短震，3D Touch 中 Peek 震动反馈
//    AudioServicesPlaySystemSound(1519);
    // 普通短震，3D Touch 中 Pop 震动反馈
    //AudioServicesPlaySystemSound(1520);
    // 连续三次短震
    //AudioServicesPlaySystemSound(1521);
    
    //kSystemSoundID_UserPreferredAlert   = 0x00001000,
    //kSystemSoundID_FlashScreen          = 0x00000FFE,
           // this has been renamed to be consistent
    //kUserPreferredAlert     = kSystemSoundID_UserPreferredAlert
    
    AudioServicesPlaySystemSound(1052);
}

@end
