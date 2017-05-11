//
//  LifeModel.h
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LifeInfoModel.h"

@interface LifeModel : NSObject

@property(nonatomic,copy)NSString *date;

@property(nonatomic,retain)LifeInfoModel *info;

@end
