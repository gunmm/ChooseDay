//
//  GUNMMAFN.h
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^NetBlock)(id result);
typedef void (^ErrorBlock)(NSError *error);



@interface GUNMMAFN : NSObject




//获取GET请求
+ (void)getDataWithParameters:(NSDictionary *)paramets withUrl:(NSString *)urlstr withBlock:(NetBlock)block;
+ (void)getDataWithParameters:(NSDictionary *)paramets withUrl:(NSString *)urlstr withBlock:(NetBlock)block withFailedBlock:(ErrorBlock) errorBlock;



@end
