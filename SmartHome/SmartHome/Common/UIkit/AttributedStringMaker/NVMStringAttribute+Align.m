//
//  NVMStringAttribute+Align.m
//  Pods
//
//  Created by Karl Peng on 7/12/16.
//
//

#import "NVMStringAttribute+Align.h"

@implementation NVMStringAttribute (Align)

- (NVMStringAttribute * _Nonnull (^)(void))alignLeft {
  return ^{
    return self.alignment(NSTextAlignmentLeft);
  };
}

- (NVMStringAttribute * _Nonnull (^)(void))alignCenter {
  return ^{
    return self.alignment(NSTextAlignmentCenter);
  };
}

- (NVMStringAttribute * _Nonnull (^)(void))alignRight {
  return ^{
    return self.alignment(NSTextAlignmentRight);
  };
}

- (NVMStringAttribute * _Nonnull (^)(void))alignNatural {
  return ^{
    return self.alignment(NSTextAlignmentNatural);
  };
}

- (NVMStringAttribute * _Nonnull (^)(void))alignJustified {
  return ^{
    return self.alignment(NSTextAlignmentJustified);
  };
}


@end
