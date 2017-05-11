//
//  GUNMMCityMangerVc.m
//  ChooseDay
//
//  Created by 闵哲 on 16/2/22.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "GUNMMCityMangerVc.h"
#import "GUNMMNavCityVC.h"

@interface GUNMMCityMangerVc ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataList;
    
    
    UITableView *nowCityTableView;
}

@end

@implementation GUNMMCityMangerVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"城市";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    

    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    //添加现有城市的表视图
    [self addNowCityTableView];
    
    
    //添加右侧按钮
    //创建添加城市的左侧按钮
    [self addRightBtn];

    
    
    
    
}
//创建添加城市的左侧按钮
- (void)addRightBtn{
    
    
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpace.width = -15;

    
    //初始化按钮
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    
    [ChooseDayUse showGoogleIconForView:rightBtn iconName:@"add" color:[UIColor whiteColor] font:29 suffix:nil];

    
    [rightBtn addTarget:self action:@selector(addAct) forControlEvents:UIControlEventTouchUpInside];
    
    
    //将按钮添加到 左侧导航栏
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItems = @[rightSpace,rightButton];;
    
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [nowCityTableView reloadData];
    
}


//添加现有城市的表视图
- (void)addNowCityTableView{
    
    //1.创建表视图
    nowCityTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64) style:UITableViewStylePlain];
    
    //2.设置数据源和代理
    nowCityTableView.delegate = self;
    nowCityTableView.dataSource = self;
    
    NSMutableArray *arr = kMainColor;
    nowCityTableView.backgroundColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
        
    nowCityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //3.添加到view
    [self.view addSubview:nowCityTableView];
    
    
//    //添加尾视图
//    nowCityTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 80)];
//    
//    //添加城市按钮入口
//    UIButton *addCityBtn = [[UIButton alloc]initWithFrame:CGRectMake(4, 4, kScreenW/2-4, 80)];
//    
//    [addCityBtn setBackgroundImage:[UIImage imageNamed:@"add_des_more.png"] forState:UIControlStateNormal];
//    
//    
//    [addCityBtn addTarget:self action:@selector(addAct) forControlEvents:UIControlEventTouchUpInside];
//    
//    [nowCityTableView.tableFooterView addSubview:addCityBtn];
}

//添加城市的按钮点击事件
- (void)addAct{
    
    [self.navigationController pushViewController:_city animated:YES];
}


#pragma mark----UITableView

//返回单元格数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    _dataList = kHistoryData;
    
    return _dataList.count;
}

//返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1.静态标示符
    static NSString *identifier = @"cell";
    
    //2.查看复用池
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //3.判断复用池中是否有单元格
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 44, 44)];
        [cell.contentView addSubview:label];
        
        label.textColor = [UIColor yellowColor];
        label.text = @"●";
//        label.tag = 1000;
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"    %@",_dataList[indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = [UIColor whiteColor];
    

    
    
    
    
    return cell;
}


//单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GUNMMNavCityVC *deleVC = [[GUNMMNavCityVC alloc]init];
    
    deleVC.cName = _dataList[indexPath.row];
    
    [self.navigationController pushViewController:deleVC animated:YES];
    
    
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
