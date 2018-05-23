//
//  NVMStringAttribute+LineBreak.m
//  Pods
//
//  Created by Karl Peng on 7/12/16.
//
//

#import "NVMStringAttribute+LineBreak.h"

@implementation NVMStringAttribute (LineBreak)

- (NVMStringAttribute *(^)(void))breakByWordWrapping {
  return ^{
    return self.lineBreak(NSLineBreakByWordWrapping);
  };
}

- (NVMStringAttribute *(^)(void))breakByCharWrapping {
  return ^{
    return self.lineBreak(NSLineBreakByCharWrapping);
  };
}

- (NVMStringAttribute *(^)(void))breakByClipping {
  return ^{
    return self.lineBreak(NSLineBreakByClipping);
  };
}

- (NVMStringAttribute *(^)(void))breakByTruncatingHead {
  return ^{
    return self.lineBreak(NSLineBreakByTruncatingHead);
  };
}

- (NVMStringAttribute *(^)(void))breakByTruncatingTail {
  return ^{
    return self.lineBreak(NSLineBreakByTruncatingTail);
  };
}

- (NVMStringAttribute *(^)(void))breakByTruncatingMiddle {
  return ^{
    return self.lineBreak(NSLineBreakByTruncatingMiddle);
  };
}

@end
