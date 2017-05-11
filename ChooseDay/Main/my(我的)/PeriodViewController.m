//
//  PeriodViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "PeriodViewController.h"
#import "ZHPickView.h"
#import "MDPickerView.h"
#import <MaxLeap/MaxLeap.h>

@interface PeriodViewController ()<UITableViewDelegate,ZHPickViewDelegate,MDPickerViewDelegate,UIAlertViewDelegate>
{

    ZHPickView *_pickerView;
    
    MDPickerView *_dayPickerView;
    
    NSArray *_intervalArr;
    NSArray *_realityArr;
    
    MLObject *_user;
    
    NSString *_password;

}

@property (nonatomic, strong) NSMutableArray *lists;

@end

@implementation PeriodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"生理期";
    
    self.view.backgroundColor = kBgColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    
    NSMutableArray *arr = kMainColor;
    _finishBtn.backgroundColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    _finishBtn.layer.cornerRadius = 5.f;
    
    //加载数据
    [self loadData];
    
    _user = [MLObject objectWithClassName:@"Information"];
    
    if (kUserName) {
        
        //设置显示用户设置的日期
        [self searchDate];
        
    }

    
}

//查询用户设置的日期
-(void)searchDate{
    
    MLQuery *query = [MLQuery queryWithClassName:@"Information"];
        
    [query whereKey:@"name" equalTo:kUserName];
    
    if (query) {
        
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            
            self.lists = [NSMutableArray array];
            
            [self.lists addObjectsFromArray:objects];
            
            if (self.lists.count == 0) {
                
                
            }else {
            
                MLObject *list = self.lists[0];
                
                _dateLabel.text = list[@"date"];
                
                _intervalLabel.text = list[@"interval"];
                
                _realityLabel.text = list[@"reality"];
                
            }
            
        }];
        
    }
    
}

- (IBAction)finishBtnAct:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设置成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    alert.alertViewStyle = UIAlertActionStyleDefault;
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    //发送推送通知
    [self createLocalNotification];
    
    [self.navigationController popViewControllerAnimated:YES];

}

//加载数据
-(void)loadData{

    //获取数据源
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"DayPlist" ofType:@"plist"];
    
    //获取字典
    NSDictionary *dayDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    //获取天数数组
    _intervalArr = [dayDic objectForKey:@"intervalDay"];
    
    _realityArr = [dayDic objectForKey:@"realityDay"];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //获取cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.tag == 1) {
        
        [_pickerView remove];
        
        [_dayPickerView remove];
        
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:1970];
        
        _pickerView = [[ZHPickView alloc]initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        
        _pickerView.delegate = self;
        
        [_pickerView show];
        
    }else if (cell.tag == 2) {
        
        [_pickerView remove];
    
        [_dayPickerView remove];
        
        _dayPickerView = [[MDPickerView alloc]initWithFrame:CGRectMake(0, kScreenH-256, kScreenW, 256) WithDataList:_intervalArr];
        
        _dayPickerView.delegate = self;
        
        _dayPickerView.tag = 10;
        
        [_dayPickerView show];
    
    }else {
    
        [_dayPickerView remove];
        
        [_pickerView remove];
        
        _dayPickerView = [[MDPickerView alloc]initWithFrame:CGRectMake(0, kScreenH-256, kScreenW, 256) WithDataList:_realityArr];
        
        _dayPickerView.delegate = self;
        
        _dayPickerView.tag = 11;
        
        [_dayPickerView show];

    }
    
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{

    _dateLabel.text = [resultString substringToIndex:10];
    
    if (kUserName) {
        
        _user[@"name"] = kUserName;
        
        _user[@"date"] = _dateLabel.text;
        
        [_user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
            NSLog(@"error %@",error);
            
        }];

    }

}

-(void)tooBarDonBtnHaveClick:(MDPickerView *)pickView resultString:(NSString *)resultString{

    if (pickView.tag == 10) {
        
        _intervalLabel.text = resultString;
        
        if (kUserName) {
            
            _user[@"name"] = kUserName;
            
            _user[@"interval"] = _intervalLabel.text;
            
            [_user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                
                NSLog(@"error %@",error);
                
            }];
            
        }
        
    }else {

        _realityLabel.text = resultString;
        
        if (kUserName) {
            
            _user[@"name"] = kUserName;
            
            _user[@"reality"] = _realityLabel.text;
            
            [_user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                
                NSLog(@"error %@",error);
                
            }];

        }
        
    }

}

//发送本地推送
-(void)createLocalNotification{

    //创建本地推送对象
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    
    //设置属性
    //设置提示内容
    notification.alertBody = @"今天你可能会有亲戚来看你！";
    
    //设置发出的时间
    //截取用户设置的推送时间
    //截取天数
    NSRange dayRange = {8,2};
    
    NSString *date = [_dateLabel.text substringWithRange:dayRange];
    
    //截取月数
    NSRange monthRange = {5,2};
    
    NSString *month = [_dateLabel.text substringWithRange:monthRange];
    
    NSInteger monthCount = [month integerValue];
    
    //截取年份
    NSRange yearRange = {0,4};
    
    NSInteger year = [[_dateLabel.text substringWithRange:yearRange] integerValue];
    
    //截取月经周期的天数
    NSString *interval = [_intervalLabel.text substringToIndex:2];
    
    //截取行经天数
    NSString *reality = [_realityLabel.text substringToIndex:1];
    
    //计算推送天数
    NSInteger integer = [date integerValue] + [interval integerValue] + [reality integerValue];
    
    //初始化每月的天数
    NSInteger day = 0;
    
    //初始化一月有31天的月份数组
    NSArray *array1 = @[@"01",@"03",@"05",@"07",@"08",@"10",@"12"];
    
    //判断当前月份是否在31天的月份数组
    if ([array1 containsObject:month]) {
        
        //如果在，当前月份就是31天
        day = 31;
        
    }else {
    
        //如果不在，当前月份就是30天
        day = 30;
    
    }
    
    //判断需要推送的天数是否大于当前月份的天数
    if (integer % day == 0) {
        
        monthCount ++;
        
    }else {
    
        monthCount =+2;
    
    }
    
    //判断当前月份是否大于12
    if (monthCount % 12 == 1) {
        
        //如果大于，年份加1
        year++;
        
    }
    
    //将计算出来的推送天数转化成秒
    NSInteger sec = integer * 24 * 60 * 60;
    
    //设置推送时间
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:sec];
    
    //设置时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    
    //设置锁屏状态下的提示文字
    notification.alertAction =  @"今天你可能会有亲戚来看你！";

    //设置是否显示锁屏状态下的提示文字
    notification.hasAction = YES;
    
    //设置title
    notification.alertTitle = @"ChooseDay友情提示：";
    
    //设置推送声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    //设置应用程序图标上显示的角标
    notification.applicationIconBadgeNumber = 1;
    
    //将通知添加到本地系统
    [[UIApplication sharedApplication]scheduleLocalNotification:notification];

}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [_dayPickerView remove];
    
    [_pickerView remove];

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
