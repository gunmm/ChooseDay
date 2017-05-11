//
//  ZXYGtasksViewController.h
//  ChooseDay
//
//  Created by Rockeen on 16/1/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYTextView.h"

@interface ZXYGtasksViewController : UIViewController

@property (nonatomic, strong) ZXYTextView *zxyTextView;


//@property (nonatomic, strong) NSMutableArray *gtasksAllDayArray;

@property (nonatomic, strong) NSMutableDictionary *gtasksAllDayDic;

@property (nonatomic, strong) NSMutableArray *gtasksOneDayWillArray;

@property (nonatomic, strong) NSMutableArray *gtasksOneDayFinishArray;

@property (nonatomic, strong) NSMutableDictionary *gtasksOneDayDic;





@property (nonatomic, copy) NSString *dataStr;

@end