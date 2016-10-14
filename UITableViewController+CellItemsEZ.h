//
//  UITableViewController+CellItemsEZ.h
//  Akay
//
//  Created by Ken M. Haggerty on 8/29/16.
//  Copyright © 2016 Eureka Valley Co. All rights reserved.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import <UIKit/UIKit.h>
#import "UITableViewController+CellItems.h"

#pragma mark - // PROTOCOLS //

#pragma mark - // DEFINITIONS (Public) //

@interface UITableViewController (CellItemsEZ)
- (nullable NSArray <CellItem *> *)cellItems;
- (void)setCellItems:(nullable NSArray <CellItem *> *)cellItems;
- (nullable NSArray *)objects;
- (NSUInteger)indexOfObject:(nonnull id)object;
- (nullable UITableViewCell *)cellForItem:(nonnull CellItem *)cellItem;
@end
