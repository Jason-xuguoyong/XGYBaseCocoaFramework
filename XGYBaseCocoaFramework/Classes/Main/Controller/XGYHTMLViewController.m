//
//  XGYHTMLViewController.m
//  MomHelp
//
//  Created by XGY on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "XGYHTMLViewController.h"

@interface XGYHTMLViewController () <UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation XGYHTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
     [XGYMessageTool showLoadingHUD];
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:self.webView];
    self.webView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [XGYMessageTool showLoadingHUDWithErrorMessage:@"网络加载失败"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title=[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [XGYMessageTool hideLoadingHUD];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
