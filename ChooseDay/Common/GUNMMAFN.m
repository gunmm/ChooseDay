

//
//  GUNMMAFN.m
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "GUNMMAFN.h"
#import "AFNetworking.h"


@implementation GUNMMAFN


//获取GET请求
+ (void)getDataWithParameters:(NSDictionary *)paramets withUrl:(NSString *)urlstr withBlock:(NetBlock)block{
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc]initWithSet:manger.responseSerializer.acceptableContentTypes];
    
    [contentTypes addObject:@"text/html"];
    
    manger.responseSerializer.acceptableContentTypes = contentTypes;
    
    [manger GET:urlstr parameters:paramets progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


+ (void)getDataWithParameters:(NSDictionary *)paramets withUrl:(NSString *)urlstr withBlock:(NetBlock)block withFailedBlock:(ErrorBlock) errorBlock{
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc]initWithSet:manger.responseSerializer.acceptableContentTypes];
    
    [contentTypes addObject:@"text/html"];
    
    manger.responseSerializer.acceptableContentTypes = contentTypes;
    
    [manger GET:urlstr parameters:paramets progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
    
}



@end
