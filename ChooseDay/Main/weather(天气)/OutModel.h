//
//  OutModel.h
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LifeModel.h"
#import "Pm25Model.h"
#import "RealtimeModel.h"

@interface OutModel : NSObject


@property(nonatomic,retain)LifeModel *life;


@property(nonatomic,retain)Pm25Model *pm25;
//
@property(nonatomic,retain)RealtimeModel *realtime;
//
//
@property(nonatomic,retain)NSArray *weather;



@end
