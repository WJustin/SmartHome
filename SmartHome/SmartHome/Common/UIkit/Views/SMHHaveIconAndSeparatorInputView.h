//
//  SMHHaveIconAndSeparatorInputView.h
//  SmartHome
//
//  Created by Justin.wang on 2018/5/24.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMHHaveIconAndSeparatorInputView : UIView

@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UITextField  *textField;
@property (nonatomic, strong) MASConstraint *imageViewSizeConstraint;

@end
