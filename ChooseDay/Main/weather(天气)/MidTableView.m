
//
//  MidTableView.m
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "MidTableView.h"
#import "InCollectionView.h"

@implementation MidTableView{
    
    UILabel *_temperLabel;
    
    UILabel *_weatherLable;
    
    UILabel *_windLabel;
    
    UILabel *_pm25Label;
    
    UILabel *_qualityLabel;
    
    UILabel *_cityLabel;

}

//init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        
        //设置数据源和代理
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    //头视图
    [self addHeaderView];
    
    self.backgroundColor = [UIColor clearColor];
    
    
    return self;
}

- (void)setOutModel:(OutModel *)outModel{
    _outModel = outModel;
    
    //当前温度
    _temperLabel.text = [NSString stringWithFormat:@"%@°",_outModel.realtime.weather.temperature];
    
    [_temperLabel sizeToFit];
    
    
    //天气
    _weatherLable.left = _temperLabel.right - 15;
    
    _weatherLable.bottom = _temperLabel.bottom - 10;
    
    _weatherLable.text = _outModel.realtime.weather.info;
    
    [_weatherLable sizeToFit];
    
    
    //风速
    _windLabel.top = _temperLabel.bottom - 10;
    
    _windLabel.text = [NSString stringWithFormat:@"%@%@",_outModel.realtime.wind.direct,_outModel.realtime.wind.power];
    [_windLabel sizeToFit];
    
    
    //pm2.5
    _pm25Label.top = _windLabel.bottom;
    
    _pm25Label.text = [NSString stringWithFormat:@"PM2.5 : %@",_outModel.pm25.pm25.pm25];
    
    [_pm25Label sizeToFit];
    
    _qualityLabel.top = _pm25Label.bottom;
    
    _qualityLabel.text = _outModel.pm25.pm25.quality;
    
    [_qualityLabel sizeToFit];
    
    
    _cityLabel.text = _outModel.pm25.cityName;
    [_cityLabel sizeToFit];
    _cityLabel.right = kScreenW-20;

    
    
    //设置背景图片视图
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_outModel.realtime.city_name]];
    
    UIImageView *bGimgV;

    
    if (image) {
        bGimgV = [[UIImageView alloc]initWithImage:image];
        //        cell.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    else{
       
        bGimgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"其他.jpg"]];
        
    }
    
    bGimgV.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundView = bGimgV;


}


//头视图
- (void)addHeaderView{
    
    self.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 467)];
    

    
    _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW-80, 30, 70, 70)];
    _cityLabel.textColor = [UIColor whiteColor];
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    _cityLabel.font = [UIFont systemFontOfSize:30];
    [self.tableHeaderView addSubview:_cityLabel];

    
    //    self.tableHeaderView.backgroundColor = [UIColor blueColor];
    
    //温度label
    _temperLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 300, 70, 70)];
    
    
    _temperLabel.font = [UIFont systemFontOfSize:70];
    
    
    
    _temperLabel.textColor = [UIColor whiteColor];
    
    [self.tableHeaderView addSubview:_temperLabel];
    
    //天气label
    _weatherLable = [[UILabel alloc]initWithFrame:CGRectMake(_temperLabel.right, _temperLabel.bottom-30, 30, 30)];
    
    _weatherLable.font = [UIFont systemFontOfSize:20];
    
    _weatherLable.textColor = [UIColor whiteColor];
    
    [self.tableHeaderView addSubview:_weatherLable];
    
    
    //风力label
    _windLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 30, 20)];
    
    _windLabel.font = [UIFont systemFontOfSize:16];
    
    _windLabel.textColor = [UIColor whiteColor];
    
    [self.tableHeaderView addSubview:_windLabel];
    
    
    
    //pm2.5
    _pm25Label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 30, 20)];
    
    _pm25Label.font = [UIFont systemFontOfSize:17];
    
    _pm25Label.textColor = [UIColor whiteColor];
    
    [self.tableHeaderView addSubview:_pm25Label];
    
    
    _qualityLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 30, 15)];
    
    _qualityLabel.font = [UIFont systemFontOfSize:13];
    
    _qualityLabel.textColor = [UIColor whiteColor];
    
    [self.tableHeaderView addSubview:_qualityLabel];
    
    

    
    
    
    
    
    
    
}

