//
//  MyViewController.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/16.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "MyViewController.h"
#import "EnterViewController.h"
#import "ThemeViewController.h"
#import "InstallViewController.h"
#import "AboutViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "GUNMMAFN.h"

@interface MyViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *lists;


@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    //设置用户头像的属性
    self.userImg.layer.borderWidth = 1.f;
    
    self.userImg.layer.borderColor = [[UIColor grayColor]CGColor];
    
    self.userImg.layer.cornerRadius = 50.f;
    
    self.userImg.clipsToBounds = YES;
    
    //更新数据
//    [self updateData];

    //接收更新数据的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateData) name:@"updateWeiboData" object:nil];
    
//    [self updateQQData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateQQData) name:@"exitLogin" object:nil];
    
    
//    [self loginfor];
    
}

//接收登陆回调
- (void)loginfor{
    
}

//更新数据
-(void)updateQQData{

//    NSLog(@"hbjvbjae%@",kQQOpenID);
    
    if (kQQOpenID) {
        
        //加载QQ数据
        [self loadQQData];
        
        [self.tableView reloadData];

    }else {
    
        self.userName.text = @"登录";
        
        self.userImg.image = [UIImage imageNamed:@"myImage"];
        
    }

}

//加载QQ数据
-(void)loadQQData{

    NSString *url = @"https://graph.qq.com/user/get_user_info";
    
//    NSString *url = @"http://openapi.tencentyun.com/v3/user/get_info";
    
    NSDictionary *parameters = @{@"access_token":kQQAccessToken,@"oauth_consumer_key":kAppID,@"openid":kQQOpenID};
    
    [GUNMMAFN getDataWithParameters:parameters withUrl:url withBlock:^(id result) {
        
        NSLog(@"hbja%@",result);
        
        NSString *userName = [result objectForKey:@"nickname"];
        
        NSString *userImg = [result objectForKey:@"figureurl_qq_2"];
        
        self.userName.text = userName;
        
        [self.userImg setImageWithURL:[NSURL URLWithString:userImg]];
        
    }];
    
}

//更新微博数据
-(void)updateData{

    //判断是否授权
    if (kAccessToken) {
        
        [self loadData];
        
        [self createNavigationBarItem];
        
        [self.tableView reloadData];
        
    }else {
    
        self.userName.text = @"登录";
        
        self.userImg.image = [UIImage imageNamed:@"myImage"];
    
    }

}

//加载微博数据
-(void)loadData{

    //url
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    
//    NSLog(@"token===%@   id = %@",kAccessToken,kUserID);
    
    NSDictionary *parameters = @{@"access_token":kAccessToken,@"uid":kUserID};
    
    //管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *userName = [responseObject objectForKey:@"name"];
        
//        NSLog(@"name is %@",userName);
        
        NSString *userImg = [responseObject objectForKey:@"profile_image_url"];
        
        self.userName.text = userName;
        
        [self.userImg setImageWithURL:[NSURL URLWithString:userImg]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"____%@",error);
    }];

}

// 判断是否登录状态
- (BOOL)isLoggedIn {
    return NO;
}



//cell的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //获取cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //根据cell不同的tag值推出显示不同的页面
    if (cell.tag == 100) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂时不能登录！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertViewStyleDefault;
        
        [alert show];

    }else if (cell.tag == 110) {
    
        //主题切换
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"ThemeViewController" bundle:nil];
        
        ThemeViewController *themeVC = [story instantiateInitialViewController];
        
        [self.navigationController pushViewController:themeVC animated:YES];
    
    }else if (cell.tag == 111) {
    
        
    
    }else if (cell.tag == 120) {
    
        //设置
        InstallViewController *installVC = [[InstallViewController alloc]init];
        
        [self.navigationController pushViewController:installVC animated:YES];
    
    }else {
    
        //关于
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"AboutViewController" bundle:nil];
        
        AboutViewController *aboutVC = [story instantiateInitialViewController];
        
//        AboutViewController *aboutVC = [[AboutViewController alloc]init];
        
        [self.navigationController pushViewController:aboutVC animated:YES];
    
    }

}

//自定义导航项
-(void)createNavigationBarItem{

    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    
//    NSLog(@"------is :%@",kQQOpenID);
    
//    NSLog(@"------to--is %@",kAccessToken);
    
    if (kQQOpenID || kAccessToken|| [self isLoggedIn]) {
        
        [rightBtn setTitle:@"切换账号" forState:UIControlStateNormal];
        
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [rightBtn addTarget:self action:@selector(rightBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        
    }else {
    
        [rightBtn setTitle:@"" forState:UIControlStateNormal];
    
    }
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarItem;

}

//切换账号的点击方法
-(void)rightBtnAct:(UIButton *)btn{

    EnterViewController *enterVC = [[EnterViewController alloc]init];
    
    [self.navigationController pushViewController:enterVC animated:YES];
    
}

//销毁通知
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    AFNetworkReachabilityManager *reManager = [AFNetworkReachabilityManager sharedManager];
    
    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [reManager startMonitoring];
    
    
    [reManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status) {
            
            //判断登录的账号类型
            if (kUserName) {
                
                //如果是ChooseDay账号登录
                [self loginfor];
                
            }else if (kQQOpenID) {
                
                //如果是QQ账号登录
                [self updateQQData];
                
            }else {
                
                //如果是微博账号登录
                [self updateData];
                
            }
            
        }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无法连接到互联网" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            alert.alertViewStyle = UIAlertViewStyleDefault;
            
            alert.tag = 11;
            
            [alert show];
        }
    }];

    //    NSLog(@"%@",kUserName);
    
//    NSLog(@"xxxxx%@",self.userName.text);

    //添加切换账号
    [self createNavigationBarItem];

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
