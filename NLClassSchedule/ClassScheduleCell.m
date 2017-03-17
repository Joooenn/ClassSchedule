//
//  ClassScheduleCell.m
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/14.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "ClassScheduleCell.h"

@implementation ClassScheduleCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.courseNameLabel.text = nil;
    self.timeLabel.text = nil;
    self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

@end
