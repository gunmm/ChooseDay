//
//  MatterViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "ThemeViewController.h"
#import "AppDelegate.h"

@interface ThemeViewController ()
{

    NSMutableArray *dic;
    
    UITableViewCell *_cell;
}
@end


@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"主题切换";
    
    self.view.backgroundColor = kBgColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    self.tableView.backgroundColor = kBgColor;
    
    self.label1.backgroundColor = [UIColor colorWithRed:250/255.0 green:128/255.0 blue:114/255.0 alpha:1];
    
    self.label1.layer.cornerRadius = 5.f;
    
    self.label1.clipsToBounds = YES;
    
    self.label2.backgroundColor = [UIColor colorWithRed:112/255.0 green:128/255.0 blue:144/255.0 alpha:1];
    
    self.label2.layer.cornerRadius = 5.f;
    
    self.label2.clipsToBounds = YES;
    
    self.label3.backgroundColor = [UIColor colorWithRed:242/255.0 green:134/255.0 blue:10/255.0 alpha:1];
    
    self.label3.layer.cornerRadius = 5.f;
    
    self.label3.clipsToBounds = YES;
    
    self.label4.backgroundColor = [UIColor colorWithRed:27/255.0 green:30/255.0 blue:37/255.0 alpha:1];
    
    self.label4.layer.cornerRadius = 5.f;
    
    self.label4.clipsToBounds = YES;
    
    self.label5.backgroundColor = [UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1];
    
    self.label5.layer.cornerRadius = 5.f;
    
    self.label5.clipsToBounds = YES;
    
    self.label6.backgroundColor = [UIColor colorWithRed:134/255.0 green:76/255.0 blue:27/255.0 alpha:1];
    
    self.label6.layer.cornerRadius = 5.f;
    
    self.label6.clipsToBounds = YES;
    
    self.label7.backgroundColor = [UIColor colorWithRed:123/255.0 green:104/255.0 blue:238/255.0 alpha:1];
    
    self.label7.layer.cornerRadius = 5.f;
    
    self.label7.clipsToBounds = YES;
    
    self.label8.backgroundColor = [UIColor colorWithRed:64/255.0 green:224/255.0 blue:208/255.0 alpha:1];
    
    self.label8.layer.cornerRadius = 5.f;
    
    self.label8.clipsToBounds = YES;
    
    dic = [NSMutableArray array];
    
    [self createNavigationItem];
    
    //根据选择的
    switch ([kNowTheme intValue]) {
        case 0:
            self.cell1.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 1:
            self.cell1.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 2:
            self.cell2.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 3:
            self.cell3.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 4:
            self.cell4.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 5:
            self.cell5.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 6:
            self.cell6.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 7:
            self.cell7.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 8:
            self.cell8.accessoryType = UITableViewCellAccessoryCheckmark;
            break;

        default:
            
            break;
            
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.accessoryType = UITableViewCellAccessoryNone;
    
    _cell.accessoryType = UITableViewCellAccessoryNone;

    //将之前点击的cell设置为不勾选
    switch ([kNowTheme intValue]) {
        case 0:
            self.cell1.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 1:
            self.cell1.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 2:
            self.cell2.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 3:
            self.cell3.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 4:
            self.cell4.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 5:
            self.cell5.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 6:
            self.cell6.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 7:
            self.cell7.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 8:
            self.cell8.accessoryType = UITableViewCellAccessoryNone;
            break;
        
        default:
        
        break;
        
    }

    //判断点击的cell
    switch (cell.tag) {
        case 1:
            
            [dic removeAllObjects];
            
            [dic addObject:@(250/255.0)];
            [dic addObject:@(128/255.0)];

            [dic addObject:@(114/255.0)];

            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            _cell = cell;

            break;
        
        case 2:
            
            [dic removeAllObjects];
            
            [dic addObject:@(112/255.0)];
            [dic addObject:@(128/255.0)];
            
            [dic addObject:@(144/255.0)];

            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            _cell = cell;

            break;
        case 3:

            
            [dic removeAllObjects];
            
            [dic addObject:@(242/255.0)];
            [dic addObject:@(134/255.0)];
            
            [dic addObject:@(10/255.0)];

            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            _cell = cell;
            
            break;
        case 4:

            
            [dic removeAllObjects];
            
            [dic addObject:@(27/255.0)];
            [dic addObject:@(30/255.0)];
            
            [dic addObject:@(37/255.0)];

            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            _cell = cell;

            break;
        case 5:
            
            
            [dic removeAllObjects];
            
            [dic addObject:@(100/255.0)];
            [dic addObject:@(149/255.0)];
            
            [dic addObject:@(237/255.0)];

            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            _cell = cell;

            
            break;
        case 6:
            
            [dic removeAllObjects];
            
            [dic addObject:@(134/255.0)];
            [dic addObject:@(76/255.0)];
            
            [dic addObject:@(27/255.0)];

            cell.accessoryType = UITableViewCellAccessoryCheckmark;
                _cell = cell;

            
            break;
        case 7:
            
            [dic removeAllObjects];
            
            [dic addObject:@(123/255.0)];
            [dic addObject:@(104/255.0)];
            
            [dic addObject:@(238/255.0)];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            _cell = cell;
            
            break;
        case 8:
            
            [dic removeAllObjects];
            
            [dic addObject:@(64/255.0)];
            [dic addObject:@(224/255.0)];
            
            [dic addObject:@(208/255.0)];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            _cell = cell;
            
            break;

            
        default:
            
            break;
    }
    
    NSLog(@"----%ld",(long)_cell.tag);
    
    [[NSUserDefaults standardUserDefaults] setObject:@(_cell.tag) forKey:@"knowTheme"];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"mainColor"];


}

//自定义导航项
-(void)createNavigationItem{

    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [leftBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = item;

}

-(void)leftBtn:(UIButton *)btn{

    if (_cell.selected) {
        
        AppDelegate *application = [UIApplication sharedApplication].delegate;
        

        
        [application loadNewView];
        
    }else {
    
        [self.navigationController popViewControllerAnimated:YES];
    
    }
    
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
