//
//  ZXYTabBarController.h
//  ZXYTabBarModel
//
//  Created by Rockeen on 15/11/18.
//  Copyright (c) 2015年 Rockeen https://github.com/rockeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXYTabBarController : UITabBarController

/**
 *tabbar上跟随者点击跑的图片
 */
@property (nonatomic, strong) UIImage *selectedImage;

/**
 * 默认第几个button为选中状态
 */
@property (nonatomic, assign) NSInteger selectCount;

/**
 *tabbar上的背景图片
 */
@property (nonatomic, strong) UIImage *tabbarImage;

/**
 *tabbar上的背景view
 */
@property (nonatomic, strong) UIView *tabbarView;

/**
 *选中状态下lable的字体颜色
 */
@property (nonatomic, strong) UIColor *selectLabColor;

/**
 *非选中状态下lable的字体颜色
 */
@property (nonatomic, strong) UIColor *nomalLabColor;

@end
