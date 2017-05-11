//
//  GuideView.h
//  引导页面
//
//  Created by apple on 15/11/23.
//  Copyright © 2015年 cheniue （辰悦科技 iOS 相随风雨 923205026）. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GuideViewCleanMode) {
    GuideViewCleanModeRect, //矩形
    GuideViewCleanModeRoundRect,      // 圆角矩形
    GuideViewCleanModeOval     //椭圆
};

@interface GuideView : UIView
@property(nonatomic)CGRect showRect;    //透明范围
@property(nonatomic)BOOL fullShow;  //透明范围全部显示
@property(nonatomic,strong)UIColor *guideColor; //覆盖颜色
@property(nonatomic)BOOL showMark;  //是否显示提示
@property(nonatomic,copy)NSString *markText;    //提示文本
@property(nonatomic)GuideViewCleanMode model;   //透明区域范围
@end
