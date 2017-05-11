//
//  InCollectionView.h
//  ChooseDay
//
//  Created by 闵哲 on 16/1/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InCollectionView : UICollectionView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>


@property(nonatomic,retain)NSArray *dataList;

@end
