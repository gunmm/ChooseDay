//
//  InstallViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "InstallViewController.h"
#import "ChangePWDViewController.h"
#import "ServiceViewController.h"

#import "EnterViewController.h"

#import "SDImageCache.h"


@interface InstallViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{

    NSArray *_dataList;
    
    UITableView *_tableView;

    NSFileManager *manager;

}
@end

@implementation InstallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    self.view.backgroundColor = kBgColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    _dataList = @[@"修改密码",@"清除缓存",@"服务条款",@"分享软件"];

    //创建表视图
    [self createTableView];
    
    //创建退出按钮
    [self createExitBtn];
    
    //文件管理者
    manager = [NSFileManager defaultManager];

}


//创建提示框
-(void)createAlertView{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已成功删除缓存！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    alert.alertViewStyle = UIAlertViewStyleDefault;
    
    [alert show];
    
}

//创建分享视图
-(void)createActionSheet{

    

    
}


//创建退出按钮
-(void)createExitBtn{

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(88, _tableView.bottom+50, kScreenW-88*2, 50)];
    
    
    NSMutableArray *arr = kMainColor;
    btn.backgroundColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    
    
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 10.f;
    
    [btn addTarget:self action:@selector(ExitBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];

}

//创建表视图
-(void)createTableView{

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataList.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
    }
    
    if (indexPath.row==1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        
        label.text = [NSString stringWithFormat:@"%@M",[self sandBox]] ;
        
        label.textAlignment = NSTextAlignmentRight;
        
        cell.accessoryView = label;
    }
    
    cell.textLabel.text = _dataList[indexPath.row];
    
    cell.tag = 100+indexPath.row;
        
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.tag == 100) {
        
        //修改密码
        ChangePWDViewController *pwdVC = [[ChangePWDViewController alloc]init];
        
        [self.navigationController pushViewController:pwdVC animated:YES];
        
    }else if (cell.tag == 101) {
        
        //删除cache文件 清理缓存
        NSString *liabrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        
        //获取Caches文件路径
        NSString *cache = [liabrary stringByAppendingPathComponent:@"Caches"];
        

        //for in遍历library文件夹里的所有子文件
        for (NSString *filePath in [manager subpathsAtPath:cache]) {
            
            //转换filePath
            NSString *subPath = [cache stringByAppendingPathComponent:filePath];
            
            //删除指定文件
            [manager removeItemAtPath:subPath error:nil];
            
        }
//        NSLog(@"cache is:%@",cache);
        
        //弹出提示框
        [self createAlertView];
        
        //刷新表视图
        [_tableView reloadData];
    
    }else if (cell.tag == 102) {
    
        //服务条款
        ServiceViewController *serviceVC = [[ServiceViewController alloc]init];
        
        [self.navigationController pushViewController:serviceVC animated:YES];
    
    }else if (cell.tag == 103) {
    
        //分享软件
        [self createActionSheet];
    
    }else if (cell.tag == 104) {
    
        //主题切换
        
    
    }

}



// 判断是否登录状态
- (BOOL)isLoggedIn {
    return NO ;
}




-(void)ExitBtnAct:(UIButton *)btn{

    //判断是否有账号登录
    if (kQQOpenID || kAccessToken||[self isLoggedIn]) {
        
        //创建提示框
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已成功退出登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertActionStyleDefault;
        
        alert.delegate = self;
        
        alert.tag = 10;
        
        [alert show];
        
        //设置QQ、微博为nil
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"kOpenID"];
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"access_token"];
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"username"];

        //退出自有账号账号的登陆
        
        //发送通知，退出登录
        [[NSNotificationCenter defaultCenter]postNotificationName:@"exitLogin" object:nil];
        
    }else {
    
        //创建提示框
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertActionStyleDefault;
        
        [alert show];
    
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 10) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }

}

//沙盒目录
-(NSString *)sandBox{
    
    //获取library文件
    NSString *library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    
    //文件缓存数值
    float totalsize = 0;
    
    //for in遍历library文件夹里的所有子文件
    for (NSString *filePath in [manager subpathsAtPath:library]) {
        
        //转换filePath
        NSString *subPath = [library stringByAppendingPathComponent:filePath];
        
        //获取文件里的所有属性，都是存放在字典里
        NSDictionary *dic = [manager attributesOfItemAtPath:subPath error:nil];
        
        //赋值--- 文件大小
        totalsize += [dic[NSFileSize] floatValue];
        
    }

   //返回大小---存放的是字节，转换成M
    return [NSString stringWithFormat:@"%.1f",(totalsize/1024.0/1024.0 - 0.08f)];
}

//移除通知
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [_tableView reloadData];
    
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
