//
//  InCollectionView.m
//  ChooseDay
//
//  Created by 闵哲 on 16/1/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "InCollectionView.h"
#import "InCollectionViewCell.h"

static NSString *identifier = @"inCell";

@implementation InCollectionView


- (instancetype)initWithFrame:(CGRect)frame{
    
    //1.创建布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置单元格大小
    layout.itemSize = CGSizeMake(kScreenW/4, 130);
    
    
    //设置单元格之间的间隙
    layout.minimumLineSpacing = 0;

    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        //设置代理
        self.delegate = self;
        
        self.dataSource = self;
        
        //注册单元格
        [self registerClass:[InCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
        //分页效果
        self.pagingEnabled = YES;

        
        
        
    }
    
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    
    [self reloadData];
}


//返回单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataList.count;
}


//返回单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    InCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    cell.model = _dataList[indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    
    
    
}


@end
