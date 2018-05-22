//
//  GSToast.h
//  GSToast
//
//  Created by Justin.wang on 2018/4/3.
//

#import <Foundation/Foundation.h>

typedef void (^DidToastHideCompletionHandler)();

NS_ASSUME_NONNULL_BEGIN
@interface GSToast : NSObject

+ (void)showToastInTopWindow;
+ (void)showToastInRootView:(UIView *)rootView;

+ (void)showToastInTopWindowWithMessage:(NSString *)message;
+ (void)showToastInTopWindowWithImage:(nullable NSString *)imageName
                              message:(NSString *)message
                                delay:(NSTimeInterval)delay
                    completionHandler:(nullable DidToastHideCompletionHandler)completionHandler;

+ (void)showToastInRootView:(UIView *)rootView
                      image:(nullable NSString *)imageName
                    message:(NSString *)message
                      delay:(NSTimeInterval)delay
          completionHandler:(nullable DidToastHideCompletionHandler)completionHandler;

+ (void)hideToastInTopWindow;
+ (void)hideToastInRootView:(UIView *)rootView;
+ (void)hideToastInRootView:(UIView *)rootView completionHandler:(nullable DidToastHideCompletionHandler)completionHandler;
+ (void)hideToastInRootView:(UIView *)rootView animate:(BOOL)animate completionHandler:(nullable DidToastHideCompletionHandler)completionHandler;

@end

@interface UIViewController (GSToast)

- (void)showToast;

- (void)showToastWithMessage:(NSString *)message;
- (void)showToastWithMessage:(NSString *)message completionHandler:(nullable DidToastHideCompletionHandler)completionHandler;

- (void)showToastWithSuccessMessage:(NSString *)message;
- (void)showToastWithSuccessMessage:(NSString *)message completionHandler:(nullable DidToastHideCompletionHandler)completionHandler;

- (void)showToastWithErrorMessage:(NSString *)message;
- (void)showToastWithErrorMessage:(NSString *)message completionHandler:(nullable DidToastHideCompletionHandler)completionHandler;

- (void)showToastWithImage:(nullable NSString *)imageName
                   message:(NSString *)message
                     delay:(NSTimeInterval)delay
         completionHandler:(nullable DidToastHideCompletionHandler)completionHandler;

- (void)hideToast;
- (void)hideToastWithAnimate:(BOOL)animate;
- (void)hideToastWithCompletionHandler:(nullable DidToastHideCompletionHandler)completionHandler;

@end
NS_ASSUME_NONNULL_END

