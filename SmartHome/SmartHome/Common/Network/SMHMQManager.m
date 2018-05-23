//
//  SMHMQManager.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/23.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHMQManager.h"
#import <MQTTClient/MQTTClient.h>
#import <CommonCrypto/CommonHMAC.h>

@interface SMHMQManager ()

@property (nonatomic, strong) MQTTSessionManager *manager;

@end

@implementation SMHMQManager

+ (SMHMQManager *)shareManager {
    static SMHMQManager *shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}

- (void)connect {
    if (self.manager) {
        [self.manager connectToLast:nil];
    } else {
        NSString *clientId = [NSString stringWithFormat:@"%@@@@%@", self.groupId, @"DEVICE_001"];
        [self.manager connectTo:nil
                           port:0
                            tls:YES
                      keepalive:60
                          clean:YES
                           auth:YES
                           user:@""
                           pass:@""
                           will:NO
                      willTopic:nil
                        willMsg:nil
                        willQos:0
                 willRetainFlag:NO
                   withClientId:clientId
                 securityPolicy:nil
                   certificates:nil
                  protocolLevel:MQTTProtocolVersion50 connectHandler:nil];
    }
    [self.manager addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(state))
                      options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                      context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    switch (self.manager.state) {
        case MQTTSessionManagerStateClosed:
      
            break;
        case MQTTSessionManagerStateClosing:
          
            break;
        case MQTTSessionManagerStateConnected:
          
            break;
        case MQTTSessionManagerStateConnecting:
        
            break;
        case MQTTSessionManagerStateError:
     
            break;
        case MQTTSessionManagerStateStarting:
        default:
          
            break;
    }
}

+ (NSString *)macSignWithText:(NSString *)text secretKey:(NSString *)secretKey {
    NSData *saltData = [secretKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData *paramData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1,
           saltData.bytes,
           saltData.length,
           paramData.bytes,
           paramData.length,
           hash.mutableBytes);
    NSString *base64Hash = [hash base64EncodedStringWithOptions:0];
    return base64Hash;
}

@end
