//
//  NVMStringAttribute.m
//  Pods
//
//  Created by Karl Peng on 7/11/16.
//
//

#import "NVMStringAttribute.h"

@interface NVMStringAttribute ()

/* Use _ to decalare a private backing property, maybe conflict with apple's guideline,
 * but just OK here.
 */

#pragma mark - ParagraphStyle
@property (nonatomic, strong) NSParagraphStyle *_paragraphStyle;
@property (nonatomic, strong) NSNumber *_lineBreakMode;
@property (nonatomic, strong) NSNumber *_alignment;
@property (nonatomic, strong) NSNumber *_lineSpacing;

#pragma mark - TextAttribute
@property (nonatomic, strong) UIColor *_foregroundColor;
@property (nonatomic, strong) UIColor *_backgroundColor;
@property (nonatomic, strong) UIFont *_font;

@property (nonatomic, strong) UIColor *_underLineColor;
@property (nonatomic, strong) NSNumber *_underlineStyle;

@property (nonatomic, strong) UIColor *_strikeThroughColor;
@property (nonatomic, strong) NSNumber *_strikeThroughStyle;

@property (nonatomic, strong) NSNumber *_baselineOffset;

@property (nonatomic, copy) NSArray *_ranges;

@property (nonatomic, copy) NSString *_searchString;
@property (nonatomic, assign) NSStringCompareOptions _compareOptions;

@end

@implementation NVMStringAttribute

#pragma mark - ParagraphStyle

- (NVMStringAttribute * _Nonnull (^)(NSParagraphStyle * _Nonnull))paragraphStyle {
  return ^(NSParagraphStyle *style) {
    self._paragraphStyle = style;
    return self;
  };
}

- (NVMStringAttribute * _Nonnull (^)(NSLineBreakMode))lineBreak {
  return ^(NSLineBreakMode lineBreakMode) {
    self._lineBreakMode = @(lineBreakMode);
    return self;
  };
}

- (NVMStringAttribute * (^)(NSTextAlignment alignment))alignment {
  return ^(NSTextAlignment alignment) {
    self._alignment = @(alignment);
    return self;
  };
}

- (NVMStringAttribute * _Nonnull (^)(CGFloat))lineSpacing {
  return ^(CGFloat lineSpacing) {
    self._lineSpacing = @(lineSpacing);
    return self;
  };
}

#pragma mark - Font Color

- (NVMStringAttribute * _Nonnull (^)(UIColor * _Nonnull))color {
  return ^(UIColor *color) {
    self._foregroundColor = color;
    return self;
  };
}

- (NVMStringAttribute * _Nonnull (^)(UIColor * _Nonnull))backgroundColor {
  return ^(UIColor *color) {
    self._backgroundColor = color;
    return self;
  };
}

- (NVMStringAttribute * _Nonnull (^)(UIFont * _Nonnull))font {
  return ^(UIFont *font) {
    self._font = font;
    return self;
  };
}

# pragma mark  - UnderLine + Baseline + StrikeThroughColor

- (NVMStringAttribute * _Nonnull (^)(UIColor * _Nonnull))underLineColor {
  return ^(UIColor *underLineColor) {
    self._underLineColor = underLineColor;
    return self;
  };
}

- (NVMStringAttribute * _Nonnull (^)(NSUnderlineStyle))underLineStyle {
  return ^(NSUnderlineStyle style) {
    self._underlineStyle = @(style);
    return self;
  };
}

- (NVMStringAttribute * _Nonnull (^)(CGFloat))baseline {
  return ^(CGFloat baselineOffset) {
    self._baselineOffset = @(baselineOffset);
    return self;
  };
}

- (NVMStringAttribute * _Nonnull (^)(UIColor * _Nonnull))strikeThroughColor {
  return ^(UIColor *color) {
    self._strikeThroughColor = color;
    return self;
  };
}

- (NVMStringAttribute * _Nonnull (^)(NSUnderlineStyle))strikeThroughStyle {
  return ^(NSUnderlineStyle style) {
    self._strikeThroughStyle = @(style);
    return self;
  };
}

