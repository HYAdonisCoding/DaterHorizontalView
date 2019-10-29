//
//  HYDateCollectionViewCell.m
//  Adam_20191028_DatePickerHorizontal
//
//  Created by Adonis_HongYang on 2019/10/29.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#import "HYDateCollectionViewCell.h"

@interface HYDateCollectionViewCell ()

/// <#Description#>
@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation HYDateCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeInterface];
    }
    return self;
}

- (void)makeInterface {
    self.backgroundColor = [UIColor whiteColor];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.dateLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + 10);
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.font = [UIFont systemFontOfSize:13];
    self.dateLabel.textColor = [UIColor grayColor];
    [self addSubview:self.dateLabel];
    
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.path = [UIBezierPath bezierPath];
    [self.path moveToPoint:CGPointMake(0, 1)];
    [self.path addLineToPoint:CGPointMake(width, 1)];
    [self.path moveToPoint:CGPointMake(width/2, 1)];
    [self.path addLineToPoint:CGPointMake(width/2, height/2.5)];
    
    self.path.lineWidth = 3.0f;
    [[UIColor blueColor] setStroke];
    [self.path stroke];
    
    self.path.lineWidth = 1.50f;
    [self.path moveToPoint:CGPointMake(0, 1)];
    [self.path addLineToPoint:CGPointMake(0, height/5)];
    
    [self.path moveToPoint:CGPointMake(width/6, 1)];
    [self.path addLineToPoint:CGPointMake(width/6, height/4)];
    
    [self.path moveToPoint:CGPointMake(width*2/6, 1)];
    [self.path addLineToPoint:CGPointMake(width*2/6, height/5)];
    
    [self.path moveToPoint:CGPointMake(width*4/6, 1)];
    [self.path addLineToPoint:CGPointMake(width*4/6, height/5)];
    
    [self.path moveToPoint:CGPointMake(width*5/6, 1)];
    [self.path addLineToPoint:CGPointMake(width*5/6, height/4)];
    [self.path stroke];
}
@end
