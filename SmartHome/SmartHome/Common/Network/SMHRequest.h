//
//  SMHRequest.h
//  SmartHome
//
//  Created by Justin.wang on 2018/5/22.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN
@interface SMHSignInstance : NSObject

+ (SMHSignInstance *)shareInstance;

@property (nonatomic, copy) NSString *(^getUserIdBlock)(void);
@property (nonatomic, copy) NSString *(^getUserTokenBlock)(void);
@property (nonatomic, assign) NSInteger successCode;

- (NSDictionary *)signWithParams:(NSDictionary *)params;

@end

@interface SMHRequestModel : NSObject

@property (nonatomic, copy  , nullable) NSString     *requestUrl;     //请求地址
@property (nonatomic, copy  , nullable) NSDictionary *requestParams;  //请求参数
@property (nonatomic, assign) YTKRequestMethod requestMethod;   //请求方式 默认为Post
@property (nonatomic, assign) Class            bindClass;
@property (nonatomic, assign) NSInteger        cacheTimeInSeconds;
@property (nonatomic, copy  ) NSString         *filePath;
@property (nonatomic, strong) NSData           *fileData;
@property (nonatomic, copy  ) NSString         *name;
@property (nonatomic, copy  ) NSString         *fileName;
@property (nonatomic, copy  ) NSString         *mimeType;

@end

@interface SMHResponseModel : NSObject

@property (nonatomic, assign) NSInteger    code;
@property (nonatomic, copy  ) id           data;
@property (nonatomic, copy  ) NSString     *msg;

@end

@class SMHRequest;

typedef void(^SMHRequestCompleteHandler)(__nullable id response, NSError * __nullable error);

FOUNDATION_EXTERN NSString * const SMHErrorCacheKey;

@interface SMHRequest : YTKRequest

@property (nonatomic, strong, nonnull) SMHRequestModel *requestModel;

- (void)startWithCompleteHandler:(nullable SMHRequestCompleteHandler)completeHandler;

@end

NS_ASSUME_NONNULL_END
