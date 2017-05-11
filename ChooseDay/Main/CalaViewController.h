//
//  CalendarViewController.h
//  ChooseDay
//
//  Created by Rockeen on 16/1/16.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYCalendarHeadView.h"

@interface CalaViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSMutableDictionary *gtasksAllDayDic;

@property (nonatomic, strong) NSMutableArray *gtasksOneDayWillArray;

@property (nonatomic, strong) NSMutableArray *gtasksOneDayFinishArray;

@property (nonatomic, strong) NSMutableDictionary *gtasksOneDayDic;


@property (nonatomic, strong)     ZXYCalendarHeadView *headView;

@end
