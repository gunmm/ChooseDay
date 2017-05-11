//
//  EnterViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "EnterViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "MyViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"

#import <MaxLeap/MaxLeap.h>

#import <TencentOpenAPI/TencentOAuth.h>

@interface EnterViewController ()<UITextFieldDelegate,TencentSessionDelegate>

{

    UITextField *pwdText;
    
    UITextField *nameText;

    
    //腾讯
    TencentOAuth *_tencentOAuth;
    
    MyViewController *_myVC;
    

}
@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"登录";
    
    
    self.view.backgroundColor = kBgColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    //创建自定义导航项
    [self createNavigationBarItem];
    
    //创建输入框
    [self createTextFiled];
    
    //创建登录按钮
    [self createEnterBtn];
    
    //创建微博登录btn
    [self createWeiBoEnterBtn];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"kOpenID"]) {
        
        //初始化
        [self initTencent];
        
    }
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(QQLogout) name:@"exitQQ" object:nil];
    
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

//初始化Tencent
-(void)initTencent{

    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:kAppID andDelegate:self];

}

//复写init方法
//-(instancetype)initWithBlock:(MyBlock)block{
//
//    self = [super init];
//    
//    if (self) {
//        
//        _block = block;
//        
//    }
//    
//    return self;
//
//}

//创建自定义导航项
-(void)createNavigationBarItem{

    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(rightBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;

}

//创建输入框
-(void)createTextFiled{

    //用户名
    nameText = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, kScreenW-60, 30)];
    
    nameText.placeholder = @"请输入ChooseDay账户用户名";
    
    nameText.layer.borderWidth = .5;
    
    nameText.layer.borderColor = [[UIColor grayColor]CGColor];
    
    nameText.layer.cornerRadius = 5.f;
    
    nameText.clearButtonMode = UITextFieldViewModeAlways;
    
    //设置输入光标不靠左
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, nameText.height)];
    
    nameView.backgroundColor = [UIColor clearColor];
    
    nameText.leftView = nameView;
    
    nameText.leftViewMode = UITextFieldViewModeAlways;
    
    nameText.delegate = self;
    
    [self.view addSubview:nameText];
    
    //密码
    pwdText = [[UITextField alloc]initWithFrame:CGRectMake(nameText.frame.origin.x, nameText.bottom+20, nameText.width, nameText.height)];
    
    pwdText.placeholder = @"请输入密码";
    
    pwdText.layer.borderWidth = .5;
    
    pwdText.layer.borderColor = [[UIColor grayColor]CGColor];
    
    pwdText.layer.cornerRadius = 5.f;
    
    pwdText.secureTextEntry = YES;
    
    pwdText.clearButtonMode = UITextFieldViewModeAlways;
    
    //设置输入光标不靠左
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, pwdText.height)];
    
    pwdView.backgroundColor = [UIColor clearColor];
    
    pwdText.leftView = pwdView;
    
    pwdText.leftViewMode = UITextFieldViewModeAlways;
    
    pwdText.delegate = self;

    [self.view addSubview:pwdText];

}

//创建登录按钮
-(void)createEnterBtn{

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(88, pwdText.bottom+50, kScreenW-88*2, 50)];
    
    NSMutableArray *arr = kMainColor;
    btn.backgroundColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    
    
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 10.f;
    
    [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];

}

//创建微博登录btn
-(void)createWeiBoEnterBtn{

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, kScreenH-64-200, kScreenW-40, 40)];
    NSMutableArray *arr = kMainColor;
    btn.backgroundColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    
    [btn setTitle:@"微博登录" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 10.f;
    
    [btn addTarget:self action:@selector(weiboBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UIButton *qqBtn = [[UIButton alloc]initWithFrame:CGRectMake(btn.origin.x, btn.bottom+10, btn.width, btn.height)];
    
    NSMutableArray *arrww = kMainColor;
    qqBtn.backgroundColor=[UIColor colorWithRed:[arrww[0] floatValue] green:[arrww[1] floatValue] blue:[arrww[2] floatValue] alpha:1];
    
    
    [qqBtn setTitle:@"QQ登录" forState:UIControlStateNormal];
    
    [qqBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    qqBtn.layer.cornerRadius = 10.f;
        
    [qqBtn addTarget:self action:@selector(qqBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:qqBtn];
    
}

//微博登录btn的点击方法
-(void)weiboBtnAct:(UIButton *)btn{

    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weibologin" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];

}

//qq登录btn的点击方法
-(void)qqBtnAct:(UIButton *)btn{

    //获取用户的参数---用户信息、移动端获取用户信息、同步分享到QQ空间和微博
    NSArray *permissons = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, kOPEN_PERMISSION_ADD_SHARE, nil];

    [_tencentOAuth authorize:permissons inSafari:NO];
    
}

//注册btn的点击方法
-(void)rightBtnAct:(UIButton *)btn{

    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    
    [self.navigationController pushViewController:registerVC animated:YES];

}

//登录btn的点击方法
-(void)btnAct:(UIButton *)btn{


    NSString *username =nameText.text;
    
    NSString *password =pwdText.text;
    
    if (username.length == 0) {
        
        [nameText becomeFirstResponder];
        
        [MBProgressHUD showError:@"请输入用户名" toView:self.view];
        
        return;
        
    }
    
    if (password.length == 0) {
        
        [pwdText becomeFirstResponder];
        
        [MBProgressHUD showError:@"请输入密码" toView:self.view];
        
        return;
        
    }
    
    [MLUser logInWithUsernameInBackground:username password:password block:^(MLUser *user, NSError *error) {
        if (user) {
            
            NSLog(@"user %@",user);
//            NSLog(@"user: %@, isNew: %d", user, user.isNew);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MLUserDidLoginNotification" object:self];
            
            //登陆成功用户名缓存
            _userDefault = [NSUserDefaults standardUserDefaults];

            [_userDefault setObject:nameText.text forKey:@"username"];

    
            //跳转回
             [self.navigationController popViewControllerAnimated:YES];
       
        } else {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:[NSString stringWithFormat:@"Code: %ld\n%@", (long)error.code, error.localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alertView show];
            
        }
        
    }];
    
    //设置为nil---相当于重新请求数据
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"access_token"];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"kOpenID"];

}

//获取个人信息
-(void)getUserInfoResponse:(APIResponse *)response{

    
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{

//    NSLog(@"tencentLogin success!");
    
    [_tencentOAuth getUserInfo];
    
    NSString *access_token = [_tencentOAuth accessToken];
    
    //持久化token
    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"kAccess_token"];
    
    //设置为nil---相当于重新请求数据
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"access_token"];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"username"];
    
    //持久化openId
    [[NSUserDefaults standardUserDefaults] setObject:[_tencentOAuth openId] forKey:@"kOpenID"];
    
    //    NSLog(@"kqqopenid is %@",kQQOpenID);
    
    //持久化expirationDate
    [[NSUserDefaults standardUserDefaults] setObject:[_tencentOAuth expirationDate] forKey:@"kExpirationDate"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{

    NSLog(@"tencentLogin faild!");

}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{

    NSLog(@"Have no NetWork!");

}


//return后收起键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;

}

//点击空白背景收起键盘
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
