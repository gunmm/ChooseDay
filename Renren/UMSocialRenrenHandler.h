//
//  UMSocialRenrenHandler.h
//  SocialSDK
//
//  Created by yeahugo on 14-6-5.
//  Copyright (c) 2014年 Umeng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  负责人人网SSO
 
 */
@interface UMSocialRenrenHandler : NSObject

/**
 设置人人网AppId，apiKey，secreteKey等用于SSO授权
 
 @param app_Id 
 @param apiKey
 @param secretKey 
 */
+(void)openSSO;
@end
