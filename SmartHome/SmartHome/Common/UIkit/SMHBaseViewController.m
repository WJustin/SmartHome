//
//  SMHBaseViewController.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/22.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHBaseViewController.h"
#import <YYCategories/YYCategories.h>
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>

@interface SMHBaseViewController ()

@end

@implementation SMHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorHex(F9F9F9);
    [self configBackButton];
}

- (void)setPopDisabled:(BOOL)popDisabled {
    _popDisabled = popDisabled;
    self.fd_interactivePopDisabled = _popDisabled;
}

- (void)configBackButton {
    if (self.navigationController.childViewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(popSelf)];
    }
}

- (void)popSelf {
    if (self.popDisabled) {
        return;
    }
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
