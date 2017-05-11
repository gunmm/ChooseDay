//
//  AppDelegate.h
//  ChooseDay
//
//  Created by Rockeen on 16/1/16.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;
//加载视图
-(void)loadViewController;

//第三方应用授权
-(void)oauthFunc;

//加载视图
-(void)loadNewView;

@end

