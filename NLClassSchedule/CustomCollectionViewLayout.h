//
//  CustomCollectionViewLayout.h
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/15.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewLayout : UICollectionViewLayout
// 被选中列
@property (nonatomic, assign) IBInspectable NSInteger extendIndex;
// 预设每个section有多少item
@property (nonatomic, assign) IBInspectable NSInteger rows;
@end

