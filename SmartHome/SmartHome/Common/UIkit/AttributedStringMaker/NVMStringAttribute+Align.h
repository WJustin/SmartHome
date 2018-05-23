//
//  NVMStringAttribute+Align.h
//  Pods
//
//  Created by Karl Peng on 7/12/16.
//
//

#import "NVMStringAttribute.h"
#import "NVMAttributesMaker.h"

@class NVMStringAttribute;

NS_ASSUME_NONNULL_BEGIN

@protocol NVMStringAttributeAlign <NSObject>

- (NVMStringAttribute * (^)(void))alignLeft;
- (NVMStringAttribute * (^)(void))alignCenter;
- (NVMStringAttribute * (^)(void))alignRight;
- (NVMStringAttribute * (^)(void))alignJustified;
- (NVMStringAttribute * (^)(void))alignNatural;

@end

NS_ASSUME_NONNULL_END

@interface NVMStringAttribute (Align) <NVMStringAttributeAlign>

@end

@interface NVMAttributesMaker (Align) <NVMStringAttributeAlign>

@end