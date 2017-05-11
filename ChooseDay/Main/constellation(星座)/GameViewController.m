//
//  GameViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/3/3.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
{
   }

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBgColor;

    CGFloat width =self.image.size.width/3;
    CGFloat heigh =self.image.size.height/3;
    
    UIImageView *im =[[UIImageView alloc]initWithImage:self.image];
    im.frame=CGRectMake(self.view.center.x - kScreenW/4, kScreenH-kScreenW/2-20-69, kScreenW/2, kScreenW/2);
    
    
    
    [self.view addSubview:im];
    
    NSMutableArray *ary =[NSMutableArray array];
    for (int i=0; i<9; i++) {
        int row =i/3;
        int col =i%3;
        UIButton *btn =[UIButton buttonWithType:0];
        btn.frame=CGRectMake(30+col*((kScreenW-60)/3), 50+row*((kScreenW-60)/3), ((kScreenW-60)/3)-5, ((kScreenW-60)/3)-5);
        NSMutableArray *arrww = kMainColor;
        btn.backgroundColor = [UIColor colorWithRed:[arrww[0] floatValue] green:[arrww[1] floatValue] blue:[arrww[2] floatValue] alpha:1];;
        [self.view addSubview:btn];
        
        btn.tag =100+i;
        
        
        if (i!=2) {
            
            CGRect rec= CGRectMake(col*width, row*heigh, width, heigh);
            //裁剪图片
            CGImageRef imgref = CGImageCreateWithImageInRect(self.image.CGImage, rec);
            UIImage *little =[UIImage imageWithCGImage:imgref];
            CGImageRelease(imgref);
            
            UIImageView *imageView1 =[[UIImageView alloc]initWithFrame:CGRectMake(30+col*((kScreenW-60)/3), 50+row*((kScreenW-60)/3), ((kScreenW-60)/3)-5, ((kScreenW-60)/3)-5)];
            
            
            imageView1.image =little;
            [btn setImage:little forState:UIControlStateNormal];
            
        }
        [ary addObject: [NSValue valueWithCGRect:btn.frame]];
        
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //产生九个无序的
    NSMutableArray *ary1 =[NSMutableArray array];
    while (1) {
        int random =arc4random()%9;
        
        BOOL iscontaint = NO;
        for (NSNumber *num  in ary1) {
            if ([num intValue]==random) {
                iscontaint =YES;
            }
        }
        if (!iscontaint) {
            [ary1 addObject:[NSNumber numberWithInt:random]];
        }
        if (ary1.count ==9) {
            break;
        }
    }
    
    NSMutableArray *aryframe =[NSMutableArray array];
    for (int i=0; i<9; i++) {
        NSValue *value =ary[[ary1[i] intValue]];
        [aryframe addObject:value];
        
    }
    int index = 0;
    for (UIButton *btn in self.view.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.frame = [aryframe[index] CGRectValue];
            
            index ++;
        }
    }
    
    
       
}

-(void)btnClick:(UIButton *)btn1
{
    UIButton *b =(UIButton *)[self.view viewWithTag:102];
    // NSLog(@"%@",b.frame.origin);
    
    CGFloat x= b.frame.origin.x;
    CGFloat y =b.frame.origin.y;
    CGFloat x1= btn1.frame.origin.x;
    CGFloat y1 =btn1.frame.origin.y;
    
    
    if ((x==x1&&((int)fabs(y-y1)==(int)((kScreenW-60)/3)))||((y==y1&&(int)fabs(x-x1)==(int)((kScreenW-60)/3)))) {
        CGRect frame = b.frame;
        b.frame = btn1.frame;
        
        [UIView animateWithDuration:0.5 animations:^{
            btn1.frame = frame;

        }];
        
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
