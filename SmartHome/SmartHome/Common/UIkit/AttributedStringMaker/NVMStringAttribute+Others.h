//
//  NVMStringAttribute+Others.h
//  Pods
//
//  Created by Karl Peng on 7/12/16.
//
//

#import "NVMAttributesMaker.h"
#import "NVMStringAttribute.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NVMStringAttributeOthers <NSObject>

- (NVMStringAttribute * (^)(CGFloat))fontSize;
- (NVMStringAttribute * (^)(CGFloat))boldFontSize;

- (NVMStringAttribute * (^)(UIColor *color))singleUnderLine;
- (NVMStringAttribute * (^)(UIColor *color))singleStrikeThrough;

@end

NS_ASSUME_NONNULL_END

@interface NVMStringAttribute (Others) <NVMStringAttributeOthers>

@end

@interface NVMAttributesMaker (Others) <NVMStringAttributeOthers>

@end
