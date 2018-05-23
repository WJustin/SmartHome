//
//  NSString+NVMAttributed.m
//  Pods
//
//  Created by Karl Peng on 7/11/16.
//
//

#import "NSString+NVMAttributed.h"
#import "NVMAttributesMaker.h"
#import "NVMStringAttribute.h"

@implementation NSString (NVMAttributesMaker)

- (NSMutableAttributedString *)nvm_makeAttributedString:(void (^)(NVMAttributesMaker *))block {
  if (!block) {
    return nil;
  }
  
  NVMAttributesMaker *make = [NVMAttributesMaker new];
  block(make);
  
  NSArray <NVMStringAttribute *> *attributes = make.attributes;
  NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self];
  
  for (NVMStringAttribute *stringAttribute in attributes) {
    [text nvm_applyAttribute:stringAttribute];
  }
  
  return text;
}

@end