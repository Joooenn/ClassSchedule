//
//  ClassScheduleViewController.m
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/15.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "ClassScheduleViewController.h"
#import "ClassScheduleCell.h"
#import "WeeksCell.h"
#import "ClassSheduleModel.h"
#import "NumberCell.h"
#import "CustomCollectionViewLayout.h"
#import "NSDate+Utils.h"

@interface ClassScheduleViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *dataArray;
@end

static NSString *const kCourseReuseIdentifier = @"ClassScheduleCell";
static NSString *const kWeeksReuseIdentifier = @"WeeksCell";
static NSString *const kNumberReuseIdentifier = @"NumberCell";

@implementation ClassScheduleViewController {
    NSInteger _extendIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //init data
    NSArray *dateArray = @[@{@"items" : @[@{@"courseName":@"名字要长的七级A班",@"time":@"15:00-17:00"},
                                          @{@"courseName":@"名字要长的五级班",@"time":@"17:10-18:40"},
                                          @{@"courseName":@"名字要长的七级B班",@"time":@"17:10-19:10"}]
                             },
                           @{@"items" : @[]
                             },
                           @{@"items" : @[@{@"courseName":@"名字要长的特长生班",@"time":@"16:00-20:30"},
                                          @{@"courseName":@"名字要长的三级班",@"time":@"17:20-18:50"}]
                             },
                           @{@"items" : @[@{@"courseName":@"名字要长的A班",@"time":@"17:20-18:20"}]
                             },
                           @{@"items" : @[],
                             },
                           @{@"items" : @[@{@"courseName":@"名字要长的一班",@"time":@"17:00-19:00"},
                                          @{@"courseName":@"名字要的的额的的的长的B班",@"time":@"17:20-18:20"},
                                          @{@"courseName":@"名字要长的A班",@"time":@"17:20-18:20"}]
                             },
                           @{@"items" : @[@{@"courseName":@"名字要长的的的的九级班",@"time":@"10:45-12:45"},
                                          @{@"courseName":@"名字要长的十一级班",@"time":@"13:00-15:00"},
                                          @{@"courseName":@"名字要长的十级班",@"time":@"18:40-20:40"},
                                          @{@"courseName":@"名字要长的的的十二级班",@"time":@"19:20-12:20"}]
                             }
                           ];
    
    self.dataArray = [ClassSheduleModel sectionModelsWithArray:dateArray];
    // init layout
    CustomCollectionViewLayout *layout = (CustomCollectionViewLayout *)self.collectionView.collectionViewLayout;
    layout.extendIndex = [NSDate weekdayIndexFromDate:[NSDate date]] + 1;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Delegate & DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataArray.count + 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        WeeksCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWeeksReuseIdentifier forIndexPath:indexPath];
        [cell setupIndexPath:indexPath todayIndex:[NSDate weekdayIndexFromDate:[NSDate date]] extendIndex:_extendIndex];
        return cell;
    } else {
        if (indexPath.section == 0) {
            NumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNumberReuseIdentifier forIndexPath:indexPath];
            cell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.item];
            return cell;
        } else {
            
            ClassScheduleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCourseReuseIdentifier forIndexPath:indexPath];
            ClassSheduleModel *scheduleModel = self.dataArray[indexPath.section - 1];
            NSArray *items = scheduleModel.items;
            
            if (items.count > 0 && items.count >= indexPath.item) {
                ItemModel *item = items[indexPath.item - 1];
                cell.courseNameLabel.text = item.courseName;
                cell.timeLabel.text = item.time;
                cell.contentView.backgroundColor = [UIColor orangeColor];
            }
            return cell;
        }
    }

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    //extend
    if (indexPath.item == 0 && indexPath.section > 0) {
        CustomCollectionViewLayout *layout = (CustomCollectionViewLayout *)self.collectionView.collectionViewLayout;
        layout.extendIndex = indexPath.section;
        _extendIndex = indexPath.section;
        [self.collectionView reloadData];
    }
    //delete
    if (indexPath.item > 0 && indexPath.section > 0) {
        ClassSheduleModel *model = self.dataArray[indexPath.section - 1];
        NSMutableArray *tempItems = [NSMutableArray arrayWithArray:model.items];
        if (tempItems.count > indexPath.item - 1) {
            [tempItems removeObjectAtIndex:indexPath.item - 1];
        }
        model.items = tempItems.copy;
        
        [self.collectionView reloadData];
    }
    
}

@end
