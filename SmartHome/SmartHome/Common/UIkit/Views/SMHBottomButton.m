//
//  SMHBottomButton.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/24.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHBottomButton.h"

@implementation SMHBottomButton

- (instancetype)initWithSuperView:(UIView *)superView {
    if (self = [super init]) {
        self.backgroundColor = UIColorHex(1F1F1F);
        if (superView) {
            [superView addSubview:self];
            @weakify(self);
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.left.centerX.mas_equalTo(0);
                make.bottom.mas_equalTo(self.superview.gs_bottom);
                make.height.mas_equalTo(40);
            }];
        }
    }
    return self;
}

@end
