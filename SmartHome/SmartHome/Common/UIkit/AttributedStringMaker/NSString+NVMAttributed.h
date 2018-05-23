//
//  NSString+NVMAttributed.h
//  Pods
//
//  Created by Karl Peng on 7/11/16.
//
//

#import <Foundation/Foundation.h>

@class NVMAttributesMaker;

@interface NSString (NVMAttributesMaker)

// not a good name, but a little shorter.
- (NSMutableAttributedString *)nvm_makeAttributedString:(void(^)(NVMAttributesMaker *make))block;

@end
