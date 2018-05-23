//
//  SMHWebViewController.m
//  SmartHome
//
//  Created by Justin.wang on 2018/5/22.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHWebViewController.h"

@interface SMHWebViewController ()<WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIProgressView  *progressView;
@property (nonatomic, strong) UIBarButtonItem *leftBtn;
@property (nonatomic, strong) UIBarButtonItem *leftBtnClose;

@end

@implementation SMHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavgationBar];
    [self initProgressView];
    [self initWKWebView];
    [self loadRequest];
}

- (void)dealloc {
    [self.webView stopLoading];
    [self.webView removeObserver:self
                      forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.webView removeObserver:self
                      forKeyPath:NSStringFromSelector(@selector(title))];
    [self.webView removeObserver:self
                      forKeyPath:NSStringFromSelector(@selector(canGoBack))];
}

#pragma mark - init UI
- (void)initWKWebView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGRect rect = CGRectMake(0, 0, size.width, size.height - 64);
    self.webView = [[WKWebView alloc] initWithFrame:rect
                                      configuration:configuration];
    [self.webView addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(title))
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
    [self.webView addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(canGoBack))
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
    self.webView.scrollView.bouncesZoom = NO;
    self.webView.scrollView.alwaysBounceHorizontal = NO;
    self.webView.multipleTouchEnabled=NO;
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    self.webView.scrollView.delegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
    self.webViewBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.webViewBridge setWebViewDelegate:self];

}

- (void)initNavgationBar {
    UIImage *backImage = [UIImage imageNamed:@"返回"];
    UIImage *normalImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *landscapeImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.leftBtn = [[UIBarButtonItem alloc] initWithImage:normalImage
                                      landscapeImagePhone:landscapeImage
                                                    style:UIBarButtonItemStylePlain
                                                   target:self
                                                   action:@selector(popSelf)];
    self.leftBtnClose = [[UIBarButtonItem alloc] initWithTitle:@""
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(popSelf)];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17],NSFontAttributeName, nil];
    [self.leftBtnClose setTitleTextAttributes:attributes
                                     forState:UIControlStateNormal];
    [self.leftBtnClose setTintColor:UIColorHex(666666)];
    self.navigationItem.leftBarButtonItems = @[self.leftBtn,self.leftBtnClose];
}

- (void)initProgressView {
    CGFloat progressBarHeight = 2.f;
    CGRect barFrame = CGRectMake(0, 0, self.view.frame.size.width, progressBarHeight);
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:barFrame];
    progressView.trackTintColor = [UIColor whiteColor];
    progressView.progressTintColor = UIColorHex(20252C);
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

- (void)loadRequest {
    NSURL *url = [NSURL URLWithString:self.url_string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context{
    if (object == self.webView &&
        [keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progressView setProgress:1.0 animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            });
        } else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    } else if (object == self.webView &&
               [keyPath isEqualToString:NSStringFromSelector(@selector(title))]){
        self.navigationItem.title = self.webView.title;
     
    } else if (object == self.webView &&
               [keyPath isEqualToString:NSStringFromSelector(@selector(canGoBack))]){
        BOOL can = [change[@"new"] boolValue];
        [self.leftBtnClose setTitle:(can)?@"关闭":@""];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.childViewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView
runJavaScriptAlertPanelWithMessage:(NSString *)message
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                if (completionHandler) {
                                                    completionHandler();
                                                }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView
didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation
      withError:(NSError *)error {
    if (error.code == NSURLErrorCancelled) {
        return;
    }
    [self showErrorView];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self showErrorView];
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler  {
    if ([[[WebViewJavascriptBridgeBase alloc] init] isWebViewJavascriptBridgeURL:navigationAction.request.URL]) {
        return;
    }
    decisionHandler(YES);
}

#pragma mark - Events
- (void)setLeftButtonAction:(UIButton *)sender {
    if ([self.webView canGoBack] == NO) {
        [self popSelf];
        return;
    }
    [self.webView goBack];
}

- (void)setLeftButtonCloseAction:(UIButton *)sender {
    [self popSelf];
}

- (void)showErrorView {
    
}

@end
