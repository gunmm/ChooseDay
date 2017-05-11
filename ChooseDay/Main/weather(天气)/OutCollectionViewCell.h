//
//  OutCollectionViewCell.h
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutModel.h"
#import "MidTableView.h"


@interface OutCollectionViewCell : UICollectionViewCell


@property(nonatomic,retain)OutModel *outModel;

@property(nonatomic,retain)UIPageControl *pageC;

@property(nonatomic,retain)MidTableView *midTableView;




@end
