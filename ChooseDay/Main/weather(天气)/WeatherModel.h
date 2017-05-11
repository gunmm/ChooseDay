//
//  WeatherModel.h
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeaInfoModel.h"

@interface WeatherModel : NSObject

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *nongli;

@property(nonatomic,copy)NSString *week;

@property(nonatomic,retain)WeaInfoModel *info;




@end
