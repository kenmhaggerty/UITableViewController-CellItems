//
//  CellItem.m
//  UITableViewController+CellItems
//
//  Created by Ken M. Haggerty on 7/3/16.
//  Copyright © 2016 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "CellItem.h"
#import "KMHGenerics.h"

#pragma mark - // DEFINITIONS (Private) //

NSString * const CellItemNotificationObjectKey = @"object";

NSString * const CellItemReuseIdentifierDidChangeNotification = @"kCellItemReuseIdentifierDidChangeNotification";
NSString * const CellItemStyleDidChangeNotification = @"kCellItemReuseIdentifierDidChangeNotification";
NSString * const CellItemTextDidChangeNotification = @"kCellItemTextDidChangeNotification";
NSString * const CellItemDetailTextDidChangeNotification = @"kCellItemDetailTextDidChangeNotification";
NSString * const CellItemImageDidChangeNotification = @"kCellItemImageDidChangeNotification";
NSString * const CellItemAccessoryViewVisibilityDidChangeNotification = @"kCellItemAccessoryViewVisibilityDidChangeNotification";
NSString * const CellItemHeightDidChangeNotification = @"kCellItemHeightDidChangeNotification";
NSString * const CellItemMoveableDidChangeNotification = @"kCellItemMoveableDidChangeNotification";
NSString * const CellItemEditableDidChangeNotification = @"kCellItemEditableDidChangeNotification";
NSString * const CellItemShouldBeRefreshedNotification = @"kCellItemShouldBeRefreshedNotification";
NSString * const CellItemShouldBeDeletedNotification = @"kCellItemShouldBeDeletedNotification";

@interface CellItem ()
- (void)setToDefaults;
@end

@implementation CellItem

#pragma mark - // SETTERS AND GETTERS //

- (void)setReuseIdentifier:(NSString *)reuseIdentifier {
    if ([KMHGenerics object:reuseIdentifier isEqualToObject:self.reuseIdentifier]) {
        return;
    }
    
    _reuseIdentifier = reuseIdentifier;
    
    NSDictionary *userInfo = @{CellItemNotificationObjectKey : reuseIdentifier};
    [NSNotificationCenter postNotificationToMainThread:CellItemReuseIdentifierDidChangeNotification object:self userInfo:userInfo];
}

- (void)setStyle:(UITableViewCellStyle)style {
    if (style == self.style) {
        return;
    }
    
    _style = style;
    
    NSDictionary *userInfo = @{CellItemNotificationObjectKey : @(style)};
    [NSNotificationCenter postNotificationToMainThread:CellItemStyleDidChangeNotification object:self userInfo:userInfo];
}

- (void)setText:(NSString *)text {
    if ([KMHGenerics object:text isEqualToObject:self.text]) {
        return;
    }
    
    _text = text;
    
    NSDictionary *userInfo = text ? @{CellItemNotificationObjectKey : text} : @{};
    [NSNotificationCenter postNotificationToMainThread:CellItemTextDidChangeNotification object:self userInfo:userInfo];
}

- (void)setDetailText:(NSString *)detailText {
    if ([KMHGenerics object:detailText isEqualToObject:self.detailText]) {
        return;
    }
    
    _detailText = detailText;
    
    NSDictionary *userInfo = detailText ? @{CellItemNotificationObjectKey : detailText} : @{};
    [NSNotificationCenter postNotificationToMainThread:CellItemDetailTextDidChangeNotification object:self userInfo:userInfo];
}

- (void)setImage:(UIImage *)image {
    if ([KMHGenerics object:image isEqualToObject:self.image]) {
        return;
    }
    
    _image = image;
    
    NSDictionary *userInfo = image ? @{CellItemNotificationObjectKey : image} : @{};
    [NSNotificationCenter postNotificationToMainThread:CellItemImageDidChangeNotification object:self userInfo:userInfo];
}

