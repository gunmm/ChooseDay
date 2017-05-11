//
//  MidTableView.h
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutModel.h"

@interface MidTableView : UITableView<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,retain)OutModel *outModel;

@property(nonatomic,retain)UIPageControl *pageC;


@end
