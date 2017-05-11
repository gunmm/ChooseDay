//
//  ZXYTabBarController.m
//  ZXYTabBarModel
//
//  Created by Rockeen on 15/11/18.
//  Copyright (c) 2015年 Rockeen https://github.com/rockeen. All rights reserved.
//

#import "ZXYTabBarController.h"
#import "ZXYBtn.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height


@interface ZXYTabBarController (){

    
    UIImageView *_selectedView;
    ZXYBtn *preBtn;

}

@end

@implementation ZXYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.移除原生的btn
    //2.创建自定义的btn
    //3.选中背景视图的滑动
    
    //创建自定义的tabBarview覆盖原生的 默认的标签栏高度--49
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 49)];
    
    
    //设置_tabbar响应触摸事件
    _tabbarView.userInteractionEnabled = YES;
    
    //将自定义的tabbar添加到原生tabbar上
    [self.tabBar addSubview:_tabbarView];
    
    //默认选中第一个
    self.selectCount=0;
    
}


/**
 *移除原生的btn
 */
-(void)removeTabBarButton
{
    //遍历原生tabbar上的所有子控件
    for (UIView *view in self.tabBar.subviews) {
        
        //判断子控件是否为UITabBarButton原生btn类型
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //移除原生btn
            [view removeFromSuperview];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //1.移除原生的btn
    [self removeTabBarButton];
    

}

-(void)setViewControllers:(NSArray *)viewControllers
{
    [super setViewControllers:viewControllers];
    
    //创建自定义btn
    [self createCustomBtn];
    


}



/**
 *添加自定义btn
 */
-(void)createCustomBtn
{
    //获取子控制器个数
    NSInteger count = self.viewControllers.count;
    
    //创建btn的选中视图
    CGFloat x=self.selectCount*kScreenW/count;
    CGFloat y=2;
    CGFloat w=kScreenW/count;
    CGFloat h=45;
    
    _selectedView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _selectedView.image = self.selectedImage;
    
    [_tabbarView addSubview:_selectedView];
    
    for(int i=0;i<count;i++)
    {
        //获取到tabbaritem 对应的子控制器
        UIViewController *vc = self.viewControllers[i];
        
        //创建btn 并且设置frame 与传入对应子控制器的tabBarItem属性
        ZXYBtn *btn = [[ZXYBtn alloc] initWithFrame:CGRectMake(i*kScreenW/count, 0, kScreenW/count, 49) tabbarItem:vc.tabBarItem];
        
        btn.lable.textColor=self.nomalLabColor;
        
        
        
        //添加btn的点击方法
        [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置第一个选中状态的图片
        if (i==self.selectCount) {
            
            if (btn.item.selectedImage!=nil) {
                
                btn.imgV.image=btn.item.selectedImage;

            }
            btn.lable.textColor=self.selectLabColor;
            preBtn=btn;
            btn.selected=YES;
            
            //通过下标实现页面切换
            self.selectedIndex = i;
        }
        
        
        //设置btn的tag值 用来记录btn下标
        btn.tag = 100 + i;
        
        //添加到父视图
        [_tabbarView addSubview:btn];
    }
    
    
    
}

-(void)btnAct:(ZXYBtn *)btn
{
    //    CustomBtn *btnt=[[CustomBtn alloc]init];
    
    //获取btn下标
    
    NSInteger index = btn.tag-100;
    
    //选中图片和非选中图片
    
    if (btn!=preBtn)
    {
        //正常状态
        preBtn.imgV.image= preBtn.item.image;
        preBtn.lable.textColor=self.nomalLabColor;
    
        //选中状态
        
        if (btn.item.selectedImage!=nil) {
        btn.imgV.image=btn.item.selectedImage;
        }
        btn.lable.textColor=self.selectLabColor;
    }
    
    
    
    //通过下标实现页面切换
    self.selectedIndex = index;
    
    [UIView animateWithDuration:.3 animations:^{
        
        //设置选中图片的中心点与被点击btn中心店相同
        _selectedView.center = btn.center;
    }];
    
    preBtn=btn;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
