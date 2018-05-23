//
//  NVMStringAttribute+Range.h
//  Pods
//
//  Created by Karl Peng on 7/13/16.
//
//

#import "NVMStringAttribute.h"
#import "NVMAttributesMaker.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NVMStringAttributeRange <NSObject>

- (NVMStringAttribute * (^)(void))onFullRange;
- (NVMStringAttribute * (^)(NSRange range))onRange;

@end

NS_ASSUME_NONNULL_END

@interface NVMStringAttribute (Range) <NVMStringAttributeRange>

@end

@interface NVMAttributesMaker (Range) <NVMStringAttributeRange>

@end
