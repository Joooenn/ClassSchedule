//
//  CustomCollectionViewLayout.h
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/15.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import <UIKit/UIKit.h>

// NOTE: This class is not used in this project - actually it is removed from the target. I added it just in case you need to compare the code between Objective-C and Swift
typedef NS_ENUM(NSUInteger, CustomScrollDirection) {
    CustomScrollDirectionVertical = 0,
    CustomScrollDirectionHorizontal
};


@interface CustomCollectionViewLayout : UICollectionViewLayout
@property (nonatomic, assign) IBInspectable NSInteger extendIndex;
@property (nonatomic, assign) IBInspectable NSInteger rows;
@end
