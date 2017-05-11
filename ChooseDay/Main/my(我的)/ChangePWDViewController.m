//
//  ChangePWDViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "ChangePWDViewController.h"
#import <MaxLeap/MaxLeap.h>

@interface ChangePWDViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    
    UITextField *userName;//用户名
    
    UITextField *oldPwd;//旧密码

    UITextField *newPwd;//新密码
    
    UITextField *newPwd2;//确认密码

}

@end

@implementation ChangePWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改密码";
    
    self.view.backgroundColor = kBgColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    //创建输入框
    [self createTextField];
    
    //创建确认btn
    [self createCertainBtn];
    
    if (!kUserName) {
        
        //创建提示框
        [self createAlertView];
        
    }else {
    
        userName.text = kUserName;
    
    }
    
}

//如果用户未登录，创建提示框
-(void)createAlertView{

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请使用ChooseDay账号登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    alert.alertViewStyle = UIAlertActionStyleDefault;
    
    alert.tag = 12;
    
    [alert show];

}

//创建textField
-(void)createTextField{
    
    //用户名
    userName = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, kScreenW-60, 30)];
    
    userName.placeholder = @"请输入用户名";
    
    userName.layer.borderColor = [[UIColor grayColor]CGColor];
    
    userName.layer.borderWidth = .5;
    
    userName.layer.cornerRadius = 5.f;
    
    userName.clearButtonMode = UITextFieldViewModeAlways;
    
    userName.delegate = self;
    
    [self createClearView:userName];
    
    [self.view addSubview:userName];

    //旧密码
    oldPwd = [[UITextField alloc]initWithFrame:CGRectMake(userName.origin.x, userName.bottom+10, userName.width, userName.height)];
    
    oldPwd.placeholder = @"请输入旧密码";
    
    oldPwd.layer.borderWidth = .5;
    
    oldPwd.layer.borderColor = [[UIColor grayColor]CGColor];
    
    oldPwd.layer.cornerRadius = 5.f;
    
    oldPwd.secureTextEntry = YES;
    
    oldPwd.clearButtonMode = UITextFieldViewModeAlways;
    
    oldPwd.delegate = self;

    [self createClearView:oldPwd];
    
    [self.view addSubview:oldPwd];
    
    //新密码
    newPwd = [[UITextField alloc]initWithFrame:CGRectMake(oldPwd.origin.x, oldPwd.bottom+10, oldPwd.width, oldPwd.height)];
    
    newPwd.placeholder = @"请输入新密码";
    
    newPwd.layer.borderWidth = .5;
    
    newPwd.layer.borderColor = [[UIColor grayColor]CGColor];
    
    newPwd.layer.cornerRadius = 5.f;
    
    newPwd.secureTextEntry = YES;
    
    newPwd.clearButtonMode = UITextFieldViewModeAlways;
    
    newPwd.delegate = self;
    
    [self createClearView:newPwd];
    
    [self.view addSubview:newPwd];
    
    //确认密码
    newPwd2 = [[UITextField alloc]initWithFrame:CGRectMake(oldPwd.origin.x, newPwd.bottom+10, oldPwd.width, oldPwd.height)];
    
    newPwd2.placeholder = @"请确认新密码";
    
    newPwd2.layer.borderWidth = .5;
    
    newPwd2.layer.borderColor = [[UIColor grayColor]CGColor];
    
    newPwd2.layer.cornerRadius = 5.f;
    
    newPwd2.secureTextEntry = YES;
    
    newPwd2.clearButtonMode = UITextFieldViewModeAlways;
    
    newPwd2.delegate = self;
    
    [self createClearView:newPwd2];

    [self.view addSubview:newPwd2];

}

//创建空白view
-(void)createClearView:(UITextField *)text{

    //设置输入光标不靠左
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, text.height)];
    
    pwdView.backgroundColor = [UIColor clearColor];
    
    text.leftView = pwdView;
    
    text.leftViewMode = UITextFieldViewModeAlways;
    
    [text addSubview:pwdView];

}

//创建确认btn
-(void)createCertainBtn{

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(88, newPwd2.bottom+50, kScreenW-88*2, 50)];
    
    NSMutableArray *arr = kMainColor;
    btn.backgroundColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 10.f;
    
    [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];


}

//确认按钮的点击方法
-(void)btnAct:(UIButton *)btn{
    
    //如果是登录状态
    if (kUserName) {
        
        [[MLUser currentUser] checkIsPasswordMatchInBackground:oldPwd.text block:^(BOOL succeeded, NSError * _Nullable error) {
            
            if (succeeded) {
                
                //判断输入的密码是否一致
                if ([newPwd.text isEqual:newPwd2.text]) {
                    
                    //修改密码
                    [MLUser currentUser].password = newPwd.text;
                    
                    [[MLUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                        
                        NSLog(@"sucsess");
                        
                    }];
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的密码已修改" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    alert.alertViewStyle = UIAlertViewStyleDefault;
                    
                    alert.tag = 13;
                    
                    [alert show];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"username"];
                    
                }else {
                    
                    //如果输入的密码不一致
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"输入密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    alert.alertViewStyle = UIAlertViewStyleDefault;
                    
                    alert.tag = 10;
                    
                    [alert show];
                    
                }
                
            }
            
        }];
        
    }else {
        
        //如果是非登录状态
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户未登录！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertViewStyleDefault;
        
        alert.tag = 11;
        
        [alert show];
    
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    //判断alertView的作用
    if (alertView.tag == 10) {
        
        oldPwd.text = nil;
        
        newPwd.text = nil;
        
        newPwd2.text = nil;
        
    }else if (alertView.tag == 11) {
    
        userName.text = nil;
        
        oldPwd.text = nil;
        
        newPwd.text = nil;
        
        newPwd2.text = nil;

    }else {
    
        [self.navigationController popViewControllerAnimated:YES];
    
    }

    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

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
