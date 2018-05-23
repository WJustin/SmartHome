//
//  SMHMQManager.h
//  SmartHome
//
//  Created by Justin.wang on 2018/5/23.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMHMQManager : NSObject

+ (SMHMQManager *)shareManager;

@property (nonatomic, copy) NSString *groupId;

@end
