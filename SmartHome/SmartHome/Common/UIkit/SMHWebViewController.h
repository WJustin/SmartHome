//
//  SMHWebViewController.h
//  SmartHome
//
//  Created by Justin.wang on 2018/5/22.
//  Copyright © 2018年 施勒智能. All rights reserved.
//

#import "SMHBaseViewController.h"
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>

@interface SMHWebViewController : SMHBaseViewController

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) BOOL isLocolName;
@property (nonatomic, copy  ) NSString *url_string;
@property (nonatomic, strong) WKWebViewJavascriptBridge *webViewBridge;

@end