#pragma mark----MidTableView
//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

//返回单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    //分类文字
    UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    remindLabel.font = [UIFont systemFontOfSize:14];
    
    NSMutableArray *arr = kMainColor;
    remindLabel.textColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    
    remindLabel.backgroundColor = [UIColor clearColor];
    
    
    [cell addSubview:remindLabel];
    
    
    
    switch (indexPath.row) {
        case 0:{
            
            //天气
            InCollectionView *inCollectionView = [[InCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 130)];
            
            inCollectionView.dataList = _outModel.weather;
            
            cell.backgroundColor = [UIColor clearColor];
            
            [cell addSubview:inCollectionView];
           
        }
            
        break;
            
        case 1:
        {
            NSArray *lifeArr =@[@"穿衣",@"运动",@"感冒",@"空调",@"洗车"];
            
            //生活
            remindLabel.text = @"生活";
            
            //穿衣
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(55, remindLabel.bottom, 100, 8)];
            label1.font = [UIFont systemFontOfSize:14];
            
            label1.textColor = [UIColor whiteColor];
            label1.text = _outModel.life.info.chuanyi[0];
            [cell addSubview:label1];
            
            UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(55, label1.bottom+10, kScreenW - 55, 30)];
            
            label11.font = [UIFont systemFontOfSize:12];
            label11.textColor = [UIColor whiteColor];
            label11.numberOfLines = 2;
            label11.text = _outModel.life.info.chuanyi[1];
            [label11 sizeToFit];
            [cell addSubview:label11];
            
            //运动
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(55, label11.bottom+10, 100, 8)];
            label2.font = [UIFont systemFontOfSize:14];
            
            label2.textColor = [UIColor whiteColor];
            label2.text = _outModel.life.info.yundong[0];
            [cell addSubview:label2];
            
            UILabel *label22 = [[UILabel alloc]initWithFrame:CGRectMake(55, label2.bottom+10, kScreenW - 55, 30)];
            
            label22.font = [UIFont systemFontOfSize:12];
            label22.textColor = [UIColor whiteColor];
            label22.numberOfLines = 2;
            label22.text = _outModel.life.info.yundong[1];
            [label22 sizeToFit];
            [cell addSubview:label22];
            
            //感冒
            UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(55, label22.bottom+10, 100, 8)];
            label3.font = [UIFont systemFontOfSize:14];
            
            label3.textColor = [UIColor whiteColor];
            label3.text = _outModel.life.info.ganmao[0];
            [cell addSubview:label3];
            
            UILabel *label33 = [[UILabel alloc]initWithFrame:CGRectMake(55, label3.bottom+10, kScreenW - 55, 30)];
            
            label33.font = [UIFont systemFontOfSize:12];
            label33.textColor = [UIColor whiteColor];
            label33.numberOfLines = 2;
            label33.text = _outModel.life.info.ganmao[1];
            [label33 sizeToFit];
            [cell addSubview:label33];
            
            //空调
            UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(55, label33.bottom+10, 100, 8)];
            label4.font = [UIFont systemFontOfSize:14];
            
            label4.textColor = [UIColor whiteColor];
            label4.text = _outModel.life.info.kongtiao[0];
            [cell addSubview:label4];
            
            UILabel *label44 = [[UILabel alloc]initWithFrame:CGRectMake(55, label4.bottom+10, kScreenW - 55, 30)];
            
            label44.font = [UIFont systemFontOfSize:12];
            label44.textColor = [UIColor whiteColor];
            label44.numberOfLines = 2;
            label44.text = _outModel.life.info.kongtiao[1];
            [label44 sizeToFit];
            [cell addSubview:label44];
            
            //洗车
            UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(55, label44.bottom+10, 100, 8)];
            label5.font = [UIFont systemFontOfSize:14];
            
            label5.textColor = [UIColor whiteColor];
            label5.text = _outModel.life.info.xiche[0];
            [cell addSubview:label5];
            
            UILabel *label55 = [[UILabel alloc]initWithFrame:CGRectMake(55, label5.bottom+10, kScreenW - 55, 30)];
            
            label55.font = [UIFont systemFontOfSize:12];
            label55.textColor = [UIColor whiteColor];
            label55.numberOfLines = 2;
            label55.text = _outModel.life.info.xiche[1];
            [label55 sizeToFit];
            [cell addSubview:label55];

            
            for (int i = 0; i < lifeArr.count; i++) {
                
                //图标
                UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(20, remindLabel.bottom + 50*i , 30, 30)];
                
                imgV.image = [UIImage imageNamed:lifeArr[i]];
                
                switch (i) {
                    case 0:
                        imgV.top = label1.top;
                        break;
                        
                    case 1:
                        imgV.top = label2.top;

                        break;
                        
                    case 2:
                        imgV.top = label3.top;

                        break;
                        
                    case 3:
                        imgV.top = label4.top;

                        break;
                        
                    case 4:
                        imgV.top = label5.top;

                        break;
                        
                    default:
                        break;
                }
                
                [cell addSubview:imgV];
                
                
            }
            cell.backgroundColor = [UIColor clearColor];
        }
            break;
            
        case 2:
        {
            remindLabel.text = @"pm2.5";
            cell.backgroundColor = [UIColor clearColor];
            
            //pm2.5
            UILabel *pm25Label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 20)];
            
            pm25Label.textColor = [UIColor whiteColor];
            pm25Label.text = [NSString stringWithFormat:@"PM2.5 = %@",_outModel.pm25.pm25.pm25];
            [cell addSubview:pm25Label];
            
            //空气质量
            UILabel *qulityLabel = [[UILabel alloc]initWithFrame:CGRectMake(pm25Label.right+10, _pm25Label.top, kScreenW-10-pm25Label.right, 20)];
            qulityLabel.textColor = [UIColor whiteColor];
            qulityLabel.text = _outModel.pm25.pm25.quality;
            [cell addSubview:qulityLabel];
            
            //建议
            UILabel *adviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, pm25Label.bottom+10, kScreenW - 40, 10)];
            
            adviceLabel.font = [UIFont systemFontOfSize:13];
            adviceLabel.textColor = [UIColor whiteColor];
            adviceLabel.numberOfLines = 0;
            adviceLabel.text = _outModel.pm25.pm25.des;
            [adviceLabel sizeToFit];
            [cell addSubview:adviceLabel];
            
            
            

        }
            break;
            
        case 3:
        {
            remindLabel.text = @"这里是广告  欢迎来用";
            cell.backgroundColor = [UIColor clearColor];
            
        }
            break;
            
        default:
            break;
    }
    [remindLabel sizeToFit];
    
    //分割线
    UIView *cutLine = [[UIView alloc]initWithFrame:CGRectMake(remindLabel.right, remindLabel.height/2, kScreenW-remindLabel.width, 1)];
    
    NSMutableArray *arrr = kMainColor;
    cutLine.backgroundColor=[UIColor colorWithRed:[arrr[0] floatValue] green:[arrr[1] floatValue] blue:[arrr[2] floatValue] alpha:1];
    
    [cell addSubview:cutLine];


    cutLine.left = remindLabel.right;
    cutLine.width = kScreenW - remindLabel.width;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


//返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 130;
    }
    else if(indexPath.row == 1){
        return 320;

    }
    else{
        return 100;
    }
    
}



//滑动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //滑动模糊效果
    if (scrollView.contentOffset.y > 10) {
        self.backgroundView.alpha = 0.3;
        _pageC.hidden = YES;
    }
    else{
        self.backgroundView.alpha = 1;
        _pageC.hidden = NO;

        
    }
    
}
@end
