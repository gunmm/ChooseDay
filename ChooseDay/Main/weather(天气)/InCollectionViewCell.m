
//
//  InCollectionViewCell.m
//  ChooseDay
//
//  Created by 闵哲 on 16/1/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "InCollectionViewCell.h"

@implementation InCollectionViewCell{
    UILabel *_weekLabel;
    
    UILabel *_temUpLabel;
    
    UILabel *_temDownLabel;
    
    UILabel *_weatherLabel;
    
    UIImageView *_weatherImgV;
}



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //添加空间
        [self addControl];
        
    }
    
    return self;
}


//添加控件
- (void)addControl{
    
    //周几
    _weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.width, 20)];
    
    _weekLabel.textAlignment = NSTextAlignmentCenter;
    
    _weekLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:_weekLabel];
    
    //天气图片
    _weatherImgV = [[UIImageView alloc]initWithFrame:CGRectMake(10, _weekLabel.bottom + 20, kScreenW/8-10, kScreenW/8-10)];
    
//    _weatherImgV.backgroundColor = [UIColor blueColor];
    
    [self addSubview:_weatherImgV];
    
    //最高温度
    _temUpLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _weatherImgV.top, 10, 15)];
    
    _temUpLabel.textColor = [UIColor whiteColor];
    
    _temUpLabel.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:_temUpLabel];
    
    
    //最低温度
    _temDownLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 15)];
    
    _temDownLabel.textColor = [UIColor whiteColor];
    
    _temDownLabel.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:_temDownLabel];
    
    
    //天气
    _weatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 20)];
    
    _weatherLabel.textAlignment = NSTextAlignmentCenter;
    
    _weatherLabel.textColor = [UIColor whiteColor];
    
    _weatherLabel.bottom = self.bottom - 10;
    
    [self addSubview:_weatherLabel];

    

    
    
}


- (void)setModel:(WeatherModel *)model{
    _model = model;
    
    _weekLabel.text = [NSString stringWithFormat:@"周%@",_model.week];
    
    //最高温度
    _temUpLabel.text = [NSString stringWithFormat:@"%@°",_model.info.day[2]];
    
    [_temUpLabel sizeToFit];
    
    _temUpLabel.left = _weatherImgV.right;
    
    //最低温度
    _temDownLabel.text = [NSString stringWithFormat:@"%@°",_model.info.night[2]];
    
    [_temDownLabel sizeToFit];
    
    _temDownLabel.top = _temUpLabel.bottom;
    
    _temDownLabel.left = _weatherImgV.right;

    
    if (_temUpLabel.right>_temDownLabel.right) {
        _temDownLabel.right = _temUpLabel.right;
    }
    else{
        _temUpLabel.right = _temDownLabel.right;
    }
    
    
    //天气
    _weatherLabel.text = _model.info.day[1];

    
    //给_weatherImgV赋值
    [self valueForImgV];
    
}

//给_weatherImgV赋值
- (void)valueForImgV{
    
    NSString *weaStr = _model.info.day[1];
    NSString *imgName;
    
    /*
     晴 阴 多云 少云 小雨 中雨 大雨  阵雨 雷阵雨 暴雨
     雾，霾，霜冻，暴风，台风，暴风雪，大雪，中雪，小雪，雨夹雪 冰雹
     浮尘 扬沙
     */
    
    if ([weaStr isEqualToString:@"晴"]) {
        imgName = @"nd0";
    }
    else if ([weaStr isEqualToString:@"多云"]){
        imgName = @"nd1";
    }
    else if ([weaStr isEqualToString:@"阴"]){
        imgName = @"nd2";
    }
    else if ([weaStr isEqualToString:@"阵雨"]){
        imgName = @"nd3";
    }
    else if ([weaStr isEqualToString:@"雷阵雨"]){
        imgName = @"classic_ico_thundershower_with_hail_hd";
    }
    else if ([weaStr isEqualToString:@"雨夹雪"]){
        imgName = @"nd5";
    }
    else if ([weaStr isEqualToString:@"小雨"]){
        imgName = @"nd6";
    }
    else if ([weaStr isEqualToString:@"中雨"]){
        imgName = @"nd7";
    }
    else if ([weaStr isEqualToString:@"大雨"]){
        imgName = @"nd8";
    }
    else if ([weaStr isEqualToString:@"小雪"]){
        imgName = @"nd15";
    }
    else if ([weaStr isEqualToString:@"中雪"]){
        imgName = @"nd16";
    }
    else if ([weaStr isEqualToString:@"大雪"]){
        imgName = @"nd17";
    }
    else{
        NSLog(@"没找到");
    }
    
    _weatherImgV.image = [UIImage imageNamed:imgName];
    



    
    

}


@end
