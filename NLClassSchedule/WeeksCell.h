//
//  WeeksCell.h
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/15.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeeksCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *weeksLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong, readonly) NSIndexPath *indexPath;
@property (nonatomic, assign, readonly) NSInteger todayIndex;

- (void)setupIndexPath:(NSIndexPath *)indexPath todayIndex:(NSInteger)index extendIndex:(NSInteger)extendIndex;
@end
