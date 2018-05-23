//
//  NVMAttributesMaker.h
//
//  Created by Karl Peng on 15/12/10.
//
//

#import <Foundation/Foundation.h>
@class NVMStringAttribute;

@interface NVMAttributesMaker : NSObject

+ (void)registerAtrributeClass:(Class)attributeClass;

@property (nonatomic, copy, readonly) NSArray <NVMStringAttribute *> *attributes;

@end
