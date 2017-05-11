//
//  PushViewController.m
//  ChooseDay
//
//  Created by 闵哲 on 16/2/27.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "PushViewController.h"
#import "GameViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    imgV.image = self.backgroundImg;
    
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view insertSubview:imgV atIndex:0];

    // Do any additional setup after loading the view from its nib.
    
    _constellationName.text = _model.name;
    
    _data.text = _model.datetime;
    
    _summary.text = _model.summary;
    
    _summary.shadowOffset = CGSizeMake(.3, .3);
    
    _summary.shadowColor = [UIColor blackColor];
    
    _health.text = _model.health;
    
    _QFriend.text = _model.QFriend;
    
    _money.text = _model.money;
    
    _work.text = _model.work;
    
    _all.text = _model.all;
    
    _color.text = _model.color;
    
    _love.text = _model.love;
    
    _number.text = [NSString stringWithFormat:@"%@",_model.number];
    
    [self createNavigationItem];
    
    UIView *maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    maskView.backgroundColor = [UIColor blackColor];
    
    maskView.alpha = .2;
    
    [self.view insertSubview:maskView aboveSubview:imgV];
    
}

-(void)createNavigationItem{

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    
    [btn setTitle:@"小游戏" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = item;

}

-(void)btnAct:(UIButton *)btn{

    GameViewController *game = [[GameViewController alloc]init];
    
    game.image = self.backgroundImg;
    
    [self.navigationController pushViewController:game animated:YES];

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