- (void)setAccessoryViewVisible:(BOOL)accessoryViewVisible {
    if (accessoryViewVisible == self.accessoryViewVisible) {
        return;
    }
    
    _accessoryViewVisible = accessoryViewVisible;
    
    NSDictionary *userInfo = @{CellItemNotificationObjectKey : @(accessoryViewVisible)};
    [NSNotificationCenter postNotificationToMainThread:CellItemAccessoryViewVisibilityDidChangeNotification object:self userInfo:userInfo];
}

- (void)setHeight:(CGFloat)height {
    if (height == self.height) {
        return;
    }
    
    _height = height;
    
    NSDictionary *userInfo = @{CellItemNotificationObjectKey : @(height)};
    [NSNotificationCenter postNotificationToMainThread:CellItemHeightDidChangeNotification object:self userInfo:userInfo];
}

- (void)setMoveable:(BOOL)moveable {
    if (moveable == self.moveable) {
        return;
    }
    
    _moveable = moveable;
    
    NSDictionary *userInfo = @{CellItemNotificationObjectKey : @(moveable)};
    [NSNotificationCenter postNotificationToMainThread:CellItemMoveableDidChangeNotification object:self userInfo:userInfo];
}

#pragma mark - // INITS AND LOADS //

- (id)initWithText:(NSString *)text detailText:(NSString *)detailText {
    self = [super init];
    if (self) {
        [self setup];
        
        self.text = text;
        self.detailText = detailText;
    }
    return self;
}

- (id)init {
    return [self initWithText:nil detailText:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

#pragma mark - // PUBLIC METHODS //

- (void)setToDefaults {
    self.reuseIdentifier = nil;
    self.style = UITableViewCellStyleDefault;
    self.object = nil;
    self.text = nil;
    self.detailText = nil;
    self.image = nil;
    self.accessoryViewVisible = NO;
    self.height = [UITableViewCell defaultHeight];
    self.estimatedHeight = [UITableViewCell defaultHeight];
    self.editable = YES;
    self.moveable = YES;
}

#pragma mark - // CATEGORY METHODS //

#pragma mark - // DELEGATED METHODS //

#pragma mark - // OVERWRITTEN METHODS //

- (void)setup:(void (^)(void))block {
    [super setup:^{
        [self setToDefaults];
        
        if (block) {
            block();
        }
    }];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p; %@ = %@; %@ = %@; %@ = %p>", [self class], self, NSStringFromSelector(@selector(text)), self.text, NSStringFromSelector(@selector(detailText)), self.detailText, NSStringFromSelector(@selector(object)), self.object];
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    CellItem *cellItem = (CellItem *)object;
    if ([KMHGenerics object:self.object isEqualToObject:cellItem.object]) {
        return YES;
    }
    
    return [KMHGenerics object:self.reuseIdentifier isEqualToObject:cellItem.reuseIdentifier]
        && (self.style == cellItem.style)
        && [KMHGenerics object:self.text isEqualToObject:cellItem.text]
        && [KMHGenerics object:self.detailText isEqualToObject:cellItem.detailText]
    && [KMHGenerics object:self.image isEqualToObject:cellItem.image];
//        && (self.accessoryViewIsVisible == cellItem.accessoryViewIsVisible)
//        && (self.height == cellItem.height)
//        && (self.estimatedHeight == cellItem.estimatedHeight)
//        && (self.isMoveable == cellItem.isMoveable)
//        && (self.isEditable == cellItem.isEditable);
}

- (NSUInteger)hash {
    return self.reuseIdentifier.hash
        ^ self.style
        ^ self.object.hash
        ^ self.text.hash
        ^ self.detailText.hash
        ^ self.image.hash
        ^ self.accessoryViewVisible
        ^ @(self.height).hash
        ^ @(self.estimatedHeight).hash
        ^ self.isMoveable
        ^ self.isEditable;
}

#pragma mark - // PRIVATE METHODS //

@end
