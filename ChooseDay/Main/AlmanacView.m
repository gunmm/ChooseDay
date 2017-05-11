//
//  AlmanacView.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "AlmanacView.h"

@implementation AlmanacView

- (void)awakeFromNib{

    _yiLable.font=[UIFont systemFontOfSize:12];
    _yiLable.textColor=nomalColor;
    
    _jiLable.font=[UIFont systemFontOfSize:12];
    _jiLable.textColor=nomalColor;


}


- (void)setAlmanacModel:(ZXYAlmanacModel *)almanacModel{
    
    
    
//    //创建一个日期格式化对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    //设置格式化对象日期格式
//    //yyyy-MM-dd HH-mm -ss  zz代表的时区
//    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
//    NSString* string = [dateFormatter stringFromDate:almanacModel.yangli];

    
    NSString *yangLiStr=[almanacModel.yangli substringWithRange:NSMakeRange(8, 2)];
    
    _timeLable.text=yangLiStr;
    _timeLable.font=[UIFont systemFontOfSize:50];
    
    
    NSMutableArray *arr = kMainColor;
    _timeLable.textColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    
    _wuxingLable.text=almanacModel.wuxing;
    
    if (almanacModel.yi.length>12) {
        
        NSString *str=[almanacModel.yi substringToIndex:10];
        
        _yiLable.text=str;
        
    }else{
    
    
        _yiLable.text=almanacModel.yi;
    }
    if (almanacModel.ji.length>9) {
        
        
        NSString *str=[almanacModel.ji substringToIndex:7];
        
        _jiLable.text=str;

        
    }else{
    
        _jiLable.text=almanacModel.ji;
    
    
    }
    
    
    _yinliLable.text=almanacModel.yinli;
//    NSLog(@"%f",self.height);
//    self.height=100;

}
@end
