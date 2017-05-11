//
//  OutCollectionView.m
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "OutCollectionView.h"
#import "OutCollectionViewCell.h"


static NSString *identifier = @"outCell";

@implementation OutCollectionView



//重写init方法
- (instancetype)initWithFrame:(CGRect)frame{
    
    
    //1.创建布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置单元格大小
    layout.itemSize = CGSizeMake(kScreenW, kScreenH-64-49);

    
    //设置单元格之间的间隙
    layout.minimumLineSpacing = 0;
    
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        //设置代理
        self.delegate = self;
        
        self.dataSource = self;
        
        //注册单元格
        [self registerClass:[OutCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
        //分页效果
        self.pagingEnabled = YES;
        
        //添加分页控制器
//        [self addPageControl];
        
    }
    return self;
}




#pragma mark--------CollectionView代理方法
//返回单元格个数 (kScreenW-80, 30, 70, 70)];
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataList.count;
}


//返回单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor redColor];
    
    cell.pageC = _pageC;

    cell.outModel = _dataList[indexPath.row];
    

    return cell;
}


//结束滑动
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    _pageC.currentPage = targetContentOffset->x/kScreenW;
}

//视图将要消失时
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //设置滑动离开当前页面后  表视图偏移量为0
    OutCollectionViewCell *celll = (OutCollectionViewCell *)cell;
    
    celll.midTableView.contentOffset = CGPointMake(0, 0);
}


- (void)reloadData{
    [super reloadData];
    
    if (_dataList.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataList.count-1 inSection:0];
        
//        _pageC.currentPage = _dataList.count - 1;
        
//        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    
}
    
    
    
    
    
    
    
@end
