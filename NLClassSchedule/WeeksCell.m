//
//  WeeksCell.m
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/15.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "WeeksCell.h"
#import "NSDate+Utils.h"

@interface WeeksCell ()

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation WeeksCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.weeksLabel.text = nil;
    self.dateLabel.text = nil;
    self.weeksLabel.textColor = [UIColor blackColor];
    self.dateLabel.textColor = [UIColor blackColor];
    self.lineView.hidden = YES;
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.lineView.hidden = !selected;
}

- (void)setupIndexPath:(NSIndexPath *)indexPath todayIndex:(NSInteger)index extendIndex:(NSInteger)extendIndex {
    if (indexPath.section > 0) {
        self.weeksLabel.text = [self weeks][indexPath.section - 1];
        int day = [NSDate dateMonday];
        self.dateLabel.text = [NSDate getOneDay:day+(int)indexPath.section - 1 date:[NSDate date]];
        if (indexPath.section - 1 == [NSDate weekdayIndexFromDate:[NSDate date]]) {
            self.weeksLabel.textColor = [UIColor orangeColor];
            self.dateLabel.textColor = [UIColor orangeColor];
            self.lineView.hidden = NO;
        }
    }
    if (extendIndex > 0) {
        if (indexPath.section == extendIndex) {
            self.lineView.hidden = NO;
        } else {
            self.lineView.hidden = YES;
        }
    }
}

- (NSArray *)weeks {
    return @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
}


@end
