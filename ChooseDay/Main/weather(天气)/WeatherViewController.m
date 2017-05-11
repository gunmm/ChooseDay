//
//  WeatherViewController.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/16.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "WeatherViewController.h"
#import "OutCollectionView.h"
#import "GUNMMAFN.h"
#import "OutModel.h"
#import "WeatherModel.h"

#import "GUNMMCityVC.h"
#import "GUNMMCityMangerVc.h"


#import "MJExtension.h"
#import "AFNetworking.h"




@interface WeatherViewController ()
{
    
    //_outCollectionView  的数据
    NSMutableArray *_dataList;
    
    //用来  加载城市
    NSString *_city;
    
    //用来给  kHistoryData  赋值
    NSMutableArray *_cityName;
    
    //最外层CollectionView
    OutCollectionView *_outCollectionView;
    
    //推出的城市VC
    GUNMMCityVC *_cityVc;
    
    
    //分页控制器
    UIPageControl *_pageC;
    
    
    //用来标记  kHistoryData
    NSInteger _assign;
    
    //用来标记是否定位成功
    NSInteger _addressSuc;
    
    //用来标记是否是删除城市
    NSInteger _deleCi;
    
    //加载中显示的view
    UIView *_loadView;
    
    UILabel *loadLabel;
    
    
    
    //编码管理者
    CLGeocoder *_geoCoder;
}

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //设置标题颜色
    [self setTitleColor];

    
    
    _dataList = [NSMutableArray array];
    
    _cityName = [NSMutableArray array];
    
    
    _geoCoder = [[CLGeocoder alloc]init];
    
    
    _assign = 1;
    _addressSuc = 0;
    
    _deleCi = 0;
    
    
    NSLog(@"精度：%f,纬度：%f",_coordinate.longitude,_coordinate.latitude);
    

    //创建加载中显示的view
    [self createLoadingView];
    
    //判断是否联网
    [self almanacData];

    
    //创建添加城市的左侧按钮
    [self addLeftBtn];
    
    //添加分页控制器
    [self addPageControl];
    
    //创建外层collectionview
    [self createOutCollectV];
    
    
    //接收删除通知
    [self reciveDeleteNot];
    
    
    
}


//设置标题颜色
- (void)setTitleColor{
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    //隐藏navigationController下面的黑线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //隐藏navigationController下面的黑线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //设置导航栏不透明
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}
//接收删除通知
- (void)reciveDeleteNot{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteAct:) name:@"deleteNoti" object:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


//响应通知的方法
- (void)deleteAct:(NSNotification *)noti{
    _deleCi = 1;
    
    if (_addressSuc) {
        //取出定位城市
        OutModel *outModel = _dataList[0];
        
        //删除所有历史城市
        [_dataList removeAllObjects];
        //添加定位的城市
        [_dataList addObject:outModel];
    }
    else{
        //删除所有历史城市
        [_dataList removeAllObjects];

        
    }
    
    
    
    //添加新的历史城市
    [self loadHistoryWeather];
    
    
    [_outCollectionView reloadData];
    
    
    NSArray *arr = kHistoryData;
    
    NSLog(@"arr %@",arr);
    if (arr.count == 0 && _addressSuc) {
        _pageC.numberOfPages = 1;
        [_outCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    
    
    _pageC.currentPage = 0;



    
    
}




//反地理编码
- (void)reverseCode{
    //初始化CLLocation对象
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:_coordinate.latitude longitude:_coordinate.longitude];
    
    //反编码
    [_geoCoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            _addressSuc = 0;
            
            

            NSArray *arr = kHistoryData;
            if (arr.count) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无法定位到当前城市" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                alert.alertViewStyle = UIAlertViewStyleDefault;
                
                alert.tag = 11;
                
                [alert show];
                
                _assign = 0;
                [self loadHistoryWeather];

            }
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无法定位，您可以点击右上角添加城市" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                alert.alertViewStyle = UIAlertViewStyleDefault;
                
                alert.tag = 11;
                
                [alert show];
                
                [self leftBtnAct];


            }
        }
        else
        {
            //获取到反编码对象
            CLPlacemark *pm = [placemarks firstObject];
            /*
             pm.country  国家
             pm.locality 城市
             pm.subLocality 子城市
             pm.thoroughfare 街道
             pm.subThoroughfare 子街道
             */
            
            NSString *address = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",pm.country,pm.locality,pm.subLocality,pm.thoroughfare,pm.subThoroughfare];
            
            NSLog(@"addrss is:%@",address);
            
            NSLog(@"pm.name :%@",pm.name);
            
            
            NSRange range = [pm.locality rangeOfString:@"市"];
            
            
            //            NSString *a = @"jinan";
            
            NSMutableString *city = [NSMutableString stringWithString:pm.locality];
            
            if (range.length) {
                [city deleteCharactersInRange:range];
                
                
                _city = city;
                
                _addressSuc = 1;
                
                //加载当前需要天气数据
                [self loadCurrentDay];
            }
            else{
                
            }
            
           
            
        }
        
        
    }];
    
    
}




//创建加载中显示的view
- (void)createLoadingView{
    
    _loadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-49)];
    
