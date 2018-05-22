//
//  SMHRootManager.h
//  SmartHome
//
//  Created by Justin.wang on 2018/5/22.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMHRootManager : NSObject

+ (SMHRootManager*)shareManager;

@property (nonatomic,strong)NSMutableArray *controllers;
@property (nonatomic,strong)UITabBarController *tabBarController;

/**
 获取root视图
 
 @return root视图
 */
- (UITabBarController *)getRootViewController;


/**
 设置数字角标
 
 @param index 第几个
 @param value 角标数量
 */
- (void)setBadgeOnIndex:(NSInteger)index andValue:(NSInteger)value;


@end