# pragma mark - range

- (NVMStringAttribute * _Nonnull (^)(NSArray * _Nullable))onRanges {
  return ^(NSArray *ranges) {
    self._ranges = ranges;
    return self;
  };
}

# pragma mark - match

- (NVMStringAttribute * _Nonnull (^)(NSString * _Nullable, NSStringCompareOptions))match {
  return ^(NSString *searchString, NSStringCompareOptions options) {
    self._searchString = searchString;
    self._compareOptions = options;
    return self;
  };
}

# pragma mark - utils

- (NSDictionary *)attributesInfo {
  NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
  
  [attributes setValue:[self currentParagraphStyle] forKey:NSParagraphStyleAttributeName];
  [attributes addEntriesFromDictionary:[self currentTextAttributes]];
  
  return attributes;
}

- (NSDictionary *)currentTextAttributes {
  NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
  
  [attributes setValue:self._font forKey:NSFontAttributeName];
  [attributes setValue:self._foregroundColor forKey:NSForegroundColorAttributeName];
  [attributes setValue:self._backgroundColor forKey:NSBackgroundColorAttributeName];
  [attributes setValue:self._underLineColor forKey:NSUnderlineColorAttributeName];
  [attributes setValue:self._underlineStyle forKey:NSUnderlineStyleAttributeName];
  [attributes setValue:self._baselineOffset forKey:NSBaselineOffsetAttributeName];
  [attributes setValue:self._strikeThroughColor forKey:NSStrikethroughColorAttributeName];
  [attributes setValue:self._strikeThroughStyle forKey:NSStrikethroughStyleAttributeName];
  
  return attributes;
}

- (NSParagraphStyle *)currentParagraphStyle {
  if (self._paragraphStyle) {
    return self._paragraphStyle;
  }
  
  // ParagraphStyle
  NSMutableParagraphStyle *style = nil;
  if (self._lineBreakMode || self._alignment || self._lineSpacing) {
    // mo useless style
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
  }
  if (self._lineBreakMode) {
    style.lineBreakMode = self._lineBreakMode.integerValue;
  }
  if (self._alignment) {
    style.alignment = self._alignment.integerValue;
  }
  
  if (self._lineSpacing) {
    style.lineSpacing = self._lineSpacing.floatValue;
  }
  
  return style;
}

@end

@implementation NSMutableAttributedString (NVMStringAttribute)

- (void)nvm_applyAttribute:(NVMStringAttribute *)attribute {
  NSDictionary *attributesInfo = [attribute attributesInfo];
  
  if (attribute._searchString) {
    NSArray *ranges = [self.string mim_rangesOfString:attribute._searchString
                                              options:attribute._compareOptions];
    [self nvm_applyAttributes:attributesInfo onRanges:ranges];
    return;
  }
  
  NSArray *ranges = attribute._ranges;
  NSValue *fullRange = [NSValue valueWithRange:NSMakeRange(0, self.string.length)];
  [self nvm_applyAttributes:attributesInfo
                   onRanges:ranges.count ? ranges : @[ fullRange ]];
}

- (void)nvm_applyAttributes:(NSDictionary *)attributes onRanges:(NSArray *)ranges {
  for (NSValue *range in ranges) {
    [self addAttributes:attributes range:[range rangeValue]];
  }
}

@end

@implementation NSString (NVMMatchRanges)

- (NSArray *)mim_rangesOfString:(NSString *)searchString options:(NSStringCompareOptions)mask {
  NSMutableArray *ranges = [NSMutableArray array];
  NSRange range = [self rangeOfString:searchString options:mask];
  while (range.location != NSNotFound) {
    [ranges addObject:[NSValue valueWithRange:range]];
    NSRange searchRange = NSMakeRange(range.location + 1, self.length - range.location - 1);
    range = [self rangeOfString:searchString options:mask range:searchRange];
  }
  
  return ranges;
}

@end
