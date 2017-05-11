//
//  CityCollectionViewCell.m
//  ChooseDay
//
//  Created by 闵哲 on 16/1/20.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "CityCollectionViewCell.h"


@implementation CityCollectionViewCell{
    

}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _label = [[UILabel alloc]initWithFrame:self.bounds];
        
        _label.textAlignment = NSTextAlignmentCenter;
        
        _label.backgroundColor = kBgColor;
        
        _label.layer.cornerRadius = 10;
        _label.layer.masksToBounds = YES;
        
        
        
        [self addSubview:_label];
    }
    return self;
}


- (void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    
    //a用来标记是否查找到
    int a = 0;
    
    for (NSString *str in kHistoryData) {
        if ([str isEqualToString:_cityName]) {
            a = 1;
            break;
        }
    }
    
    
    if (a) {
        _label.textColor = [UIColor whiteColor];
        
        
        NSMutableArray *arr = kMainColor;
        _label.backgroundColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
        
    }
    
    
    
    _label.text = _cityName;
    
    
}

@end
