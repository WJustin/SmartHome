//
//  UIView+SMHExtension.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/23.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "UIView+SMHExtension.h"

@implementation UIView (SMHExtension)

- (void)addTapGestureWithTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tapGesture];
}

- (void)addTapGestureWithTarget:(id)target action:(SEL)action viewTag:(NSInteger)viewTag {
    [self setTag:viewTag];
    [self addTapGestureWithTarget:target action:action];
}

- (void)addTapGestureWithTarget:(id)target action:(SEL)action numberOfTapsRequired:(NSUInteger)numberOfTapsRequired {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tapGesture.numberOfTapsRequired = numberOfTapsRequired;
    [self addGestureRecognizer:tapGesture];
}


- (MASViewAttribute *)gs_left {
    if (@available(iOS 11.0, *)) {
        return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeft];
    } else {
        return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
    }
}

- (MASViewAttribute *)gs_top {
    if (@available(iOS 11.0, *)) {
        return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTop];
    } else {
        return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
    }
}

- (MASViewAttribute *)gs_right {
    if (@available(iOS 11.0, *)) {
        return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeRight];
    } else {
        return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
    }
}

- (MASViewAttribute *)gs_bottom {
    if (@available(iOS 11.0, *)) {
        return [[MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
    } else {
        return [[MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
    }
}

@end
