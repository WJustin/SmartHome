//
//  NVMStringAttribute.h
//  Pods
//
//  Created by Karl Peng on 7/11/16.
//
//

#import <Foundation/Foundation.h>
#import "NVMAttributesMaker.h"

/* This class should only contain primitive methods backed by a private property.
 * Other derivative methods can use a category like 'NVMStringAttribute+LineBreak' to separate them.
 */

@class NVMStringAttribute;

NS_ASSUME_NONNULL_BEGIN

@protocol NVMStringAttribute <NSObject>

#pragma mark - ParagraphStyle

// set this discard other style property like alignment,lineBreak and lineSpacing.
- (NVMStringAttribute * (^)(NSParagraphStyle *style))paragraphStyle;

- (NVMStringAttribute * (^)(NSTextAlignment alignment))alignment;
- (NVMStringAttribute * (^)(NSLineBreakMode breakMode))lineBreak;
- (NVMStringAttribute * (^)(CGFloat lineSpacing))lineSpacing;

#pragma mark - TextAttribute

- (NVMStringAttribute * (^)(UIColor *color))color;
- (NVMStringAttribute * (^)(UIColor *color))backgroundColor;
- (NVMStringAttribute * (^)(UIFont *font))font;

// UnderLine
- (NVMStringAttribute * (^)(UIColor *color))underLineColor;
- (NVMStringAttribute * (^)(NSUnderlineStyle style))underLineStyle;

// StrikeThrough
- (NVMStringAttribute * (^)(UIColor *color))strikeThroughColor;
- (NVMStringAttribute * (^)(NSUnderlineStyle style))strikeThroughStyle;

- (NVMStringAttribute * (^)(CGFloat offset))baseline;

/**
 * onRanges<match<regexMatch, priority lower to higher, set higher one discard others.
 */

#pragma mark - range
- (NVMStringAttribute * (^)( NSArray * _Nullable ranges))onRanges;

#pragma mark - match

// set this discard ranges
- (NVMStringAttribute * (^)(NSString * _Nullable searchString, NSStringCompareOptions options))match;

@end

@interface NVMStringAttribute : NSObject <NVMStringAttribute>

- (NSDictionary *)currentTextAttributes;
- (NSParagraphStyle *)currentParagraphStyle;

@end

@interface NVMAttributesMaker (Base) <NVMStringAttribute>

@end

@interface NSMutableAttributedString (NVMStringAttribute)

- (void)nvm_applyAttribute:(NVMStringAttribute *)attribute;

@end

@interface NSString (NVMMatchRanges)

- (NSArray *)mim_rangesOfString:(NSString *)searchString options:(NSStringCompareOptions)mask;

@end

NS_ASSUME_NONNULL_END
