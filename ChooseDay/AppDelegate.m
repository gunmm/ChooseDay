//
//  AppDelegate.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/16.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "AppDelegate.h"
#import "CalaViewController.h"
#import "ConstellationViewController.h"
#import "WeatherViewController.h"
#import "MyViewController.h"
#import "ZXYTabBarController.h"
#import "ThreeNavigationController.h"
#import "UIImage+RTTint.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import <MaxLeap/MaxLeap.h>
#import "GuideView.h"

@interface AppDelegate ()
{

    BOOL isFirstLoad;//记录是否是第一次进入App
    
    //定位管理者
    CLLocationManager *_locManager;
    
    WeatherViewController *weatherVc;
    
    GuideView *markView;

}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置窗口
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor=[UIColor whiteColor];
    
    NSUserDefaults *userDefault = [[NSUserDefaults alloc]init];
    
    //获取bool值
    isFirstLoad = [userDefault boolForKey:@"first"];
    
    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(oauthFunc) name:@"weibologin" object:nil];
    
    //注册本地通知
    //判断当前设备的系统版本是否是大于8.0的
    if ([UIDevice currentDevice].systemVersion.floatValue > 8.0) {
        
        //创建通知
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        
        //注册通知
        [application registerUserNotificationSettings:settings];
        
    }
    
    
    //初始化颜色
    
    NSArray *arr = kMainColor;
    if (arr.count == 0) {
        [self loadBeginColor];

    }

    


    [self loadNewView];
    
    if (isFirstLoad == NO) {
        
        markView = [[GuideView alloc]initWithFrame:self.window.bounds];
        
        markView.fullShow = YES;
        
        markView.model = GuideViewCleanModeRoundRect;
        
        markView.showRect = CGRectMake(kScreenW/2-50, kScreenH/2-50, 100, 50);
        markView.backgroundColor = [UIColor redColor];
        
        [self.window addSubview:markView];
        
        [userDefault setBool:YES forKey:@"first"];
        
    }

    
    return YES;

}

//初始MainColor
- (void)loadBeginColor{
    
    NSMutableArray *dic = [NSMutableArray array];
    [dic addObject:@(250/255.0)];
    [dic addObject:@(128/255.0)];
    
    [dic addObject:@(114/255.0)];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"mainColor"];

}

-(void)loadNewView{
    
    [self loadViewController];
    
    
//    }
    
    
    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(oauthFunc) name:@"weibologin" object:nil];
    
    //分享功能
    [UMSocialData setAppKey:kUMAppkey];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:kAppID appKey:kAPPKEY url:@"http://www.umeng.com/social"];
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:kWXAppID appSecret:kWXAppSecret url:@"http://www.umeng.com/social"];
    
    
    //链接服务器
    [MaxLeap setApplicationId:@"56ca625760b2b393412e7d29" clientKey:@"YkNIQUVPM3JMTUdLT2wzaUdPVzJ3Zw" site:MLSiteCN];
    
