//
//  SMHRegisterViewController.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/23.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHRegisterViewController.h"
#import "SMHVerifyCodeViewController.h"

@interface SMHRegisterViewController ()

@property (nonatomic, strong) SMHHaveIconAndSeparatorInputView *regionView;
@property (nonatomic, strong) SMHHaveIconAndSeparatorInputView *phoneView;
@property (nonatomic, strong) SMHBottomButton                  *bottomButton;


@end

@implementation SMHRegisterViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self addEvents];
}

#pragma mark - initUI

- (void)initUI {
    self.navigationItem.title = @"注册SCHIELE";
    @weakify(self);
    [self.regionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(148.5);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(67.5);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.regionView.mas_bottom).with.offset(20);
        make.left.centerX.mas_equalTo(self.regionView);
    }];
    self.bottomButton = [[SMHBottomButton alloc] initWithSuperView:self.view];
    [self.bottomButton setTitle:@"下一步" forState:UIControlStateNormal];
}

- (void)addEvents {
    [self.bottomButton addTarget:self
                          action:@selector(next)
                forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Events

- (void)next {
    SMHVerifyCodeViewController *vc = [[SMHVerifyCodeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter

- (SMHHaveIconAndSeparatorInputView *)regionView {
    if (!_regionView) {
        _regionView = [[SMHHaveIconAndSeparatorInputView alloc] init];
        _regionView.textField.enabled = NO;
        _regionView.textField.placeholder = @"中国（+86）";
        _regionView.imageViewSizeConstraint.sizeOffset = CGSizeMake(17, 17);
        [self.view addSubview:_regionView];
    }
    return _regionView;
}
- (SMHHaveIconAndSeparatorInputView *)phoneView {
    if (!_phoneView) {
        _phoneView = [[SMHHaveIconAndSeparatorInputView alloc] init];
        _phoneView.textField.placeholder = @"手机号";
        _phoneView.imageViewSizeConstraint.sizeOffset = CGSizeMake(14, 22);
        [self.view addSubview:_phoneView];
    }
    return _phoneView;
}

@end
