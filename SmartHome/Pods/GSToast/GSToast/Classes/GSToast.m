//
//  GSToast.m
//  GSToast
//
//  Created by Justin.wang on 2018/4/3.
//

#import "GSToast.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYCategories/YYCategories.h>

static NSInteger const kToastTag   = 999932;
static CGFloat   const kToastDelay = 1.0f;

@implementation GSToast

+ (void)showToastInRootView:(UIView *)rootView {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self addToastForRootView:rootView];
        hud.label.text = @"";
        hud.customView = nil;
        hud.mode = MBProgressHUDModeIndeterminate;
        [rootView bringSubviewToFront:hud];
        [hud showAnimated:YES];
    });
}

+ (void)showToastInTopWindow {
    UIWindow *topWindow = [self getTopWindow];
    if (topWindow) {
        [self showToastInRootView:topWindow];
    }
}

+ (void)showToastInTopWindowWithMessage:(NSString *)message {
    [self showToastInTopWindowWithImage:nil
                                message:message
                                  delay:kToastDelay
                      completionHandler:nil];
}

+ (void)showToastInTopWindowWithImage:(NSString *)imageName
                              message:(NSString *)message
                                delay:(NSTimeInterval)delay
                    completionHandler:(DidToastHideCompletionHandler)completionHandler {
    UIWindow *topWindow = [self getTopWindow];
    if (topWindow) {
        [self showToastInRootView:topWindow
                            image:imageName
                          message:message
                            delay:delay
                completionHandler:completionHandler];
    }
}

+ (void)showToastInRootView:(UIView *)rootView
                      image:(NSString *)imageName
                    message:(NSString *)message
                      delay:(NSTimeInterval)delay
          completionHandler:(DidToastHideCompletionHandler)completionHandler {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self addToastForRootView:rootView];
        if (imageName.isNotBlank) {
            hud.mode = MBProgressHUDModeCustomView;
            hud.bezelView.color = [UIColor blackColor];
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(0, 0, 20, 20);
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            NSString *resourcePath = [bundle.resourcePath stringByAppendingPathComponent:@"/GSToast.bundle"];
            imageView.image = [UIImage imageNamed:imageName
                                         inBundle:[NSBundle bundleWithPath:resourcePath]
                    compatibleWithTraitCollection:nil];
            hud.customView = imageView;
            [hud setCompletionBlock:^{
                if (completionHandler) {
                    completionHandler();
                }
            }];
        } else {
            hud.mode = MBProgressHUDModeText;
        }
        if (message.isNotBlank) {
            hud.label.text = message;
        }
        hud.minShowTime = delay;
        [rootView bringSubviewToFront:hud];
        [hud setCompletionBlock:^{
            if (completionHandler) {
                completionHandler();
            }
        }];
        [hud showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });
}

+ (void)hideToastInRootView:(UIView *)rootView {
    [self hideToastInRootView:rootView completionHandler:nil];
}

+ (void)hideToastInTopWindow {
    UIWindow *topWindow = [self getTopWindow];
    if (topWindow) {
        [self hideToastInRootView:topWindow completionHandler:nil];
    }
}

+ (void)hideToastInRootView:(UIView *)rootView
          completionHandler:(DidToastHideCompletionHandler)completionHandler {
    [self hideToastInRootView:rootView animate:YES completionHandler:completionHandler];
}

+ (void)hideToastInRootView:(UIView *)rootView
                    animate:(BOOL)animate
          completionHandler:(DidToastHideCompletionHandler)completionHandler {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = (MBProgressHUD *)[rootView viewWithTag:kToastTag];
        [hud setCompletionBlock:^{
            if (completionHandler) {
                completionHandler();
            }
        }];
        [hud hideAnimated:animate];
    });
}

+ (void)removeToastFromRootView:(UIView *)rootView {
    MBProgressHUD *hud = (MBProgressHUD *)[rootView viewWithTag:kToastTag];
    if (hud) {
        [hud removeFromSuperview];
        hud = nil;
    }
}

+ (MBProgressHUD *)addToastForRootView:(UIView *)rootView {
    MBProgressHUD *hud = (MBProgressHUD *)[rootView viewWithTag:kToastTag];
    if (!hud) {
        hud = (MBProgressHUD *)[[MBProgressHUD alloc] initWithView:rootView];
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        hud.label.font = [UIFont systemFontOfSize:15];
        hud.margin = 15;
        [rootView addSubview:hud];
        hud.tag = kToastTag;
    }
    if ([rootView isKindOfClass:[UIScrollView class]]) {
        hud.offset = CGPointMake(hud.offset.x, ((UIScrollView *)rootView).contentOffset.y);
    }
    return hud;
}


+ (UIWindow *)getTopWindow {
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        return window;
    }
    return nil;
}

@end

@implementation UIViewController (GSToast)

- (void)showToast {
    [GSToast showToastInRootView:self.view];
}

- (void)showToastWithMessage:(NSString *)message  {
    [self showToastWithMessage:message completionHandler:nil];
}

- (void)showToastWithMessage:(NSString *)message
           completionHandler:(DidToastHideCompletionHandler)completionHandler {
    [self showToastWithImage:nil message:message delay:kToastDelay completionHandler:completionHandler];
}

- (void)showToastWithSuccessMessage:(NSString *)message {
    [self showToastWithSuccessMessage:message completionHandler:nil];
}

- (void)showToastWithSuccessMessage:(NSString *)message
                  completionHandler:(DidToastHideCompletionHandler)completionHandler {
    [self showToastWithImage:@"yes" message:message delay:kToastDelay completionHandler:completionHandler];
}

- (void)showToastWithErrorMessage:(NSString *)message {
    [self showToastWithErrorMessage:message completionHandler:nil];
}

- (void)showToastWithErrorMessage:(NSString *)message
                completionHandler:(DidToastHideCompletionHandler)completionHandler {
    [self showToastWithImage:@"close" message:message delay:kToastDelay completionHandler:completionHandler];
}

- (void)showToastWithImage:(NSString *)imageName
                   message:(NSString *)message
                     delay:(NSTimeInterval)delay
         completionHandler:(DidToastHideCompletionHandler)completionHandler {
    [GSToast showToastInRootView:self.view
                           image:imageName
                         message:message
                           delay:delay
               completionHandler:completionHandler];
}

- (void)hideToast {
    [self hideToastWithCompletionHandler:nil];
}

- (void)hideToastWithAnimate:(BOOL)animate {
    [GSToast hideToastInRootView:self.view animate:animate completionHandler:nil];
}

- (void)hideToastWithCompletionHandler:(DidToastHideCompletionHandler)completionHandler {
    [GSToast hideToastInRootView:self.view completionHandler:completionHandler];
}

@end


