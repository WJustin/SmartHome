//
//  NVMStringAttribute+LineBreak.h
//  Pods
//
//  Created by Karl Peng on 7/12/16.
//
//

#import "NVMStringAttribute.h"
#import "NVMAttributesMaker.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NVMStringAttributeLineBreak <NSObject>

- (NVMStringAttribute * (^)(void))breakByWordWrapping;
- (NVMStringAttribute * (^)(void))breakByCharWrapping;
- (NVMStringAttribute * (^)(void))breakByClipping;
- (NVMStringAttribute * (^)(void))breakByTruncatingHead;
- (NVMStringAttribute * (^)(void))breakByTruncatingTail;
- (NVMStringAttribute * (^)(void))breakByTruncatingMiddle;

@end

NS_ASSUME_NONNULL_END

@interface NVMStringAttribute (LineBreak) <NVMStringAttributeLineBreak>

@end

@interface NVMAttributesMaker (LineBreak) <NVMStringAttributeLineBreak>

@end
