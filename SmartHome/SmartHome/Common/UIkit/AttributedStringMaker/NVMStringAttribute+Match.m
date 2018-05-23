//
//  NVMStringAttribute+Match.m
//  Pods
//
//  Created by Karl Peng on 7/13/16.
//
//

#import "NVMStringAttribute+Match.h"

@implementation NVMStringAttribute (Match)

- (NVMStringAttribute *(^)(NSString *))matchSubstring {
  return ^(NSString *substring) {
    return self.match(substring, NSCaseInsensitiveSearch);
  };
}

- (NVMStringAttribute *(^)(NSString *))matchRegex {
  return ^(NSString *pattern) {
    return self.match(pattern, NSRegularExpressionSearch);
  };
}

- (NVMStringAttribute *(^)())matchNumber {
  return ^(void) {
    return self.matchRegex(@"\\d+(.\\d+)?");
  };
}

- (NVMStringAttribute *(^)())matchPrice {
  return ^(void) {
    return self.matchRegex(@"¥\\d+(.\\d+)?");
  };
}

@end
