//
//  RealtimeModel.h
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WindModel.h"
#import "ReWeatherModel.h"

@interface RealtimeModel : NSObject

@property(nonatomic,retain)WindModel *wind;


@property(nonatomic,retain)ReWeatherModel *weather;

@property(nonatomic,copy)NSString *city_name;

@property(nonatomic,copy)NSString *moon;

@property(nonatomic,copy)NSString *dataUptime;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *week;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *city_code;






@end
