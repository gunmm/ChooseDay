//
//  ServiceViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "ServiceViewController.h"

@interface ServiceViewController ()

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"服务条款";
    
    self.view.backgroundColor = kBgColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    [self createLabel];
    
}

//创建文字说明
-(void)createLabel{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenW-20, kScreenH-20)];
    
    label.text = @"ChooseDay APP是我的毕业设计哈哈哈。";
    
    label.numberOfLines = 0;
    
    [label sizeToFit];
    
    [self.view addSubview:label];

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
