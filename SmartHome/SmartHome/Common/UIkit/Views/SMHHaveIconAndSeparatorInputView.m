//
//  SMHHaveIconAndSeparatorInputView.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/24.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHHaveIconAndSeparatorInputView.h"

@interface SMHHaveIconAndSeparatorInputView ()

@property (nonatomic, strong) UIView *bottomSeparator;

@end

@implementation SMHHaveIconAndSeparatorInputView


- (instancetype)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    @weakify(self);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17.5);
        self.imageViewSizeConstraint =
        make.size.mas_equalTo(CGSizeMake(11, 10.5));
        make.bottom.mas_equalTo(-9);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.imageView.mas_right).with.offset(5);
        make.bottom.mas_equalTo(self.imageView.mas_bottom);
        make.centerX.mas_equalTo(0);
    }];
    
    [self.bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-0.5);
        make.height.mas_equalTo(-0.5);
    }];
}

- (void)editingChanged:(UITextField *)textField {
    //    if (textField.text.length > GS_PHONE_LENGTH) {
    //        textField.text = [textField.text substringToIndex:GS_PHONE_LENGTH];
    //    }
}


#pragma mark - Getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor redColor];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [_textField addTarget:self
                       action:@selector(editingChanged:)
             forControlEvents:UIControlEventEditingChanged];
        _textField.font = [UIFont fontWithName:PingFangSCRegular size:12];
        _textField.textColor = UIColorHex(808080);
        [self addSubview:_textField];
    }
    return _textField;
}

- (UIView *)bottomSeparator {
    if (!_bottomSeparator) {
        _bottomSeparator = [[UIView alloc] init];
        _bottomSeparator.backgroundColor = UIColorHex(7E7E7E);
        [self addSubview:_bottomSeparator];
    }
    return _bottomSeparator;
}

@end
