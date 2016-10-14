//
//  UITableViewController+CellItems.m
//  UITableViewController+CellItems
//
//  Created by Ken M. Haggerty on 7/11/16.
//  Copyright © 2016 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "UITableViewController+CellItems.h"
#import <objc/runtime.h>

#pragma mark - // DEFINITIONS (Private) //

@implementation UITableViewController (CellItems)

#pragma mark - // SETTERS AND GETTERS //

- (void)setTableViews:(nonnull NSMutableOrderedSet *)tableViews {
    objc_setAssociatedObject(self, @selector(tableViews), tableViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (nonnull NSMutableOrderedSet *)tableViews {
    NSMutableOrderedSet *tableViews = objc_getAssociatedObject(self, @selector(tableViews));
    if (tableViews) {
        return tableViews;
    }
    
    self.tableViews = [NSMutableOrderedSet orderedSet];
    return self.tableViews;
}

- (void)setTableViewDictionaries:(nonnull NSMutableDictionary *)tableViewDictionaries {
    objc_setAssociatedObject(self, @selector(tableViewDictionaries), tableViewDictionaries, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (nonnull NSMutableDictionary *)tableViewDictionaries {
    NSMutableDictionary *tableViewDictionaries = objc_getAssociatedObject(self, @selector(tableViewDictionaries));
    if (tableViewDictionaries) {
        return tableViewDictionaries;
    }
    
    self.tableViewDictionaries = [NSMutableDictionary dictionary];
    return self.tableViewDictionaries;
}

#pragma mark - // INITS AND LOADS //

#pragma mark - // PUBLIC METHODS //

- (nullable NSArray <CellItem *> *)tableView:(nonnull UITableView *)tableView cellItemsForSection:(NSInteger)section {
    NSDictionary *dictionary = [self dictionaryForTableView:tableView];
    if (!dictionary) {
        return nil;
    }
    
    id key = [self keyForSection:section inTableView:tableView];
    return dictionary[key];
}

- (void)tableView:(nonnull UITableView *)tableView setCellItems:(nullable NSArray <CellItem *> *)cellItems forSection:(NSInteger)section {
    NSMutableDictionary *dictionary = [self dictionaryForTableView:tableView];
    if (!dictionary) {
        dictionary = [NSMutableDictionary dictionary];
    }
    id key = [self keyForSection:section inTableView:tableView];
    
    NSArray <CellItem *> *primitiveCellItems = dictionary[key];
    if ([cellItems isEqualToArray:primitiveCellItems]) {
        [self setDictionary:dictionary forTableView:tableView];
        return;
    }
    
    NSMutableSet *removedItems = [NSMutableSet setWithArray:primitiveCellItems];
    [removedItems minusSet:[NSSet setWithArray:cellItems]];
    NSMutableSet *addedItems = [NSMutableSet setWithArray:cellItems];
    [addedItems minusSet:[NSSet setWithArray:primitiveCellItems]];
    
    if ([self respondsToSelector:@selector(removeObserversFromCellItem:)]) {
        for (CellItem *cellItem in removedItems) {
            [((id <CellItemTableViewController>)self) removeObserversFromCellItem:cellItem];
        }
    }
    
    [dictionary setObject:cellItems forKey:key];
    
    if ([self respondsToSelector:@selector(addObserversToCellItem:)]) {
        for (CellItem *cellItem in addedItems) {
            [((id <CellItemTableViewController>)self) addObserversToCellItem:cellItem];
        }
    }
    
    [self setDictionary:dictionary forTableView:tableView];
}

- (nonnull CellItem *)tableView:(UITableView *)tableView cellItemForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView cellItemsForSection:indexPath.section][indexPath.row];
}

- (nonnull NSArray <NSIndexPath *> *)tableView:(nonnull UITableView *)tableView indexPathsForCellItem:(nonnull CellItem *)cellItem {
    NSInteger section;
    NSArray *cellItems;
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (id key in [self dictionaryForTableView:tableView].allKeys) {
        section = [self sectionForKey:key inTableView:tableView];
        cellItems = [self tableView:tableView cellItemsForSection:section];
        for (int row = 0; row < cellItems.count; row++) {
            if ([cellItems[row] isEqual:cellItem]) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:section]];
            }
        }
    }
    return [NSArray arrayWithArray:indexPaths];
}

- (nonnull NSArray <CellItem *> *)cellItemsForObjects:(nonnull NSArray *)objects withSetter:(nonnull CellItem * _Nonnull (^)(id _Nonnull obj))setter {
    NSMutableArray *cellItems = [NSMutableArray arrayWithCapacity:objects.count];
    for (int i = 0; i < objects.count; i++) {
        [cellItems addObject:setter(objects[i])];
    }
    return [NSArray arrayWithArray:cellItems];
}

- (nullable NSArray *)tableView:(nonnull UITableView *)tableView objectsForSection:(NSUInteger)section {
    NSArray *cellItems = [self tableView:tableView cellItemsForSection:section];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:cellItems.count];
    CellItem *cellItem;
    id object;
    for (int i = 0; i < cellItems.count; i++) {
        cellItem = cellItems[i];
        object = cellItem.object;
        [objects addObject:object];
    }
    return [NSArray arrayWithArray:objects];
}

#pragma mark - // CATEGORY METHODS //

#pragma mark - // DELEGATED METHODS //

#pragma mark - // OVERWRITTEN METHODS //

#pragma mark - // PRIVATE METHODS //

#pragma mark - // PRIVATE METHODS (General) //

- (id)keyForTableView:(UITableView *)tableView {
    if ([self.tableViews containsObject:tableView]) {
        return [NSString stringWithFormat:@"%lu", (unsigned long)[self.tableViews indexOfObject:tableView]];
    }
    
    [self.tableViews addObject:tableView];
    return [self keyForTableView:tableView];
}

- (id)keyForSection:(NSInteger)section inTableView:(UITableView *)tableView {
    return [NSString stringWithFormat:@"%lu", (unsigned long)section];
}

- (NSInteger)sectionForKey:(id)key inTableView:(UITableView *)tableView {
    return ((NSString *)key).integerValue;
}

- (NSMutableDictionary *)dictionaryForTableView:(UITableView *)tableView {
    id key = [self keyForTableView:tableView];
    return self.tableViewDictionaries[key];
}

- (void)setDictionary:(NSMutableDictionary *)dictionary forTableView:(UITableView *)tableView {
    id key = [self keyForTableView:tableView];
    [self.tableViewDictionaries setObject:dictionary forKey:key];
}

@end
