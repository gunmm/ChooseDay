//
//  ZHPickView.h
//  ZHpickView
//
//  Created by yuanfa deng on 16/2/4.
//  Copyright © 2016年 GXM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHPickView;

@protocol ZHPickViewDelegate <NSObject>

@optional
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString;

@end

@interface ZHPickView : UIView

@property(nonatomic,weak) id<ZHPickViewDelegate> delegate;
/**
 *  通过时间创建一个DatePicker
 *
 *  @param date               默认选中时间
 *  @param isHaveNavControler是否在NavControler之内
 *
 *  @return 带有toolbar的datePicker
 */
-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler;

/**
 *   移除本控件
 */
-(void)remove;
/**
 *  显示本控件
 */
-(void)show;
@end

