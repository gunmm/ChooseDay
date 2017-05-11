//
//  AlmanacView.h
//  ChooseDay
//
//  Created by Rockeen on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXYAlmanacModel.h"

@interface AlmanacView : UIView



@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UILabel *yinliLable;

@property (weak, nonatomic) IBOutlet UILabel *wuxingLable;

@property (weak, nonatomic) IBOutlet UILabel *yiLable;

@property (weak, nonatomic) IBOutlet UILabel *jiLable;

@property (nonatomic, strong) ZXYAlmanacModel *almanacModel;

@end
