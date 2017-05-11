//
//  Pm25Model.h
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pm25pm25Model.h"

@interface Pm25Model : NSObject

@property(nonatomic,copy)NSString *cityName;

@property(nonatomic,copy)NSString *dateTime;

//@property(nonatomic,copy)NSString *


@property(nonatomic,retain)Pm25pm25Model *pm25;

@property(nonatomic,retain)NSNumber *show_desc;

@end
