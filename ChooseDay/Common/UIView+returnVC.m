//
//  UIView+returnVC.m
//  UI12-task03-响应者连
//
//  Created by wangjin on 15/11/17.
//  Copyright (c) 2015年 wangjin. All rights reserved.
//

#import "UIView+returnVC.h"

@implementation UIView (returnVC)

//返回视图控制器对象
-(UIViewController *)returnVC
{
    //1.获取到下一个响应者
    UIResponder *nextResponder = self.nextResponder;
    
    //2.循环获取
    while (nextResponder) {
        //判断是否为视图控制器对象
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            //如果是则返回该对象
            UIViewController *vc = (UIViewController *)nextResponder;
            
            return vc;
        }
        else
        {
            //如果不是 则获取下下个响应者对象
            nextResponder = nextResponder.nextResponder;
        }
        
    }
    return nil;
}

@end
