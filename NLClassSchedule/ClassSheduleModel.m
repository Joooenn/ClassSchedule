//
//  ClassSheduleModel.m
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/15.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "ClassSheduleModel.h"

@implementation ItemModel
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        self = [super init];
        if (self) {
            [self setValuesForKeysWithDictionary:dict];
        }
        return self;
    } else {
        return nil;
    }
}
@end

@implementation ClassSheduleModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if ([key isEqualToString:@"items"] && [value isKindOfClass:[NSArray class]]) {
        NSMutableArray *tmp = [NSMutableArray new];
        
        for (NSDictionary *dict in value) {
            ItemModel *item = [[ItemModel alloc] initWithDictionary:dict];
            [tmp addObject:item];
        }
        value = tmp;
    }
    
    [super setValue:value forKey:key];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        self = [super init];
        if (self) {
            [self setValuesForKeysWithDictionary:dict];
        }
        return self;
    } else {
        return nil;
    }
}

+ (NSArray *)sectionModelsWithArray:(NSArray *)array {
    if ([array isKindOfClass:[NSArray class]]) {
        NSMutableArray *tmp = [NSMutableArray new];
        for (NSDictionary *dict in array) {
            ClassSheduleModel *item = [[ClassSheduleModel alloc] initWithDictionary:dict];
            [tmp addObject:item];
        }
        return [tmp copy];
    }
    return nil;
}

@end
