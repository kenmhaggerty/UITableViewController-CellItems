//
//  UITableViewController+CellItems.h
//  UITableViewController+CellItems
//
//  Created by Ken M. Haggerty on 7/11/16.
//  Copyright © 2016 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import <UIKit/UIKit.h>

#import "CellItem.h"

#pragma mark - // PROTOCOLS //

@protocol CellItemTableViewController <NSObject>
- (void)addObserversToCellItem:(nonnull CellItem *)cellItem;
- (void)removeObserversFromCellItem:(nonnull CellItem *)cellItem;
@end

#pragma mark - // DEFINITIONS (Public) //

@interface UITableViewController (CellItems)
- (nullable NSArray <CellItem *> *)tableView:(nonnull UITableView *)tableView cellItemsForSection:(NSInteger)section;
- (void)tableView:(nonnull UITableView *)tableView setCellItems:(nullable NSArray <CellItem *> *)cellItems forSection:(NSInteger)section;
- (nonnull CellItem *)tableView:(nonnull UITableView *)tableView cellItemForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (nonnull NSArray <NSIndexPath *> *)tableView:(nonnull UITableView *)tableView indexPathsForCellItem:(nonnull CellItem *)cellItem;
- (nonnull NSArray <CellItem *> *)cellItemsForObjects:(nonnull NSArray *)objects withSetter:(nonnull CellItem * _Nonnull (^)(id _Nonnull obj))setter;
- (nullable NSArray *)tableView:(nonnull UITableView *)tableView objectsForSection:(NSUInteger)section;
@end
