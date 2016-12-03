//
//  LDCWebViewController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/23.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCWebViewController.h"
#import <WebKit/WebKit.h>

@interface LDCWebViewController ()

@property (weak, nonatomic) IBOutlet UIView *contantView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshItem;

@property (weak, nonatomic) WKWebView *webView;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation LDCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, LDCScreenW, LDCScreenH)];
    self.webView = webView;
    
    [self.contantView addSubview:webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    
    [webView loadRequest:request];
    
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.backItem.enabled = self.webView.canGoBack;
    self.forwardItem.enabled = self.webView.canGoForward;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
    self.title = self.webView.title;
}

-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

- (IBAction)refreshClick:(id)sender {
    
    [self.webView reload];
}

- (IBAction)forwardClick:(id)sender {
    
    [self.webView goForward];
}

- (IBAction)backClick:(id)sender {
    
    [self.webView goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