//    [MaxLeap setApplicationId:@"your_application_id" clientKey:@"your_client_key" site:MLSiteCN];
    
    MLObject *obj = [MLObject objectWithoutDataWithClassName:@"Test" objectId:@"561c83c0226"];
    [obj fetchIfNeededInBackgroundWithBlock:^(MLObject * _Nullable object, NSError * _Nullable error) {
        if (error.code == kMLErrorInvalidObjectId) {
            NSLog(@"已经能够正确连接上您的云端应用");
        } else {
            NSLog(@"应用访问凭证不正确，请检查。");
        }
    }];
    
}
-(void)loadViewController{
    
    //初始化_locManager
    [self initLocManager];

    
    ZXYTabBarController *tabBar=[[ZXYTabBarController alloc]init];
    
    NSMutableArray *arr = kMainColor;
    tabBar.selectLabColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    tabBar.nomalLabColor=nomalColor;
    
    
    //创建子视图控制器
    
    //日历视图控制器
    CalaViewController *calendarVc=[[CalaViewController alloc]init];
    ThreeNavigationController *calendarNc=[[ThreeNavigationController alloc]initWithRootViewController:calendarVc];
    
    
    
    calendarVc.tabBarItem.image=[[UIImage imageNamed:@"calendar"]
                                 rt_tintedImageWithColor:nomalColor level:1];
    calendarVc.tabBarItem.selectedImage=[[UIImage imageNamed:@"calendar"]
                                         rt_tintedImageWithColor:[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1] level:1];
    calendarVc.title=@"日历";
    
    
    //星座视图控制器
    ConstellationViewController *constellationVc=[[ConstellationViewController alloc]init];
    ThreeNavigationController *constellationNc=[[ThreeNavigationController alloc]initWithRootViewController:constellationVc];
    
    constellationVc.tabBarItem.image=[[UIImage imageNamed:@"luck"]
                                      rt_tintedImageWithColor:nomalColor level:1];
    constellationVc.tabBarItem.selectedImage=[[UIImage imageNamed:@"luck"]rt_tintedImageWithColor:[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1] level:1];

    constellationVc.title=@"星座";
    
    
    //天气视图控制器
    weatherVc=[[WeatherViewController alloc]init];
    ThreeNavigationController *weatherNc=[[ThreeNavigationController alloc]initWithRootViewController:weatherVc];
    
    weatherVc.tabBarItem.image=[[UIImage imageNamed:@"weather"]
                                rt_tintedImageWithColor:nomalColor level:1];
    weatherVc.tabBarItem.selectedImage=[[UIImage imageNamed:@"weather"]
                                        rt_tintedImageWithColor:[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1] level:1];
    weatherVc.title=@"天气";
    
    
    //我的视图控制器
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MyViewController" bundle:nil];
    
    MyViewController *myVc = [storyBoard instantiateInitialViewController];
    
    //    MyViewController *myVc=[[MyViewController alloc]init];
    ThreeNavigationController *myNc=[[ThreeNavigationController alloc]initWithRootViewController:myVc];
    
    myVc.tabBarItem.image=[[UIImage imageNamed:@"my"]
                           rt_tintedImageWithColor:nomalColor level:1];
    myVc.tabBarItem.selectedImage=[[UIImage imageNamed:@"my"]
                                   rt_tintedImageWithColor:[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1] level:1];
    myVc.title=@"我的";
    
    //tabbar的主控制器
    tabBar.viewControllers=@[calendarNc,constellationNc,weatherNc,myNc];
    
    self.window.rootViewController=tabBar;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    CGPoint point = [[touches anyObject]locationInView:markView.superview];
    
     markView.showRect = CGRectMake(point.x-markView.showRect.size.width/2.0f, point.y-markView.showRect.size.height/2.0f, markView.showRect.size.width, markView.showRect.size.height);
    
    if (point.x>0 && point.x<100 && point.y>0 && point.y<60) {
        markView.showRect = CGRectMake(5, 20, 100, 30);

        
        markView.markText = @"添加待办事项(点击底部退出)";
        
    }else if (point.x>100 && point.x<250 && point.y>0 && point.y<60) {
        markView.showRect = CGRectMake(kScreenW/2-50, 30, 100, 30);

        
        markView.markText = @"设置年份or月份(点击底部退出)";

    }else if (point.x>100 && point.x<kScreenW && point.y>0 && point.y<60) {
        markView.showRect = CGRectMake(kScreenW - 50, 20, 45, 30);

    
        markView.markText = @"返回当前日期(点击底部退出)";
    
    }else if (point.x>0 && point.x<kScreenW &&point.y>60 && point.y<kScreenH*2/3) {
    

        markView.showRect = CGRectMake(0, 64, kScreenW, kScreenW/7*8-44);

        markView.markText = @"日历显示(点击底部退出)";
        
    }else if (point.x>0 && point.x<kScreenW && point.y>kScreenH*2/3 && point.y<(kScreenH*2/3+kScreenW/3)) {
        markView.showRect = CGRectMake(0, 64 + kScreenW/7*8-44, kScreenW, 100);


        markView.markText = @"黄历显示(点击底部退出)";
    
    }else if (point.x>0 && point.x<kScreenW && point.y>(kScreenH*2/3+kScreenW/3) && point.y<(kScreenH*2/3+kScreenW/3+kScreenW/10)) {
        markView.showRect = CGRectMake(0, 64 + kScreenW/7*8-44 + 100, kScreenW, 40);

        markView.markText = @"待办事项显示(点击底部退出)";
        
    
    }else {
    
        markView.hidden = YES;
        
    }

}

