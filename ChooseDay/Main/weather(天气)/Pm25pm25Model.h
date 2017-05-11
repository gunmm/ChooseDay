//
//  Pm25pm25Model.h
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pm25pm25Model : NSObject


@property(nonatomic,copy)NSString *curPm;

@property(nonatomic,copy)NSString *des;

@property(nonatomic,retain)NSNumber *level;

@property(nonatomic,copy)NSString *pm10;

@property(nonatomic,copy)NSString *pm25;

@property(nonatomic,copy)NSString *quality;


@end
