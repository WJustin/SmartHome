//
//  SMHSetupPasswordViewController.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/24.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHSetupPasswordViewController.h"

@interface SMHSetupPasswordViewController ()

@property (nonatomic, strong) SMHHaveIconAndSeparatorInputView *passwordView;
@property (nonatomic, strong) SMHHaveIconAndSeparatorInputView                          *againPasswordView;
@property (nonatomic, strong) UILabel                          *numHintLabel;
@property (nonatomic, strong) SMHBottomButton                  *bottomButton;


@end

@implementation SMHSetupPasswordViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self addEvents];
}

#pragma mark - initUI

- (void)initUI {
    self.navigationItem.title = @"验证手机";
    @weakify(self);
    
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(195);
        make.left.mas_equalTo(67.5);
        make.centerX.mas_equalTo(0);
    }];
    [self.againPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.passwordView.mas_bottom).with.offset(20);
        make.left.mas_equalTo(self.passwordView);
        make.centerX.mas_equalTo(0);
    }];
    [self.numHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.againPasswordView.mas_bottom).with.offset(21.5);
    }];
    self.bottomButton = [[SMHBottomButton alloc] initWithSuperView:self.view];
    [self.bottomButton setTitle:@"立即注册" forState:UIControlStateNormal];
}

- (void)addEvents {
    [self.bottomButton addTarget:self
                          action:@selector(next)
                forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Events

- (void)next {
    
}

#pragma mark - Getter

- (SMHHaveIconAndSeparatorInputView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[SMHHaveIconAndSeparatorInputView alloc] init];
        _passwordView.textField.placeholder = @"密码";
        _passwordView.imageViewSizeConstraint.sizeOffset = CGSizeMake(13, 15);
        [self.view addSubview:_passwordView];
    }
    return _passwordView;
}

- (SMHHaveIconAndSeparatorInputView *)againPasswordView {
    if (!_againPasswordView) {
        _againPasswordView = [[SMHHaveIconAndSeparatorInputView alloc] init];
        _againPasswordView.textField.placeholder = @"重复密码";
        _againPasswordView.imageViewSizeConstraint.sizeOffset = CGSizeMake(13, 15);
        [self.view addSubview:_againPasswordView];
    }
    return _againPasswordView;
}

- (UILabel *)numHintLabel {
    if (!_numHintLabel) {
        _numHintLabel = [[UILabel alloc] init];
        _numHintLabel.text = @"请输入6-10位密码";
        _numHintLabel.font = [UIFont fontWithName:PingFangSCRegular size:11];
        _numHintLabel.textColor = UIColorHex(808080);
        [self.view addSubview:_numHintLabel];
    }
    return _numHintLabel;
}

@end
