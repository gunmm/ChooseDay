//
//  Created by 51 on 16/2/17.
//  Copyright © 2016年 Caoyq. All rights reserved.
//  注意一点：直接存储图片和存储url路径图片所用的数组是不一样

#import <UIKit/UIKit.h>

@protocol CycleScrollViewDelegate <NSObject>

- (void)clickImgAtIndex:(NSInteger)index;

@end

@interface CycleScrollView : UIView

@property (assign,nonatomic) BOOL pageHidden;/**< 是否隐藏UIPageController,默认不隐藏 */
@property (strong, nonatomic) NSArray *imgArray;/**< 普通图片数组 */
@property (strong, nonatomic) NSArray *urlArray;/**< url图片路径存储数组 */
@property (assign,nonatomic) BOOL autoScroll;/**< 是否自动滚动播放图片,default is NO */
@property (assign,nonatomic) float autoTime;/**< 滚动到下一张的间隔时间 */
@property (assign,nonatomic) id<CycleScrollViewDelegate> delegate;

//可选择的属性
@property (nonatomic, strong) UIColor *pageControlCurrentPageIndicatorTintColor;/**< 当前页码颜色 */
@property (nonatomic, strong) UIColor *PageControlPageIndicatorTintColor;/**< 其他页码颜色 */


@end
