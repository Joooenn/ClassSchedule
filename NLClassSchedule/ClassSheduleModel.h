//
//  ClassSheduleModel.h
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/15.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic, copy) NSString *courseName;
@property (nonatomic, copy) NSString *time;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end

@interface ClassSheduleModel : NSObject

@property (nonatomic, strong) NSArray <ItemModel *> *items;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (NSArray *)sectionModelsWithArray:(NSArray *)array;
@end
