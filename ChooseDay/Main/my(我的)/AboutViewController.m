//
//  AboutViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "AboutViewController.h"
#import "WebViewController.h"
#import "UseViewController.h"
#import "QRCodeGenerator.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于ChooseDay";
    
    self.view.backgroundColor = kBgColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;

    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    _emailAddress.text = @"924744097@qq.com";
    
    _qqAddress.text = @"924744097";
    
    _imgView.image = [QRCodeGenerator qrImageForString:@"ChooseDay测试二维码~" imageSize:_imgView.width];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.tag == 1) {
        
        //推出QQ邮箱
        WebViewController *webVC = [[WebViewController alloc]init];
        
        webVC.index = cell.tag;
        
        [self.navigationController pushViewController:webVC animated:YES];
        
    }else if (cell.tag == 3) {
    
        //推出使用帮助
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"UseViewController" bundle:nil];
        
        UseViewController *useVC = [story instantiateInitialViewController];
        
        useVC.view.backgroundColor = kBgColor;
        
        [self.navigationController pushViewController:useVC animated:YES];
    
    }else if (cell.tag == 2){
    
        //推出QQ邮箱
        WebViewController *webVC = [[WebViewController alloc]init];
        
        webVC.index = cell.tag;
        
        [self.navigationController pushViewController:webVC animated:YES];
    
    }else{
    
        //设置cell不能被点击
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    
    
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
