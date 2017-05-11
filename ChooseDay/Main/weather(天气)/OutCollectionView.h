//
//  OutCollectionView.h
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutCollectionView : UICollectionView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic,retain)NSMutableArray *dataList;


@property(nonatomic,retain)UIPageControl *pageC;

@end
