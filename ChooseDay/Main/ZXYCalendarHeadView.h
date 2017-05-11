//
//  ZXYCalendarHeadView.h
//  ChooseDay
//
//  Created by Rockeen on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlmanacView.h"
typedef void (^DataStr)(NSString *dataS);


@interface ZXYCalendarHeadView : UIView

@property (nonatomic, strong)AlmanacView * almanacView;


- (void)returnDataStr:(DataStr)dataS;

@end
