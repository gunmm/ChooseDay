//
//  ZXYBtn.h
//  ZXYTabBarModel
//
//  Created by Rockeen on 15/11/18.
//  Copyright (c) 2015年 Rockeen https://github.com/rockeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXYBtn : UIControl

@property (nonatomic, strong)UIImageView *imgV;

@property (nonatomic, strong)UITabBarItem *item;

@property (nonatomic, strong)UILabel *lable;


/**
 *btn的初始化方法 ，需要两个参数：1。btn的frame大小 2.btn所需的数据
 */
-(id)initWithFrame:(CGRect)frame tabbarItem:(UITabBarItem *)item;

@end
