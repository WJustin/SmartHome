//
//  SMHLoginViewController.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/23.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHLoginViewController.h"
#import "SMHLoginInputView.h"
#import "SMHRegisterViewController.h"

static NSInteger const buttonHeight = 34;

@interface SMHLoginViewController ()

@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic, strong) SMHLoginInputView *nameView;
@property (nonatomic, strong) SMHLoginInputView *passwordView;
@property (nonatomic, strong) UIButton          *loginButton;
@property (nonatomic, strong) UILabel           *registerLabel;
@property (nonatomic, strong) UILabel           *issueLabel;

@end

@implementation SMHLoginViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self addEvents];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - initUI

- (void)initUI {
    @weakify(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(145);
        make.centerX.mas_equalTo(0);
    }];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(50);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(buttonHeight);
    }];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.nameView.mas_bottom).with.offset(12.5);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(buttonHeight);
    }];

    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.passwordView.mas_bottom).with.offset(12.5);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(buttonHeight);
    }];
}

- (void)addEvents {
    [self.registerLabel addTapGestureWithTarget:self
                                         action:@selector(gotoRegister)];
    [self.issueLabel addTapGestureWithTarget:self
                                      action:@selector(forgetPassword)];
    [self.loginButton addTarget:self
                         action:@selector(login)
               forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Events

- (void)gotoRegister {
    SMHRegisterViewController *vc = [[SMHRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)forgetPassword {
    
}

- (void)login {
    SMHRegisterViewController *vc = [[SMHRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text= @"SCHIELE";
        _titleLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (SMHLoginInputView *)nameView {
    if (!_nameView) {
        _nameView = [[SMHLoginInputView alloc] init];
        _nameView.layer.cornerRadius = buttonHeight / 2;
        _nameView.layer.masksToBounds = YES;
        _nameView.textField.attributedPlaceholder = [@"请输入用户名" nvm_makeAttributedString:^(NVMAttributesMaker *make) {
            make.color(UIColorHex(808080)).font([UIFont fontWithName:PingFangSCRegular size:12]);
        }];
        [self.view addSubview:_nameView];
    }
    return _nameView;
}

- (SMHLoginInputView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[SMHLoginInputView alloc] init];
        _passwordView.layer.cornerRadius = buttonHeight / 2;
        _passwordView.layer.masksToBounds = YES;
        _passwordView.textField.attributedPlaceholder = [@"请输入密码" nvm_makeAttributedString:^(NVMAttributesMaker *make) {
            make.color(UIColorHex(808080)).font([UIFont fontWithName:PingFangSCRegular size:12]);
        }];
        [self.view addSubview:_passwordView];
    }
    return _passwordView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:UIColorHex(4A81AF)];
        _loginButton.layer.cornerRadius = buttonHeight / 2;
        _loginButton.layer.masksToBounds = YES;
        [self.view addSubview:_loginButton];
    }
    return _loginButton;
}

- (UILabel *)registerLabel {
    if (!_registerLabel) {
        _registerLabel = [[UILabel alloc] init];
        _registerLabel.text= @"注册";
        _registerLabel.textColor = UIColorHex(AAAAAA);
        _registerLabel.font = [UIFont fontWithName:PingFangSCRegular size:13];
 
        [self.view addSubview:_registerLabel];
    }
    return _registerLabel;
}

- (UILabel *)issueLabel {
    if (!_issueLabel) {
        _issueLabel = [[UILabel alloc] init];
        _issueLabel.text= @"登录遇到困难？";
        _issueLabel.textColor = UIColorHex(AAAAAA);
        _issueLabel.font = [UIFont fontWithName:PingFangSCRegular size:13];
        [_issueLabel addTapGestureWithTarget:self
                                      action:@selector(forgetPassword)];
        [self.view addSubview:_issueLabel];
    }
    return _issueLabel;
}
@end
