//
//  UIApplication+SMHHierarchy.h
//  SmartHome
//
//  Created by Justin.wang on 2018/5/22.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (SMHHierarchy)

- (UINavigationController *)smh_topNavController;

- (UIViewController *)smh_topViewController;

@end
