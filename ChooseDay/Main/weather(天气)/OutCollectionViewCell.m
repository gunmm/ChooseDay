//
//  OutCollectionViewCell.m
//  ChooseDay
//
//  Created by 闵哲 on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "OutCollectionViewCell.h"

@implementation OutCollectionViewCell{
    
}


- (void)awakeFromNib{
    
    
    
    
    
}



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _midTableView = [[MidTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-49)];
        
        [self addSubview:_midTableView];
        
    }
    return self;
}




- (void)setOutModel:(OutModel *)outModel{
    _outModel = outModel;
    
    _midTableView.outModel = _outModel;
    
    _midTableView.pageC = _pageC;
    
    
    
    [_midTableView reloadData];


}






@end
