//
//  NVMStringAttribute+Range.m
//  Pods
//
//  Created by Karl Peng on 7/13/16.
//
//

#import "NVMStringAttribute+Range.h"

@implementation NVMStringAttribute (Range)

- (NVMStringAttribute * _Nonnull (^)(NSRange))onRange {
  return ^(NSRange range) {
    self.onRanges(@[[NSValue valueWithRange:range]]);
    return self;
  };
}

- (NVMStringAttribute * _Nonnull (^)(void))onFullRange {
  return ^(void) {
    self.onRanges(nil);
    return self;
  };
}

@end
