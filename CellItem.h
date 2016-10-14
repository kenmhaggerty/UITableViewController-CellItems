//
//  CellItem.h
//  UITableViewController+CellItems
//
//  Created by Ken M. Haggerty on 7/3/16.
//  Copyright © 2016 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import <UIKit/UIKit.h>

#pragma mark - // PROTOCOLS //

#pragma mark - // DEFINITIONS (Public) //

extern NSString * const CellItemNotificationObjectKey;

extern NSString * const CellItemReuseIdentifierDidChangeNotification;
extern NSString * const CellItemStyleDidChangeNotification;
extern NSString * const CellItemTextDidChangeNotification;
extern NSString * const CellItemDetailTextDidChangeNotification;
extern NSString * const CellItemImageDidChangeNotification;
extern NSString * const CellItemAccessoryViewVisibilityDidChangeNotification;
extern NSString * const CellItemHeightDidChangeNotification;
extern NSString * const CellItemMoveableDidChangeNotification;
extern NSString * const CellItemEditableDidChangeNotification;
extern NSString * const CellItemShouldBeRefreshedNotification;
extern NSString * const CellItemShouldBeDeletedNotification;

@interface CellItem : NSObject
@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic) UITableViewCellStyle style;
@property (nonatomic, weak) NSObject *object;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, getter=accessoryViewIsVisible) BOOL accessoryViewVisible;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat estimatedHeight;
@property (nonatomic, getter=isMoveable) BOOL moveable;
@property (nonatomic, getter=isEditable) BOOL editable;
- (id)initWithText:(NSString *)text detailText:(NSString *)detailText;
- (void)setToDefaults;
@end
