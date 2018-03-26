//
//  ZXYCalendarHeadView.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "ZXYCalendarHeadView.h"
#import "WHUCalendarView.h"
#import "MJExtension.h"
#import "AFNetworking.h"

NSInteger const clearance=10;

@implementation ZXYCalendarHeadView{

    WHUCalendarView *_caview;

    
    NSDictionary *_dataDic;
    
    NSString *_dateString;
    
    NSInteger _status;
    
    UILabel *_noWifi;
    
    UILabel *_mengView;
    
    DataStr _dataT;
}


- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        _dataDic =[NSDictionary dictionary];

         _caview=[[WHUCalendarView alloc]initWithFrame:CGRectMake(0, 20,kScreenW, kScreenW/7*8)];
        
        __block ZXYCalendarHeadView *cal=self;

        
        _caview.onDateSelectBlk=^(NSDate *date){
        
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd"];
            _dateString = [format stringFromDate:date];
            
            
            
            [cal almanacData:[format stringFromDate:date]];
            
        
        };
        
        
        _status = 0;
        
        [self addSubview:_caview];
        
        
        
        
        NSDate * nowDate = [NSDate date];
        //创建一个日期格式化对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        //设置格式化对象日期格式
        //yyyy-MM-dd HH-mm -ss  zz代表的时区
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        
        NSString * dateStr = [dateFormatter stringFromDate:nowDate];

        
        [self almanacData:dateStr];

        self.frame=CGRectMake(0, 0, kScreenW, _caview.height+clearance+100);
        
        
        
        //黄历
        [self  almanac];

        //正在加载蒙版
        [self addMengView];
        
    }
    return self;
}


//加载数据
- (void)almanacData:(NSString *)dateStr{
    
    
    AFNetworkReachabilityManager *reManager = [AFNetworkReachabilityManager sharedManager];
    
    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [reManager startMonitoring];
    
    [reManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        _status=status;
        
        [self isLink:dateStr];

    }];

    
}


- (void)addMengView{



    _mengView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 100)];
    
    _mengView.backgroundColor=[UIColor whiteColor];
    
    
    
    NSMutableArray *arr = kMainColor;
    _mengView.textColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    
    _mengView.textAlignment=NSTextAlignmentCenter;
    
    _mengView.font=[UIFont systemFontOfSize:20];

    
    [_almanacView addSubview:_mengView];


}

-(void)isLink:(NSString *)dateStr
{
    //如果联网的话
    if ((_status != 0 )) {
        
        
        _mengView.hidden=NO;
        
        _mengView.text=@"正在加载，请稍候";

        
        if (_noWifi) {
            
            _noWifi.hidden=YES;
        }
        
        NSURL *URL = [NSURL URLWithString:@"http://v.juhe.cn/laohuangli/d"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        
        NSDictionary *parameter=@{@"key":@"b2db7c5227907eb0ad22fc11f739f93c",@"date":dateStr};
        
        
        
        @try{

            [manager GET:URL.absoluteString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
                nil;
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {



                _dataDic=[responseObject objectForKey:@"result"];

                _almanacView.almanacModel=[ZXYAlmanacModel mj_objectWithKeyValues:_dataDic];



                _dataT([_dataDic objectForKey:@"yangli"]);

                _mengView.hidden=YES;

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                NSLog(@"____%@",error);
            }];
        
        }
        @catch(NSException *exception){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:exception.reason delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            alert.alertViewStyle = UIAlertViewStyleDefault;
            
            alert.tag = 11;
            
            [alert show];
        }
        @finally{
            
        }
        
        
        
        
    }else{
        
        
        if (!_noWifi) {
            
            _noWifi=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 100)];
            
            _noWifi.backgroundColor=[UIColor whiteColor];
            
            _noWifi.text=@"无网络连接，请检查网络！";
            
            NSMutableArray *arr = kMainColor;
            _noWifi.textColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
            
            _noWifi.textAlignment=NSTextAlignmentCenter;
            
            _noWifi.font=[UIFont systemFontOfSize:20];
            
            
            [_almanacView addSubview:_noWifi];
            
            
            
            
    //回传默认当前时间
            NSDate * nowDate = [NSDate date];
            //创建一个日期格式化对象
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            //设置格式化对象日期格式
            //yyyy-MM-dd HH-mm -ss  zz代表的时区
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            
            NSString * dateStr = [dateFormatter stringFromDate:nowDate];

            _dataT(dateStr);

            
        }else{
            
            _noWifi.hidden=NO;
            
            
    //回传选中时间
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd"];
            
            NSString *selectDateString = [format stringFromDate:_caview.selectedDate];
            
            
            _dataT(selectDateString);

            [_almanacView bringSubviewToFront:_noWifi];
            
        }
        
//        _almanacView.height=0;
        
    }

}



- (void)returnDataStr:(DataStr)dataS{


    _dataT=dataS;


}


//黄历
- (void)almanac{

    
    _almanacView=[[NSBundle mainBundle]loadNibNamed:@"AlmanacView" owner:nil options:nil].lastObject;
    
    _almanacView.frame=CGRectMake(0,_caview.bottom , kScreenW, 100);
    
    
    _almanacView.height = 100;
    
    _almanacView.backgroundColor=[UIColor whiteColor];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, _almanacView.bottom, kScreenW, 20)];
    view.backgroundColor=[UIColor clearColor];
    
    
    [self addSubview:_almanacView];
    
    [self addSubview:view];

}


@end
