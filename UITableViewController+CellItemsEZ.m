//
//  UITableViewController+CellItemsEZ.m
//  Akay
//
//  Created by Ken M. Haggerty on 8/29/16.
//  Copyright © 2016 Eureka Valley Co. All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "UITableViewController+CellItemsEZ.h"

#pragma mark - // DEFINITIONS (Private) //

@implementation UITableViewController (CellItemsEZ)

#pragma mark - // SETTERS AND GETTERS //

#pragma mark - // INITS AND LOADS //

#pragma mark - // PUBLIC METHODS //

- (nullable NSArray <CellItem *> *)cellItems {
    NSArray *cellItems = [self tableView:self.tableView cellItemsForSection:0];
    if (cellItems) {
        return cellItems;
    }
    
    self.cellItems = [NSArray array];
    return self.cellItems;
}

- (void)setCellItems:(nullable NSArray <CellItem *> *)cellItems {
    [self tableView:self.tableView setCellItems:cellItems forSection:0];
}

- (nullable NSArray *)objects {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:self.cellItems.count];
    CellItem *cellItem;
    id object;
    for (int i = 0; i < self.cellItems.count; i++) {
        cellItem = self.cellItems[i];
        object = cellItem.object;
        [objects addObject:object];
    }
    return [NSArray arrayWithArray:objects];
}

- (NSUInteger)indexOfObject:(nonnull id)object {
    return [self.objects indexOfObject:object];
}

- (nullable UITableViewCell *)cellForItem:(nonnull CellItem *)cellItem {
    if (![self.cellItems containsObject:cellItem]) {
        return nil;
    }
    
    NSUInteger index = [self.cellItems indexOfObject:cellItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    return [self.tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - // CATEGORY METHODS //

#pragma mark - // DELEGATED METHODS //

#pragma mark - // OVERWRITTEN METHODS //

#pragma mark - // PRIVATE METHODS //

@end