//    _loadView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    _loadView.backgroundColor = [UIColor whiteColor];

    
    
    [self.view addSubview:_loadView];
    
    
    //创建风火轮
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    
    
    //开启风火轮  默认是关闭状态并且关闭状态时不显示
    [activity startAnimating];
    
    
    //    activity.backgroundColor = [UIColor redColor];
    
    [_loadView addSubview:activity];
    
    activity.center = CGPointMake(_loadView.center.x, _loadView.center.y-50);
    
    
    //添加label
    loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 20)];
    
    loadLabel.top = activity.bottom+10;
    
    loadLabel.text = @"正在加载......";
    
    loadLabel.font = [UIFont systemFontOfSize:14];
    
    loadLabel.textColor = [UIColor grayColor];
    
    loadLabel.textAlignment = NSTextAlignmentCenter;
    
    [_loadView addSubview:loadLabel];
    
    
    
    
}

//加载数据
- (void)almanacData{
    
    
    AFNetworkReachabilityManager *reManager = [AFNetworkReachabilityManager sharedManager];
    
    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [reManager startMonitoring];
    
    
    [reManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status) {
            
            loadLabel.text = @"正在加载......";

            //反地理编码
            [self reverseCode];
        
        }
        else{
            loadLabel.text = @"无法连接到互联网，请检查网络连接";
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无法连接到互联网" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            alert.alertViewStyle = UIAlertViewStyleDefault;
            
            alert.tag = 11;
            
            [alert show];
            
            
            

        }
    }];
    
    
}


//加载历史天气
- (void)loadHistoryWeather{
    
//    _city = @"";
    
    
    for (NSString *city in kHistoryData) {
        _city = city;
        
        [self loadCurrentDay];
        
    }
}



//添加分页控制器
- (void)addPageControl{
    
    _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenW - 80, 90, 70, 10)];
    
    //    _pageC.backgroundColor = [UIColor redColor];
    
    
    [self.view addSubview:_pageC];
    
}


//加载当前需要天气数据
- (void)loadCurrentDay{
    
    _loadView.hidden = NO;
    
    
    NSString *urlstr = @"http://op.juhe.cn/onebox/weather/query";
    
    
    NSDictionary *parameters = @{@"cityname":_city,@"key":@"b8b9b6f0294ff99d0043368504040174"};
    
    [GUNMMAFN getDataWithParameters:parameters withUrl:urlstr withBlock:^(id result) {
        //        NSLog(@"%@",result);
        
        NSDictionary *resu= [result objectForKey:@"result"];
        
        NSDictionary *data = [resu objectForKey:@"data"];
        
        [OutModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"weather":@"WeatherModel"};
        }];
        
        OutModel *outModel = [OutModel mj_objectWithKeyValues:data];
        
        
        [_dataList addObject:outModel];
        
        //设置_pageC的总显示页和右边靠屏幕
        _pageC.numberOfPages = _dataList.count;
        //        [_pageC sizeToFit];
        //        _pageC.left = 20;
        
        
        
        //数据加载完成 _outCollectionView重新加载数据
        [_outCollectionView reloadData];
        
        
        
        //因为删除时候原来写的滑动方法在数据没加载完就执行了有bug所以写的这个
        if (_deleCi) {
            [_outCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            _deleCi = 0;
        }
        
        
        //        [_cityVc dismissViewControllerAnimated:YES completion:nil];
        
        
        if (_assign) {
            
            //加载历史天气
            [self loadHistoryWeather];
            
            _assign = 0;
            
            _pageC.currentPage = 0;
            
            
        }
        
        
        _loadView.hidden = YES;
        
    }];
    
    
}


//创建外层collectionview
- (void)createOutCollectV{
    
    _outCollectionView = [[OutCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-49)];
    
    _outCollectionView.dataList = _dataList;
    
    _outCollectionView.pageC = _pageC;
    
    [self.view addSubview:_outCollectionView];
    
    //将分页控制器移动到最顶层
    [self.view bringSubviewToFront:_pageC];
    
    
    [self.view bringSubviewToFront:_loadView];
    
}


//创建添加城市的左侧按钮
- (void)addLeftBtn{
    
    
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpace.width = -15;

    //初始化按钮
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    

    [ChooseDayUse showGoogleIconForView:leftBtn iconName:@"add" color:[UIColor whiteColor] font:29 suffix:nil];
    

    
    [leftBtn addTarget:self action:@selector(leftBtnAct) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //将按钮添加到 左侧导航栏
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.rightBarButtonItems = @[rightSpace,leftButton];;
    
}


//导航栏添加城市按钮点击事件
- (void)leftBtnAct{
    
    
    
    
    _cityVc = [[GUNMMCityVC alloc]init];
    
    
    
    GUNMMCityMangerVc *cityManger = [[GUNMMCityMangerVc alloc]init];
    
    
    cityManger.city = _cityVc;
    cityManger.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:cityManger animated:NO];
    
    
    [_cityVc getBlock:^(NSString *cityName) {
        
        
        //清空用来标记历史城市的数组
        [_cityName removeAllObjects];
        
        
        NSArray *arr = kHistoryData;
        
        [_cityName insertObjects:kHistoryData atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, arr.count)]];
        
        
        
        _city = cityName;
        
        
        [_cityName addObject:_city];
        
        
        //持久化保存
        [[NSUserDefaults standardUserDefaults] setObject:_cityName forKey:@"historyData"];

        //没有定位时候走这个方法
        if (_assign) {
            _assign = 0;
//            NSLog(@"_*****%@",_cityName);
            
            [self loadHistoryWeather];

        }
        else{
            [self loadCurrentDay];

        }
        
        
       
        
    }];
    
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
