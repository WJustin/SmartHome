//
//  SMHRootManager.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/22.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHRootManager.h"
#import "SMHRegionViewController.h"
#import "SMHCategoryViewController.h"
#import "SMHHomeViewController.h"
#import "SMHUserViewController.h"
#import "SMHSceneViewController.h"

@interface SMHRootManager ()<UITabBarControllerDelegate>

@end

@implementation SMHRootManager

+ (SMHRootManager*)shareManager {
    static SMHRootManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[SMHRootManager alloc]init];
    });
    return shareManager;
}

- (UITabBarController *)getRootViewController {
    UINavigationController *region = [self setUIViewController:[SMHRegionViewController class]
                                                       andImage:@"卖出"
                                                    andTapImage:@"卖出"
                                                       andTitle:@"区域"];
    UINavigationController *scene = [self setUIViewController:[SMHSceneViewController class]
                                                      andImage:@"卖出"
                                                   andTapImage:@"卖出"
                                                      andTitle:@"场景"];
    UINavigationController *home = [self setUIViewController:[SMHHomeViewController class]
                                                       andImage:@"卖出"
                                                    andTapImage:@"卖出"
                                                       andTitle:@"主页"];
    UINavigationController *category = [self setUIViewController:[SMHCategoryViewController class]
                                                       andImage:@"卖出"
                                                    andTapImage:@"卖出"
                                                       andTitle:@"类别"];
    UINavigationController *user = [self setUIViewController:[SMHUserViewController class]
                                                       andImage:@"卖出"
                                                    andTapImage:@"卖出"
                                                       andTitle:@"我的"];
    self.tabBarController.viewControllers = @[region, scene, home, category, user];
    self.tabBarController.delegate = self;
    return self.tabBarController;
}

- (UINavigationController *)setUIViewController:(Class)class
                                       andImage:(NSString *)image
                                    andTapImage:(NSString *)timage
                                       andTitle:(NSString *)title {
    UIViewController *controller = [[class alloc] init];
    controller.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:timage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.title = title;
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont fontWithName:@"PingFangTC-Light" size:10];
    normalAttrs[NSForegroundColorAttributeName] = UIColorHex(000000);
    [controller.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont fontWithName:@"PingFangTC-Regular" size:10];
    selectedAttrs[NSForegroundColorAttributeName] = UIColorHex(000000);
    [controller.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.controllers addObject:controller];
    return nav;
}

- (void)setBadgeOnIndex:(NSInteger)index andValue:(NSInteger)value;{
    if (index > self.controllers.count - 1) {
        return;
    }
    UIViewController *controller = self.controllers[index];
    controller.tabBarItem.badgeValue = (value>99) ? @"99+" : [NSString stringWithFormat:@"%ld",(long)value];
}

- (void)setToViewByClass:(Class)classes;{
    if (classes == nil) {
        return;
    }
    for (UIViewController*controller in self.controllers) {
        if ([controller isKindOfClass:classes]) {
            self.tabBarController.selectedIndex = [self.controllers indexOfObject:controller];
        }
    }
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

#pragma mark - Getter
- (UITabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController =[[UITabBarController alloc]init];
        [_tabBarController.view setBackgroundColor:[UIColor whiteColor]];
        
        //设置标签栏文字和图片的颜色
        //        _tabBarController.tabBar.tintColor = [UIColor orangeColor];
        
        _tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
//        [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"阴影"]];
//        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
        
        //        CGMutablePathRef path = CGPathCreateMutable();
        //        CGPathAddRect(path, NULL, _tabBarController.tabBar.bounds);
        //        _tabBarController.tabBar.layer.shadowPath = path;
        //        CGPathCloseSubpath(path);
        //        CGPathRelease(path);
        //
        //        _tabBarController.tabBar.layer.shadowColor = ___color_Value(0x999999, 0.3).CGColor;
        //        _tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0, -5);
        //        _tabBarController.tabBar.layer.shadowRadius = 1;
        //        _tabBarController.tabBar.layer.shadowOpacity = 0.3;
        
        // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
        _tabBarController.tabBar.clipsToBounds = NO;
    }
    return _tabBarController;
}
- (NSMutableArray *)controllers {
    if (!_controllers) {
        _controllers = [NSMutableArray new];
    }
    return _controllers;
}


@end
