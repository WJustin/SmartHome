//
//  UIView+SMHExtension.h
//  SmartHome
//
//  Created by Justin.wang on 2018/5/23.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SMHExtension)

- (void)addTapGestureWithTarget:(id)target
                         action:(SEL)action;
- (void)addTapGestureWithTarget:(id)target
                         action:(SEL)action
                        viewTag:(NSInteger)viewTag;
- (void)addTapGestureWithTarget:(id)target
                         action:(SEL)action
           numberOfTapsRequired:(NSUInteger)numberOfTapsRequired;

@property (nonatomic, strong, readonly) MASViewAttribute *gs_left;
@property (nonatomic, strong, readonly) MASViewAttribute *gs_top;
@property (nonatomic, strong, readonly) MASViewAttribute *gs_right;
@property (nonatomic, strong, readonly) MASViewAttribute *gs_bottom;

@end
