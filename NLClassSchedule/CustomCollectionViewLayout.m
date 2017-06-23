//
//  CustomCollectionViewLayout.m
//  ClassScheduleDemo
//
//  Created by liangzc on 17/3/15.
//  Copyright © 2017年 xlb. All rights reserved.
//

#import "CustomCollectionViewLayout.h"

@interface CustomCollectionViewLayout ()

@property (strong, nonatomic) NSMutableArray *itemAttributes;
@property (strong, nonatomic) NSMutableArray *itemsSize;
@property (nonatomic, assign) CGSize contentSize;
@end

@implementation CustomCollectionViewLayout

- (void)prepareLayout {
    
    [self clearLayoutArray];
    [self calculateItemsSize];
    [self updateItemsAttributes];
}

#pragma mark - Private

- (void)clearLayoutArray {
    self.itemAttributes = [@[] mutableCopy];
    self.itemsSize = [@[] mutableCopy];
}

- (void)updateItemsAttributes {
    
    NSUInteger column = 0;
    CGFloat xOffset = 0.0;
    CGFloat yOffset = 0.0;
    CGFloat contentWidth = 0.0;
    CGFloat contentHeight = 0.0;
    
    for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
        NSMutableArray *sectionAttributes = [@[] mutableCopy];
        for (NSUInteger index = 0; index < self.rows; index++) {
            CGSize itemSize = [self.itemsSize[section][index] CGSizeValue];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height));
            
            if (section == 0 && index == 0) {
                attributes.zIndex = 1024;
            } else if (section == 0 || index == 0) {
                attributes.zIndex = 1023;
            }
            
            if (section == 0) {
                CGRect frame = attributes.frame;
                frame.origin.x = self.collectionView.contentOffset.x;
                attributes.frame = frame;
            }
            if (index == 0) {
                CGRect frame = attributes.frame;
                frame.origin.y = self.collectionView.contentOffset.y;
                attributes.frame = frame;
            }
            
            [sectionAttributes addObject:attributes];
            
            
            yOffset = yOffset+itemSize.height;
            column++;
            
            // Create a new row if this was the last column
            if (column == self.rows) {
                
                if (yOffset > contentHeight) {
                    contentHeight = yOffset;
                }
                
                // Reset values
                column = 0;
                
                xOffset += itemSize.width;
                yOffset = 0;
            }
        }
        [self.itemAttributes addObject:sectionAttributes];
    }
    
    UICollectionViewLayoutAttributes *attributes = [[self.itemAttributes lastObject] lastObject];
    contentWidth = attributes.frame.origin.x + attributes.frame.size.width;
    self.contentSize = CGSizeMake(contentWidth, contentHeight);
}

// 获取对应indexPath的itemSize
static CGFloat const extendWidth = 100.0;
- (CGSize)sizeForItemWithColumnIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(60, 100);//预设cell的size
    //根据表格的特性，调整不同情况下cell的宽高
    size.width = indexPath.section ? size.width : 40;
    size.height = indexPath.item ? size.height : 50;
    size.width = (indexPath.section == self.extendIndex && indexPath.section > 0) ? extendWidth : size.width;
    return size;
}

// 计算得到表格视图itemSize的集合
- (void)calculateItemsSize {
    if (self.itemsSize.count > 0) {
        return;
    }
    
    NSMutableArray *sectionArray = [@[] mutableCopy];
    for (NSInteger section = 0; section < [self.collectionView numberOfSections]; section ++) {
        NSMutableArray *itemArray = [@[] mutableCopy];
        for (NSUInteger index = 0; index < self.rows; index++) {
            if (self.itemsSize.count <= index) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
                CGSize itemSize = [self sizeForItemWithColumnIndexPath:indexPath];
                NSValue *itemSizeValue = [NSValue valueWithCGSize:itemSize];
                [itemArray addObject:itemSizeValue];
            }
        }
        [sectionArray addObject:itemArray];
    }
    self.itemsSize = sectionArray;
}

#pragma mark - Overwrite
//返回collectionView的内容的尺寸
- (CGSize)collectionViewContentSize {
    return self.contentSize;
}
// 返回对应于indexPath的位置的cell的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemAttributes[indexPath.section][indexPath.row];
}
// 返回rect中的所有的元素的布局属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [@[] mutableCopy];
    for (NSArray *section in self.itemAttributes) {
        [attributes addObjectsFromArray:[section filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
            return CGRectIntersectsRect(rect, [evaluatedObject frame]);
        }]]];
    }
    return attributes;
}
// 当边界发生改变时，是否应该刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES; // 在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息
}

@end

