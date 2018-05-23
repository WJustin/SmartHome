//
//  SMHVerifyCodeViewController.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/24.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHVerifyCodeViewController.h"
#import "SMHSetupPasswordViewController.h"

@interface SMHVerifyCodeViewController ()

@property (nonatomic, strong) UILabel                          *titleLabel;
@property (nonatomic, strong) SMHHaveIconAndSeparatorInputView *verifyCodeInputView;
@property (nonatomic, strong) UILabel                          *countDownLabel;
@property (nonatomic, strong) SMHBottomButton                  *bottomButton;

@end

@implementation SMHVerifyCodeViewController

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
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(57);
        make.centerX.mas_equalTo(0);
    }];
    
    [self.verifyCodeInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(80);
        make.left.mas_equalTo(67.5);
        make.centerX.mas_equalTo(0);
    }];
    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.verifyCodeInputView.mas_bottom).with.offset(21.5);
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
    SMHSetupPasswordViewController *vc = [[SMHSetupPasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text= [NSString stringWithFormat:@"我们发送了4位验证码至\n%@%@",self.region, self.phone];
        _titleLabel.font = [UIFont fontWithName:PingFangSCRegular size:14];
        _titleLabel.textColor = UIColorHex(E6E6E6);
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (SMHHaveIconAndSeparatorInputView *)verifyCodeInputView {
    if (!_verifyCodeInputView) {
        _verifyCodeInputView = [[SMHHaveIconAndSeparatorInputView alloc] init];
        _verifyCodeInputView.textField.placeholder = @"短信验证码";
        _verifyCodeInputView.imageViewSizeConstraint.sizeOffset = CGSizeMake(16, 12);
        [self.view addSubview:_verifyCodeInputView];
    }
    return _verifyCodeInputView;
}

- (UILabel *)countDownLabel {
    if (!_countDownLabel) {
        _countDownLabel = [[UILabel alloc] init];
        _countDownLabel.font = [UIFont fontWithName:PingFangSCRegular size:11];
        _countDownLabel.text = @"53s后重新获取验证码";
        _countDownLabel.textColor = UIColorHex(808080);
        [self.view addSubview:_countDownLabel];
    }
    return _countDownLabel;
}


@end
