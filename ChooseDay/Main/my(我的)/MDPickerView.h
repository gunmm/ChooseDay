//
//  MDPickerView.h
//  ChooseDay
//
//  Created by Vivian on 16/2/20.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MDPickerView;

@protocol MDPickerViewDelegate <NSObject>

@optional
-(void)tooBarDonBtnHaveClick:(MDPickerView *)pickView resultString:(NSString *)resultString;

@end

@interface MDPickerView : UIView

@property(nonatomic,weak) id<MDPickerViewDelegate> delegate;

@property (nonatomic,retain)NSArray *dataList;

-(instancetype)initWithFrame:(CGRect)frame WithDataList:(NSArray *)dataList;

-(void)remove;

-(void)show;

@end
