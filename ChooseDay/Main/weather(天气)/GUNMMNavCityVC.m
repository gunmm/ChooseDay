//
//  GUNMMNavCityVC.m
//  ChooseDay
//
//  Created by 闵哲 on 16/2/23.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "GUNMMNavCityVC.h"

@interface GUNMMNavCityVC ()

@end

@implementation GUNMMNavCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    _cityName.text = _cName;
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)deleteAct:(UIButton *)sender {
    
    NSArray *arr1 = kHistoryData;
    
    
    NSMutableArray *arr2 = [NSMutableArray arrayWithArray:arr1];
    
    //遍历数组删除城市
    for (int i = 0;i<arr2.count;i++) {
        NSString *str = arr2[i];
        if ([str isEqualToString:_cName]){
            
            [arr2 removeObjectAtIndex:i];
        }
        
    }
    
    
    //持久化保存
    [[NSUserDefaults standardUserDefaults] setObject:arr2 forKey:@"historyData"];
    
    //发出删除通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"deleteNoti" object:nil];
     
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
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
