//
//  StartViewController.m
//  ChooseDay
//
//  Created by 岳晓阳 on 16/2/26.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "StartViewController.h"
#import "AppDelegate.h"
@interface StartViewController ()<UIScrollViewDelegate>{

    UIPageControl *_startPageV;
    UIImageView *_imgV;
    UIScrollView *scrollV;

}
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self CreatscrollView];
}
-(void)CreatscrollView{
    
    scrollV = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    //设置内容尺寸大小
    
    scrollV.pagingEnabled = YES;
    //scrollV的tag值
    scrollV.tag = 101;
    
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.delegate = self;
    
    scrollV.contentSize = CGSizeMake(kScreenW * 4, kScreenH);
    for (int i = 0; i < 4; i++) {
        _imgV = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenW, 0, kScreenW, kScreenH)];

        
        _imgV.image= [UIImage imageNamed:[NSString stringWithFormat:@"start%02d",i+1]];
        
        
       [scrollV addSubview:_imgV];
    
//判断是否为第四个imgv 创建按钮
    if (i==3) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenW-150, kScreenH-100, 150, 100)];
        [btn setTitle:@"开始体验" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
        //设置触摸响应
        _imgV.userInteractionEnabled = YES;
        [_imgV addSubview:btn];
        
     }
            }
    
    [self.view addSubview:scrollV];
    _startPageV = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _imgV.frame.size.height-30, _imgV.frame.size.width, 30)];
    _startPageV.numberOfPages = 4;
    _startPageV.pageIndicatorTintColor = [UIColor whiteColor];
    //设置当前页数
    _startPageV.currentPage = 0;
    _startPageV.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    _startPageV.tag = 201;
    [self.view addSubview:_startPageV];
    

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

//记录scrollView的当前位置
    int current = scrollView.contentOffset.x/kScreenW;
//根据ScrollView当前页对page赋值
    UIPageControl *page =(UIPageControl *) [self.view viewWithTag:201];

    page.currentPage = current;
//    if (page.currentPage ==3) {
//        [self scrollViewDisappear];
//    }
}
//-(void)scrollViewDisappear{
//    UIScrollView *scrollV = (UIScrollView*)[self.view viewWithTag:101];
//    UIPageControl *page =(UIPageControl *) [self.view viewWithTag:201];
////设置滑动图消失的动画效果
//[UIView animateWithDuration:.5 animations:^{
//        scrollV.center = CGPointMake(self.view.frame.size.width/2, 1.5*self.view.frame.size.height);
//}];
//
//}

-(void)btnAct:(UIButton *)btn{
    
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    
    [appdelegate loadViewController];
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
