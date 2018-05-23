//
//  NVMStringAttribute+Others.m
//  Pods
//
//  Created by Karl Peng on 7/12/16.
//
//

#import "NVMStringAttribute+Others.h"

@implementation NVMStringAttribute (Others)

- (NVMStringAttribute * (^)(CGFloat))fontSize {
  return ^(CGFloat size) {
    return self.font([UIFont systemFontOfSize:size]);
  };
}

- (NVMStringAttribute * (^)(CGFloat))boldFontSize {
  return ^(CGFloat size) {
    return self.font([UIFont boldSystemFontOfSize:size]);
  };
}

- (NVMStringAttribute * (^)(UIColor *color))singleStrikeThrough {
  return ^(UIColor *color) {
    return self.strikeThroughStyle(NSUnderlineStyleSingle).strikeThroughColor(color);
  };
}


- (NVMStringAttribute * (^)(UIColor *color))singleUnderLine {
  return ^(UIColor *color) {
    return self.underLineStyle(NSUnderlineStyleSingle).underLineColor(color);
  };
}

@end
