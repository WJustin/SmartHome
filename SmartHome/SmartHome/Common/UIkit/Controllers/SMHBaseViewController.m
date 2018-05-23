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
    self.view.backgroundColor = UIColorHex(292929);
    [self configBackButton];
}

- (void)setPopDisabled:(BOOL)popDisabled {
    _popDisabled = popDisabled;
    self.fd_interactivePopDisabled = _popDisabled;
}

- (void)configBackButton {
    if (self.navigationController.childViewControllers.count > 1) {
        UIImage *backImage = [UIImage imageNamed:@"返回"];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage
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
