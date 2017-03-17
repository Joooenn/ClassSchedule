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
    
    NSUInteger column = 0;
    CGFloat xOffset = 0.0;
    CGFloat yOffset = 0.0;
    CGFloat contentWidth = 0.0;
    CGFloat contentHeight = 0.0;
    
    if (self.itemAttributes.count > 0) {
        for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
            NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
            for (NSUInteger index = 0; index < numberOfItems; index++) {
                if (section != 0 && index != 0) {
                    continue;
                }
                UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:section]];
                if (section == 0) {
                    CGRect frame = attributes.frame;
                    frame.origin.y = self.collectionView.contentOffset.y;
                    attributes.frame = frame;
                }
                if (index == 0) {
                    CGRect frame = attributes.frame;
                    frame.origin.x = self.collectionView.contentOffset.x;
                    attributes.frame = frame;
                }
            }
        }
    }
    
    self.itemAttributes = [@[] mutableCopy];
    self.itemsSize = [@[] mutableCopy];
    
    [self calculateItemsSize];

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
//                    frame.origin.y = self.collectionView.contentOffset.y;
                attributes.frame = frame;
            }
            if (index == 0) {
                CGRect frame = attributes.frame;
                frame.origin.y = self.collectionView.contentOffset.y;
//                    frame.origin.x = self.collectionView.contentOffset.x;
                attributes.frame = frame;
            }
            
            [sectionAttributes addObject:attributes];

            yOffset = yOffset+itemSize.height;
//                xOffset = xOffset+itemSize.width;
            column++;
            
            // Create a new row if this was the last column
            if (column == self.rows) {
                
                if (yOffset > contentHeight) {
                    contentHeight = yOffset;
                }
//                    if (xOffset > contentWidth) {
//                        contentWidth = xOffset;
//                    }
                
                
                // Reset values
                column = 0;

                xOffset += itemSize.width;
                yOffset = 0;
//                    xOffset = 0;
//                    yOffset += itemSize.height;
            }
        }
        [self.itemAttributes addObject:sectionAttributes];
    }
    
    UICollectionViewLayoutAttributes *attributes = [[self.itemAttributes lastObject] lastObject];
    contentWidth = attributes.frame.origin.x+attributes.frame.size.width;
//    contentHeight = attributes.frame.origin.y+attributes.frame.size.height;
    self.contentSize = CGSizeMake(contentWidth, contentHeight);
}

- (CGSize)collectionViewContentSize {
    return self.contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemAttributes[indexPath.section][indexPath.row];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [@[] mutableCopy];
    for (NSArray *section in self.itemAttributes) {
        [attributes addObjectsFromArray:[section filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
            return CGRectIntersectsRect(rect, [evaluatedObject frame]);
        }]]];
    }
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES; // Set this to YES to call prepareLayout on every scroll
}

- (CGSize)sizeForItemWithColumnIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(60, 100);
    if (indexPath.section == 0) {
        size.width = 40;
    }
    if (indexPath.item == 0) {
        size.height = 50;
    }
    if (indexPath.section == self.extendIndex && indexPath.section) {
        size.width = 100;
    }
    return size;
    
}

- (void)calculateItemsSize {
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

@end
