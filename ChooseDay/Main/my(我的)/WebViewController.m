//
//  WebViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/21.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "WebViewController.h"
#import "AboutViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_index == 1) {
        
        //加载QQ邮箱网页
        [self createEmailWebView];
        
    }else {
        
        //加载QQ网页
        [self createQQWebView];
        
    }
    
}

-(void)createEmailWebView{

    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mail.qq.com"]];
    
    [webView loadRequest:request];
    
}

-(void)createQQWebView{

    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://web2.qq.com"]];
    
    [webView loadRequest:request];

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
