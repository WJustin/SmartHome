//
//  NVMAttributesMaker.m
//
//  Created by Karl Peng on 15/12/10.
//

#import "NVMAttributesMaker.h"
#import "NVMStringAttribute.h"
#import "NSString+NVMAttributed.h"
#import <objc/runtime.h>

static Class NVMAttributeClass = nil;

@interface NVMAttributesMaker ()

@property (nonatomic, strong) NSMutableArray <NVMStringAttribute *> *_attributes;

@end

@implementation NVMAttributesMaker
@dynamic attributes;

+ (void)registerAtrributeClass:(Class)attributeClass {
  NVMAttributeClass = attributeClass;
}

- (NVMStringAttribute *)aNewStringAttribute {
  return [NVMAttributeClass new] ?: [NVMStringAttribute new];
}

- (NSMutableArray<NVMStringAttribute *> *)_attributes {
  if (!__attributes) {
    __attributes = [NSMutableArray array];
  }
  
  return __attributes;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
  NVMStringAttribute *attribute = [self aNewStringAttribute];
  if ([attribute respondsToSelector:aSelector]) {
    [self._attributes addObject:attribute];
    return attribute;
  } else {
    NSAssert(NO, @"implement the selector in attributeClass");
  }
  
  return nil;
}

- (NSArray *)attributes {
  return [self._attributes copy];
}

@end