//第三方应用授权
-(void)oauthFunc{

    //设置开启调试模式
    [WeiboSDK enableDebugMode:YES];
    
    //注册appKey
    [WeiboSDK registerApp:kAppKey];
    
    if (!kAccessToken) {
    
        //初始化请求
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        
        //设置权限
        request.scope = @"all";
        
        //设置授权回调页
        request.redirectURI = kAppRedirectURL;
        
        //发送请求
        [WeiboSDK sendRequest:request];
        
    }

}

//移除通知
-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    NSLog(@"url is%@",url);
    
    return [WeiboSDK handleOpenURL:url delegate:self] || [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
        
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{

    return [WeiboSDK handleOpenURL:url delegate:self];

}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{

//    NSLog(@"url is%@",url);

    return [TencentOAuth HandleOpenURL:url];

}

//接收微博响应的信息
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    //获取token
    NSString *access_token = [(WBAuthorizeResponse *)response accessToken];
    
    //将token持久化保存
    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];
    
    //将用户id持久化保存
    [[NSUserDefaults standardUserDefaults] setObject:[(WBAuthorizeResponse *)response userID] forKey:@"kUserID"];
    
    //将刷新口令持久化保存
    [[NSUserDefaults standardUserDefaults] setObject:[(WBAuthorizeResponse *)response refreshToken] forKey:@"kRefreshToken"];
    
    //设置为nil----相当于重新请求了url
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"kOpenID"];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"username"];

    //发出更新通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"updateWeiboData" object:nil];
    
}

//初始化_locManager
- (void)initLocManager{
    
    //初始化_locManager对象
    _locManager = [[CLLocationManager alloc]init];
    
    //设置代理
    _locManager.delegate = self;
    
    //1.判断当前系统定位服务是否开启
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"系统定位服务未开启");
        return;
    }
    
    //2.判断当前应用是否获取定位授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        //更改授权状态
        [_locManager requestWhenInUseAuthorization];
        
    }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        NSLog(@"禁止修改授权状态");
        
    }
    
    //4.设置管理者属性
    
    //设置定位精度
    /*
     extern const CLLocationAccuracy kCLLocationAccuracyBestForNavigation //导航时最精确位置__OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0);
     extern const CLLocationAccuracy kCLLocationAccuracyBest; //最精确位置
     extern const CLLocationAccuracy kCLLocationAccuracyNearestTenMeters; //精确到十米范围
     extern const CLLocationAccuracy kCLLocationAccuracyHundredMeters;
     extern const CLLocationAccuracy kCLLocationAccuracyKilometer;
     extern const CLLocationAccuracy kCLLocationAccuracyThreeKilometers;
     */
    _locManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    //设置定位刷新距离 当移动距离大于100米时将重新定位
    _locManager.distanceFilter = 100;
    
    //开启区域追踪
    //初始化中心坐标 确定经纬度 纬度：北-正，南-负 经度：东-正，西-负
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(37, 112);
    
    //初始化区域范围
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:coordinate radius:1000 identifier:@"hehe"];
    [_locManager startMonitoringForRegion:region];
    
    //开启定位
    [_locManager startUpdatingLocation];
    
}

//当用户定位信息发生改变时调用
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //    NSLog(@"count is:%ld",locations.count);
    
    //1.从数组中获取到CLLocation对象 （数组中可能会存在多个对象，取出第一个最精确的对象）
    CLLocation *loc = locations[0];
    
    //取出经纬度
    CLLocationCoordinate2D coordinate = loc.coordinate;
    
    //    NSLog(@"精度：%f,纬度：%f",coordinate.longitude,coordinate.latitude);
    
    weatherVc.coordinate = coordinate;
    
}


//本地通知注册成功后调用的方法
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{

    NSLog(@"本地通知注册成功");
    
}

//本地注册失败过后调用的方法
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

    NSLog(@"error %@",error);

}

//本地通知回调函数，当应用程序在前台时调用
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{

    //更新显示的消息个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    
    badge --;
    
    badge = badge >= 0 ? badge : 0;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    
    //移除推送通知
    [self removeNotifition];

}

//移除推送通知
-(void)removeNotifition{
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //更新显示的消息个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    
    badge --;
    
    badge = badge >= 0 ? badge : 0;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    
    //移除推送通知
    [self removeNotifition];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
