//
//  SMHLoginInputView.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/23.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHLoginInputView.h"

@interface SMHLoginInputView ()


@end

@implementation SMHLoginInputView

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
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(17.5);
        make.size.mas_equalTo(CGSizeMake(11, 10.5));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.imageView.mas_right).with.offset(12.5);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
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
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
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

@end
