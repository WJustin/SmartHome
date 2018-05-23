//
//  NVMStringAttribute+Match.h
//  Pods
//
//  Created by Karl Peng on 7/13/16.
//
//

#import "NVMStringAttribute.h"

@interface NVMStringAttribute (Match)

- (NVMStringAttribute * (^)(NSString *substring))matchSubstring;
- (NVMStringAttribute * (^)(NSString *pattern))matchRegex;

- (NVMStringAttribute * (^)())matchNumber;

// 匹配半角的人民币¥\d+(.\d+)?
- (NVMStringAttribute * (^)())matchPrice;

@end
