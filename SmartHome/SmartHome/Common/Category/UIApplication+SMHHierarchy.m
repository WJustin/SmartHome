//
//  UIApplication+SMHHierarchy.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/22.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "UIApplication+SMHHierarchy.h"

@implementation UIApplication (SMHHierarchy)

- (UINavigationController *)smh_topNavController {
    UIViewController *vc = [self smh_topViewController];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)vc;
    } else {
        if ([vc.navigationController isKindOfClass:[UINavigationController class]]) {
            return vc.navigationController;
        } else {
            return nil;
        }
    }
}


- (UIViewController *)smh_topViewController {
    UIWindow *window = self.delegate.window;
    if (!window) {
        return nil;
    }
    for (UIView *subView in [window subviews]) {
        UIResponder *responder = [subView nextResponder];
        if ([responder isEqual:window]) {
            if ([[subView subviews] count]) {
                UIView *subSubView = [subView subviews].firstObject;
                responder = [subSubView nextResponder];
            }
        }
        if([responder isKindOfClass:[UIViewController class]]) {
            return [self smh_topViewController:(UIViewController *) responder];
        }
    }
    return nil;
}

- (UIViewController *)smh_topViewController:(UIViewController *)controller {
    BOOL isPresenting = NO;
    do {
        UIViewController *presented = [controller presentedViewController];
        isPresenting = (presented != nil);
        if(isPresenting) {
            controller = presented;
        }
    } while (isPresenting);
    
    if ([controller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabController = (UITabBarController *)controller;
        return [[tabController viewControllers] objectAtIndex:tabController.selectedIndex];
    }
    return controller;
}

@end
