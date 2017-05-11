//
//  GtasksData.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/30.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "GtasksData.h"

@implementation GtasksData

/**
 *获得指定是日期的待办事项
 */
- (NSArray *)getOneDayWillArray:(NSString *)dateStr{


    //1.获取文件路径
    NSString *jsonPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/gtasks.json"];
    
    //2.获取文件中内容
    NSData *jsondata = [NSData dataWithContentsOfFile:jsonPath];
    
    
    
    //3.解析json数据
    NSMutableDictionary * gtasksAllDayDic = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:nil];
    
    
    NSMutableDictionary *  gtasksOneDayDic =[gtasksAllDayDic objectForKey:dateStr];
    
     NSMutableArray * gtasksOneDayWillArray=[gtasksOneDayDic objectForKey:@"Will"];
    
    
//     NSMutableArray * gtasksOneDayFinishArray=[gtasksOneDayDic  objectForKey:@"Finish"];


    return gtasksOneDayWillArray;


}

/**
 *获得指定是日期的完成事项
 */
- (NSArray *)getOneDayFinishArray:(NSString *)dateStr{

    //1.获取文件路径
    NSString *jsonPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/gtasks.json"];
    
    //2.获取文件中内容
    NSData *jsondata = [NSData dataWithContentsOfFile:jsonPath];
    
    
    
    //3.解析json数据
    NSMutableDictionary * gtasksAllDayDic = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:nil];
    
    
    NSMutableDictionary *  gtasksOneDayDic =[gtasksAllDayDic objectForKey:dateStr];
    
//    NSMutableArray * gtasksOneDayWillArray=[gtasksOneDayDic objectForKey:@"Will"];
    
    
    NSMutableArray * gtasksOneDayFinishArray=[gtasksOneDayDic  objectForKey:@"Finish"];

    return gtasksOneDayFinishArray;

}

/**
 *插入指定是日期的待办事项
 */
- (void)insertOneDayWillArray:(NSString *)dateStr content:(NSString *)text{


    
    
    
            //1.获取文件路径
            NSString *jsonPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/gtasks.json"];
    
            //2.获取文件中内容
            NSData *jsondata = [NSData dataWithContentsOfFile:jsonPath];
    
            //3.解析json数据
//            if ([_gtasksAllDayDic objectForKey:dateStr]) {
    
    
    
                _gtasksAllDayDic=(NSMutableDictionary*)[NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:nil];
    
    
                NSMutableDictionary *allDaydic=[[NSMutableDictionary alloc]initWithDictionary:_gtasksAllDayDic];
    
                _gtasksOneDayDic=[_gtasksAllDayDic objectForKey:dateStr];
    
                NSMutableDictionary *oneDaydic=[[NSMutableDictionary alloc]initWithDictionary:_gtasksOneDayDic];
    
                _gtasksOneDayWillArray=[_gtasksOneDayDic  objectForKey:@"Will"];
    
    
                NSMutableArray *oneDayWillArray=[[NSMutableArray alloc]initWithArray:_gtasksOneDayWillArray];
                [oneDayWillArray addObject:text];
    
                [oneDaydic removeObjectForKey:@"Will"];
    
                [oneDaydic setObject:oneDayWillArray forKey:@"Will"];
    
    
                [allDaydic removeObjectForKey:dateStr];
    
                [allDaydic setObject:oneDaydic forKey:dateStr];
    
    
    
                //3.将数据装化为json规格的data数据
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:allDaydic options:NSJSONWritingPrettyPrinted error:nil];
    
                //4.将json数据写入到文件中
                //如果文件不存在 则自动创建新的文件
                BOOL result = [jsonData writeToFile:jsonPath atomically:YES];
    
                if (result) {
                    NSLog(@"插入成功");
    
    
                }
                else
                {
                    NSLog(@"插入失败");
                }
    
    
    
    


}


/**
 *删除指定是日期的待办事项   加入到完成事项
 */
