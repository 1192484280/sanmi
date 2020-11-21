//
//  WKWebViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/19.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "WkWebList.h"

@interface WKWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *myProgressView;

@end

@implementation WKWebViewController

- (WKWebView *)webView{
    
    if (!_webView) {
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_webView addObserver:self
                       forKeyPath:@"title"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
        NSString *url = [WkWebList sharedInstance].url;
        NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:1 timeoutInterval:30.0f];
        [_webView loadRequest:request];
        
    }
    
    return _webView;
}

- (UIProgressView *)myProgressView {
    
    if (_myProgressView == nil) {
        
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
        _myProgressView.tintColor = SMOrangeColor;
        _myProgressView.trackTintColor = BaseBackGroundColor;
        
    }
    
    return _myProgressView;
    
}

- (void)back{
    
    if (self.present) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.autoresizesSubviews = NO;
    
    self.title = @"加载中..";
    
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImageName:@"img_webbefore" selectedImageName:@"img_webbefore" target:self action:@selector(before:)];
    
    NSMutableArray *leftArr = [NSMutableArray arrayWithObject:item1];
    
    if (_hadRelod) {
        
        UIBarButtonItem *item2 = [UIBarButtonItem itemWithImageName:@"img_webClose" selectedImageName:@"img_webClose" target:self action:@selector(back)];
        
        [leftArr addObject:item2];
        
         UIBarButtonItem *item3 = [UIBarButtonItem itemWithImageName:@"img_webRefresh" selectedImageName:@"img_webRefresh" target:self action:@selector(refresh:)];
        self.navigationItem.rightBarButtonItem = item3;
        
    }
    
    self.navigationItem.leftBarButtonItems = leftArr;
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.myProgressView];

    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(0);
        
    }];
}

#pragma mark - 刷新页面
- (void)refresh:(UIBarButtonItem *)sender{
    
    [self.webView reload];
}
#pragma mark - 返回上个网页
-(void)before:(UIBarButtonItem *)sender{
    
    //判断是否能返回到H5上级页面
    if (self.webView.canGoBack==YES) {
        //返回上级页面
        [self.webView goBack];
        
    }else{
        //退出控制器
        [self back];
    }
}

- (void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(title))];
}

#pragma mark - 观察者-进度条，标题
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.myProgressView.alpha = 0.0f;
                
            } completion:^(BOOL finished) {
                
                [self.myProgressView setProgress:0 animated:NO];
                
            }];
            
        }
        
    }else if([keyPath isEqualToString:@"title"]
             && object == self.webView){
        self.navigationItem.title = self.webView.title;
        
    }else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
