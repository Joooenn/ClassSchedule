//
//  NumberCell.m
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/16.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "NumberCell.h"

@implementation NumberCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

@end
