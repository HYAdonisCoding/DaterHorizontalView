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

@interface HYDateHorizontalCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource> {
    CGFloat _offer;
    NSIndexPath * middleIndexPath;
}

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HYDateHorizontalCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeInterface];
    }
    return self;
}

- (void)makeInterface {
    CGRect collectionViewFrame = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height-10);
    
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
    } else {
        cell.dateLabel.font = [UIFont systemFontOfSize:13];
        cell.dateLabel.textColor = [UIColor grayColor];
    }
    return cell;
}

- (void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath {
    /// 选择数据后放到中间组显示
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
    NSLog(@"1 中间的cell：第 %ld 组 %ld个", middleIndexPath.section, middleIndexPath.row);
    [self.collectionView reloadData];
    if (self.block) {
        NSInteger section = middleIndexPath.section;
        if (section > 11 && section < 24) {
            section -= 12;
        } else if (section >= 24) {
            section -= 24;
        }
        self.block(section, middleIndexPath.row);
    }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView{
    
    _offer= scrollView.contentOffset.x;
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView*)scrollView{

    [self.collectionView scrollToItemAtIndexPath:middleIndexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    NSLog(@"2 中间的cell：第 %ld 组 %ld个", middleIndexPath.section, middleIndexPath.row);

}

- (void)scrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset{

    [self.collectionView scrollToItemAtIndexPath:middleIndexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    NSLog(@"3 中间的cell：第 %ld 组 %ld个", middleIndexPath.section, middleIndexPath.row);
}


@end
