//
//  GtasksData.h
//  ChooseDay
//
//  Created by Rockeen on 16/1/30.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GtasksData : NSObject


@property (nonatomic, strong) NSMutableDictionary *gtasksAllDayDic;
@property (nonatomic, strong) NSMutableDictionary *gtasksOneDayDic;


@property (nonatomic, strong) NSMutableArray *gtasksOneDayWillArray;
@property (nonatomic, strong) NSMutableArray *gtasksOneDayFinishArray;


/**
 *获得指定是日期的待办事项
 */
- (NSArray *)getOneDayWillArray:(NSString *)dateStr;

/**
 *获得指定是日期的完成事项
 */
- (NSArray *)getOneDayFinishArray:(NSString *)dateStr;

/**
 *插入指定是日期的待办事项
 */
- (void)insertOneDayWillArray:(NSString *)dateStr content:(NSString *)text;

/**
 *插入指定是日期的完成事项
 */
- (void)insertOneDayFinishArray:(NSString *)dateStr  content:(NSString *)text;

/**
 *删除指定是日期的待办事项
 */
- (void)deleteOneDayWillArray:(NSString *)dateStr  index:(NSInteger)number;

/**
 *删除指定是日期的完成事项
 */
- (void)deleteOneDayFinishArray:(NSString *)dateStr index:(NSInteger)number;

@end
