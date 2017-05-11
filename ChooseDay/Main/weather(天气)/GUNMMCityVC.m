//
//  GUNMMCityVC.m
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "GUNMMCityVC.h"
#import "CityCollectionViewCell.h"
#import "WeatherViewController.h"

static NSString *identifier = @"cell";

static NSString *header = @"header";

static NSString *footer = @"footer";

@interface GUNMMCityVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITextFieldDelegate>
{
    
    CityBlock _block;
    
    UICollectionView *_collectionView;
    
    
    //城市数组
    NSArray *_newCityArr;
    
    
    //筛选前的数组
    NSMutableArray *_oldCityArr;
    
    
    
    //检索text
    UITextField *_textField;
    
    
}

@end

@implementation GUNMMCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    //接收_textFieldText值改变的通知
    [self receiveTextValueChange];

    
    //添加城市的collectionview
    [self addCollectionView];
    
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_collectionView reloadData];
}




//接收_textFieldText值改变的通知
- (void)receiveTextValueChange{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 10, kScreenW-40, 30)];
        
        _textField.backgroundColor = kBgColor;
        _textField.placeholder = @"请输入城市名";
        _textField.layer.cornerRadius = 10;
        _textField.layer.masksToBounds = YES;
        _textField.textAlignment = NSTextAlignmentCenter;
        
//        _textField.keyboardType = UIKeyboardTypeASCIICapable;
        _textField.delegate = self;
    }
    

    
//    if (_textField) {
//        _textField.delegate = self;
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textAct:) name:UITextFieldTextDidEndEditingNotification object:nil];
//    }
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSLog(@"------%@",_textField.text);
    
    //获取textfield
    
    
    NSString *str = [NSString stringWithFormat:@"%@",textField.text];
    
    
    //创建谓词条件
    NSPredicate *pred = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"self like[C]'*%@*'",str]];
    //通过谓词条件过滤
    
    
    
    
    _newCityArr = [_oldCityArr filteredArrayUsingPredicate:pred];
    
    NSLog(@"_new = %@",_newCityArr);
    [_collectionView reloadData];
    

    return YES;
}// called when 'return' key pressed. return NO to ignore.




//添加城市的collectionview
- (void)addCollectionView{
    
    //1.创建布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //设置单元格大小
    layout.itemSize = CGSizeMake((kScreenW-60)/3, 50);
    
    
    //设置单元格之间的间隙
    layout.minimumLineSpacing = 20;
    
    layout.minimumInteritemSpacing = 10;
    
    //设置头部视图和尾部视图大小
    layout.headerReferenceSize = CGSizeMake(kScreenW, 40);
    
    //    layout.footerReferenceSize = CGSizeMake(225, 20);
    

    
    //初始化
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64) collectionViewLayout:layout];
    
    //设置代理和数据源
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    //添加到view
    
    [self.view addSubview:_collectionView];
    
    
    //注册单元格和头部视图
    //注册单元格
    [_collectionView registerClass:[CityCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    
    //6.注册头部和尾部视图
    /*
     registerClass: 头部视图或尾部视图类型 UICollectionReusableView
     forSupplementaryViewOfKind：头部视图与尾部视图的区分
     withReuseIdentifier：标识符  不可以与单元格标识符混用
     */
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer];
    
    

    //数据源
    [self loadData];

}

//数据源
- (void)loadData{
    
    //开辟内存
    _oldCityArr = [NSMutableArray array];

    
    //文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"];
    
    //外层字典
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //数组
    NSArray *result = [dic objectForKey:@"result"];
    
    for (NSDictionary *cityDic in result) {
        
        
        int a = 1;
        
        //查看数组中是否有当前城市
        for (NSString *name in _oldCityArr) {
            if ([name isEqualToString:[cityDic objectForKey:@"city"]]) {
                a = 0;
                
                break;
            }
        }
        
        //如果没有侧添加
        if (a) {
            [_oldCityArr addObject:[cityDic objectForKey:@"city"]];
        }
        
        
    }
    
    _newCityArr = [NSArray arrayWithArray:_oldCityArr];
    
    
    
}


//返回单元格数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _newCityArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
   
    
    cell.cityName = _newCityArr[indexPath.row];
//    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //a用来标记是否查找到
    int a = 1;
    
    for (NSString *str in kHistoryData) {
        if ([str isEqualToString:_newCityArr[indexPath.row]]) {
            a = 0;
            break;
        }
    }
    
    
    if (a) {
        NSString *name = _newCityArr[indexPath.row];
        
        _block(name);
        
        [self.navigationController popViewControllerAnimated:NO];
        
//        WeatherViewController *weatherVC = [[WeatherViewController alloc]init];
//        
//        [self.navigationController popToViewController:weatherVC animated:YES];

    }

    
    
    
    
}

//创建头部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //判断类型是否为头部视图
    if (kind == UICollectionElementKindSectionHeader) {
        //创建头部视图
        UICollectionReusableView *headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
        
        [headerCell addSubview:_textField];
        
        return headerCell;
    }
    return nil;
}


//设置四周间距 上下左右
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


//单元格即将消失
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CityCollectionViewCell *celll = (CityCollectionViewCell *)cell;
    
    celll.label.textColor = [UIColor blackColor];
    celll.label.backgroundColor = kBgColor;
}

//block
- (void)getBlock:(CityBlock)cityBlock{
    

    _block = cityBlock;
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
