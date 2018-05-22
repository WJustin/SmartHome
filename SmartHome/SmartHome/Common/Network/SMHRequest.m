//
//  SMHRequest.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/22.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHRequest.h"
#import <YYModel/YYModel.h>
#import <YYCategories/YYCategories.h>
#import <AFNetworking/AFURLRequestSerialization.h>

@implementation SMHSignInstance

+ (SMHSignInstance *)shareInstance {
    static SMHSignInstance *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (NSDictionary *)signWithParams:(NSDictionary *)params {
    return params;
}

@end


static NSString * const SMHServerErrorDomain = @"com.network.error";

NSInteger const SMHServerWrongCode = 10001;

@implementation SMHRequestModel

- (instancetype)init {
    if (self = [super init]) {
        self.requestMethod =  YTKRequestMethodPOST;
    }
    return self;
}

@end

@implementation SMHResponseModel


@end

NSString * const SMHErrorCacheKey = @"error";

@implementation SMHRequest

- (instancetype)init {
    if (self = [super init]) {
        [self setSuccessCompletionBlock:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
    }
    return self;
}

- (void)startWithCompleteHandler:(SMHRequestCompleteHandler)completeHandler {
    if (self.requestModel.fileData) {
        @weakify(self);
        [self setConstructingBodyBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            @strongify(self);
            NSString *name = self.requestModel.name ?: @"pic";
            NSString *fileName = self.requestModel.fileName ?: [NSString stringWithFormat:@"image%@.png",@([NSDate date].timeIntervalSince1970)];
            NSString *type = @"application/octet-stream";
            [formData appendPartWithFileData:self.requestModel.fileData
                                        name:name
                                    fileName:fileName
                                    mimeType:type];
        }];
    }
    if (self.requestModel.filePath) {
        @weakify(self);
        [self setConstructingBodyBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            @strongify(self);
            NSArray *array = [self.requestModel.filePath componentsSeparatedByString:@"/"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.requestModel.filePath]];
            [formData appendPartWithFileData:data
                                        name:@"pic"
                                    fileName:[NSString stringWithFormat:@"%@-%@",@([NSDate date].timeIntervalSince1970).stringValue, [array lastObject]]
                                    mimeType:@"application/octet-stream"];
        }];
    }
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *json = [request responseJSONObject];
        if (!json || ![json isKindOfClass:[NSDictionary class]]) {
            NSError *error = [NSError errorWithDomain:SMHServerErrorDomain
                                                 code:SMHServerWrongCode
                                             userInfo:@{@"NSLocalizedDescription" : @"服务端响应格式有误"}];
            if (completeHandler) {
                completeHandler(nil, error);
            }
            return;
        }
        if (self.requestModel.bindClass == [NSDictionary class]) {
            if (completeHandler) {
                completeHandler(json, nil);
            }
            return;
        }
        
        SMHResponseModel *response = [SMHResponseModel yy_modelWithJSON:json];
        if (response.code != [SMHSignInstance shareInstance].successCode) {
            if (completeHandler) {
                NSError *error = [NSError errorWithDomain:SMHServerErrorDomain
                                                     code:response.code
                                                 userInfo:@{@"NSLocalizedDescription" : response.msg ?: @""}];
                completeHandler(nil, error);
            }
            return;
        }
        
        Class bindClass = self.requestModel.bindClass;
        if (!bindClass) {
            if (completeHandler) {
                completeHandler(response, nil);
            }
            return;
        }
        id responseInstance = nil;
        if ([response.data isKindOfClass:[NSArray class]]) {
            responseInstance = [NSArray yy_modelArrayWithClass:bindClass json:response.data];
        } else {
            responseInstance = [bindClass yy_modelWithJSON:response.data];
        }
        if (completeHandler) {
            completeHandler(responseInstance, nil);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (completeHandler) {
            completeHandler(nil, request.error);
        }
    }];
}


- (NSString *)requestUrl {
    return self.requestModel.requestUrl ?: @"";
}

- (YTKRequestMethod)requestMethod {
    return self.requestModel.requestMethod;
}

- (id)requestArgument {
    NSDictionary *dic = [[SMHSignInstance shareInstance] signWithParams:self.requestModel.requestParams];
    return dic;
}

- (NSInteger)cacheTimeInSeconds {
    return self.requestModel.cacheTimeInSeconds;
}

- (NSDictionary *)responseHeaders {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self.response.allHeaderFields];
    [dic addEntriesFromDictionary:@{@"Content-Type" : @"application/zip"}];
    return dic;
}

@end
