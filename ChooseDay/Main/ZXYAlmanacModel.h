//
//  ZXYAlmanacModel.h
//  ChooseDay
//
//  Created by Rockeen on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 error_code	INT	返回码
 reason	STRING	返回说明
 yangli	DATE	阳历
 yinli	STRING	阴历
 wuxing	STRING	五行
 chongsha	STRING	冲煞
 baiji	STRING	彭祖百忌
 jishen	STRING	吉神宜趋
 yi	STRING	宜
 xiongshen	STRING	凶神宜忌
 ji	STRING	忌
 
 */

@interface ZXYAlmanacModel : NSObject


@property (nonatomic, strong) NSString *yinli;
@property (nonatomic, strong) NSString* yangli;
@property (nonatomic, strong) NSString *wuxing;
@property (nonatomic, strong) NSString *chongsha;
@property (nonatomic, strong) NSString *baiji;
@property (nonatomic, strong) NSString *jishen;
@property (nonatomic, strong) NSString *yi;
@property (nonatomic, strong) NSString *ji;

@end