- (void)deleteOneDayWillArray:(NSString *)dateStr  index:(NSInteger)number{


    //1.获取文件路径
    NSString *jsonPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/gtasks.json"];
    
    //2.获取文件中内容
    NSData *jsondata = [NSData dataWithContentsOfFile:jsonPath];
    
    
    _gtasksAllDayDic=(NSMutableDictionary*)[NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:nil];
    
    
    NSMutableDictionary *allDaydic=[[NSMutableDictionary alloc]initWithDictionary:_gtasksAllDayDic];
    
    _gtasksOneDayDic=[_gtasksAllDayDic objectForKey:dateStr];
    
    NSMutableDictionary *oneDaydic=[[NSMutableDictionary alloc]initWithDictionary:_gtasksOneDayDic];
    
    _gtasksOneDayWillArray=[_gtasksOneDayDic  objectForKey:@"Will"];
    
    _gtasksOneDayFinishArray=[_gtasksOneDayDic objectForKey:@"Finish"];
    
    NSMutableArray *oneDayWillArray=[[NSMutableArray alloc]initWithArray:_gtasksOneDayWillArray];
    
    NSMutableArray *oneDayFinishArray=[[NSMutableArray alloc]initWithArray:_gtasksOneDayFinishArray];
    
    
    [oneDayFinishArray addObject:oneDayWillArray[number]];
    
    [oneDayWillArray removeObjectAtIndex:number];
    
    
    
    [oneDaydic removeObjectForKey:@"Will"];
    
    [oneDaydic setObject:oneDayWillArray forKey:@"Will"];
    
    [oneDaydic removeObjectForKey:@"Finish"];
    
    [oneDaydic setObject:oneDayFinishArray forKey:@"Finish"];
    
    
    
    [allDaydic removeObjectForKey:dateStr];
    
    [allDaydic setObject:oneDaydic forKey:dateStr];
    
    
    
    //3.将数据装化为json规格的data数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:allDaydic options:NSJSONWritingPrettyPrinted error:nil];
    
    //4.将json数据写入到文件中
    //如果文件不存在 则自动创建新的文件
    BOOL result = [jsonData writeToFile:jsonPath atomically:YES];
    
    if (result) {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
    

}


/**
 *删除指定是日期的完成事项
 */
- (void)deleteOneDayFinishArray:(NSString *)dateStr index:(NSInteger)number{
    
    //1.获取文件路径
    NSString *jsonPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/gtasks.json"];
    
    //2.获取文件中内容
    NSData *jsondata = [NSData dataWithContentsOfFile:jsonPath];
    
    
    _gtasksAllDayDic=(NSMutableDictionary*)[NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:nil];
    
    
    NSMutableDictionary *allDaydic=[[NSMutableDictionary alloc]initWithDictionary:_gtasksAllDayDic];
    
    _gtasksOneDayDic=[_gtasksAllDayDic objectForKey:dateStr];
    
    NSMutableDictionary *oneDaydic=[[NSMutableDictionary alloc]initWithDictionary:_gtasksOneDayDic];
    
    _gtasksOneDayWillArray=[_gtasksOneDayDic  objectForKey:@"Will"];
    
    _gtasksOneDayFinishArray=[_gtasksOneDayDic  objectForKey:@"Finish"];
    
    NSMutableArray *oneDayWillArray=[[NSMutableArray alloc]initWithArray:_gtasksOneDayWillArray];
    
    NSMutableArray *oneDayFinishArray=[[NSMutableArray alloc]initWithArray:_gtasksOneDayFinishArray];
    
    
    
    
    
    [oneDayFinishArray removeObjectAtIndex:number];
    
    
    
    [oneDaydic removeObjectForKey:@"Will"];
    
    [oneDaydic setObject:oneDayWillArray forKey:@"Will"];
    
    [oneDaydic removeObjectForKey:@"Finish"];
    
    [oneDaydic setObject:oneDayFinishArray forKey:@"Finish"];
    
    
    
    [allDaydic removeObjectForKey:dateStr];
    
    [allDaydic setObject:oneDaydic forKey:dateStr];
    
    
    
    //3.将数据装化为json规格的data数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:allDaydic options:NSJSONWritingPrettyPrinted error:nil];
    
    //4.将json数据写入到文件中
    //如果文件不存在 则自动创建新的文件
    BOOL result = [jsonData writeToFile:jsonPath atomically:YES];
    
    if (result) {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
    
    
}

@end
