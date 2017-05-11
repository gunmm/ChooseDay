//
//  CalendarViewController.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/16.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "CalaViewController.h"
#import "CslendarCell.h"
#import "MJRefresh.h"
#import "GtasksData.h"

@interface CalaViewController ()

@end

@implementation CalaViewController{
    
    
    UITableView *_tabView;
    
    UIView *_naView;
    
    
    NSString *_dataStr;
    
    
    BOOL isfirstload;
    
    NSInteger x;
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSMutableArray *arr = kMainColor;
    self.view.backgroundColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    
    
    self.navigationController.navigationBarHidden = YES;
    
    _headView=[[ZXYCalendarHeadView alloc]init];
    
    //添加tableView
    [self addTableView];
    
    //判断是否是第一次
    [self isFirst];
}


- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}




- (void)viewDidAppear:(BOOL)animated{
    
    
    
    
    
    
    [self addData];
    
    
    
    
}



- (void)isFirst{
    
    
    //数据持久化
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] init];
    
    //获取bool类型值（取值）
    isfirstload = [userDefault boolForKey:@"frist"];
    
    
    if (isfirstload == NO) {
        
        //创建数据
        [self creatData];
        
        //获取数据
        [self addData];
        
        //第一次加载后重新赋值（赋值）
        [userDefault setBool:YES forKey:@"frist"];
        
        
    }
    else
    {
        //获取数据
        [self addData];
        
        
    }
    
    
    
}



//获取数据
- (void)addData{
    
    //    1.获取文件路径
    NSString *jsonPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/gtasks.json"];
    
    //2.获取文件中内容
    NSData *jsondata = [NSData dataWithContentsOfFile:jsonPath];
    
    
    
    //3.解析json数据
    _gtasksAllDayDic = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:nil];
    
    
    _gtasksOneDayDic =[_gtasksAllDayDic objectForKey:_dataStr];
    
    _gtasksOneDayWillArray=[_gtasksOneDayDic objectForKey:@"Will"];
    
    
    _gtasksOneDayFinishArray=[_gtasksOneDayDic  objectForKey:@"Finish"];
    
    
    
    [_tabView reloadData];
    
    
    
    
    [_headView returnDataStr:^(NSString *dataS) {
        
        _dataStr=dataS;
        
        _gtasksOneDayDic=[_gtasksAllDayDic objectForKey:_dataStr];
        
        _gtasksOneDayWillArray=[_gtasksOneDayDic objectForKey:@"Will"];
        
        _gtasksOneDayFinishArray=[_gtasksOneDayDic  objectForKey:@"Finish"];
        
        [_tabView reloadData];
        
    }];
    
    
    
    
    
    
}

//添加tableView
- (void)addTableView{
    
    
    _tabView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-49)];
    
    _tabView.delegate=self;
    
    
    NSMutableArray *arr = kMainColor;
    _tabView.backgroundColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    
    
    _tabView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    _tabView.dataSource=self;
    
    _tabView.showsVerticalScrollIndicator = NO;
    
    _tabView.tableHeaderView=_headView;
    
    
    
    [self.view addSubview:_tabView];
    
}


- (void)pushGtasks{
    
    
    
    
    
    
    
}

//视图滑动时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (_tabView.contentOffset.y<0) {
        
        _tabView.contentOffset=CGPointMake(0, 0);
        
    }
    
    
}




//第一次加载创建数据
- (void)creatData{
    
    //1.获取json文件路径
    NSString *jsonPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/gtasks.json"];
    //    NSLog(@"jsonPath:%@",jsonPath);
    
    //2.创建要写入的数据
    _gtasksAllDayDic=[NSMutableDictionary dictionary];
    _gtasksOneDayWillArray=[NSMutableArray array];
    _gtasksOneDayFinishArray=[NSMutableArray array];
    
    //3.将数据装化为json规格的data数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_gtasksAllDayDic options:NSJSONWritingPrettyPrinted error:nil];
    
    //4.将json数据写入到文件中
    //如果文件不存在 则自动创建新的文件
    BOOL result = [jsonData writeToFile:jsonPath atomically:YES];
    
    if (result) {
        NSLog(@"写入成功");
    }
    else
    {
        NSLog(@"写入失败");
    }
    
    
    
}


#pragma mark-----UITableViewDataSouce


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _gtasksOneDayWillArray.count;
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifer=@"Cell";
    
    CslendarCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    
    
    if (!cell) {
        
        cell=[[ NSBundle mainBundle]loadNibNamed:@"CslendarCell" owner:nil options:nil].lastObject;
    }
    
    //黄色原点
    cell.circleView.layer.cornerRadius=2.5;
    cell.circleView.layer.masksToBounds=YES;
    cell.circleView.backgroundColor=[UIColor yellowColor];
    
    
    //倒序排列
    x=_gtasksOneDayWillArray.count-1-indexPath.row;
    
    cell.textLable.text=_gtasksOneDayWillArray[x];
    cell.textLable.textColor=[UIColor whiteColor];
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    //选中按钮
    cell.yesBtn.hidden=YES;
    //    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(cell.width-10-20, 10, 20, 20)];
    
    UIButton *btn=[UIButton new];
    
    
    
    
    
    
    btn.backgroundColor=[UIColor clearColor];
    
    [btn setImage:[UIImage imageNamed:@"check_false.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"check_true.png"] forState:UIControlStateHighlighted];
    
    
    [btn addTarget:self action:@selector(yesBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell addSubview:btn];
    
    cell.tag=_gtasksOneDayWillArray.count-1-indexPath.row;
    
    NSMutableArray *arr = kMainColor;
    cell.backgroundColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    
    
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(cell).with.offset(-10);
        
        make.top.equalTo(cell).with.offset(10);
        
        
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
        
        
    }];
    
    return cell;
    
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *hewrdView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
    
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, kScreenW, 20)];
    
    
    NSString *text=[NSString stringWithFormat:@"今日待办事项(%ld)",(unsigned long)_gtasksOneDayWillArray.count];
    
    titleLable.text=text;
    
    
    
    titleLable.textColor=[UIColor whiteColor];
    
    titleLable.textAlignment=NSTextAlignmentCenter;
    
    [hewrdView addSubview:titleLable];
    
    return  hewrdView;
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    
    return 30;
    
    
}

#pragma mark-----点击yesbutton

- (void)yesBtnAct:(UIButton *)btn{
    
    
    CslendarCell *cell=(CslendarCell *)btn.superview;
    
    
    [self deleteData:cell.tag];
}





//删除数据
- (void)deleteData:(NSInteger)num{
    
    
    
    GtasksData *gtd=[GtasksData new];
    
    [gtd deleteOneDayWillArray:_dataStr index:num];
    
    
    [self addData];
    
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
