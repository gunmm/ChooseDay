//
//  MDPickerView.m
//  ChooseDay
//
//  Created by Vivian on 16/2/20.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "MDPickerView.h"

@interface MDPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UIToolbar *toolbar;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,assign)BOOL isHaveNavControler;
@property(nonatomic,assign)NSInteger pickeviewHeight;
//@property(nonatomic,copy)NSString *resultString;

@end

@implementation MDPickerView

-(instancetype)initWithFrame:(CGRect)frame WithDataList:(NSArray *)dataList{

    self = [super initWithFrame:frame];
    
    if (self) {
        
//        self.backgroundColor = [UIColor blueColor];
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, self.height-40)];
        
//        _pickerView.backgroundColor = [UIColor redColor];
        
        _dataList = dataList;
        
        _pickerView.delegate = self;
        
        _pickerView.dataSource = self;
        
        [self addSubview:_pickerView];
        
        [self setUpToolBar];
        
    }
    
    return self;

}

-(void)setUpToolBar{

    _toolbar = [self setToolbarStyle];
    
    [self setToolbarWithPickViewFrame];
    
    [self addSubview:_toolbar];

}

-(UIToolbar *)setToolbarStyle{

    UIToolbar *toolBar = [[UIToolbar alloc]init];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"  取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    
    leftItem.tintColor = [UIColor grayColor];
    
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"确定  " style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    
    rightItem.tintColor = [UIColor grayColor];
    
    toolBar.items = @[leftItem,centerSpace,rightItem];

    return toolBar;
    
}

#pragma mark - 取消、确定视图的背景、尺寸大小
-(void)setToolbarWithPickViewFrame{

    _toolbar.frame = CGRectMake(0, 0, kScreenW, 40);
    
    _toolbar.backgroundColor = [UIColor grayColor];

}

-(void)setFrameWith:(BOOL)isHaveNavControler{
    
    CGFloat toolViewX = 0;
    
    CGFloat toolViewH = _pickeviewHeight+40;
    
    CGFloat toolViewY ;
    
    if (isHaveNavControler) {
        
        toolViewY= kScreenH-toolViewH-50;
    
    }else {
    
        toolViewY= kScreenH-toolViewH;
    
    }
    
    CGFloat toolViewW = kScreenW;
    
    self.frame = CGRectMake(toolViewX, toolViewY, toolViewW, toolViewH);

}

#pragma mark pickerView 数据源方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return _dataList.count;

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (row < _dataList.count) {
        
//        _resultString = @"";
//        
//        _resultString = _dataList[row];
        
        return _dataList[row];
        
    }
    
    return nil;
    
}

-(void)remove{

    [self removeFromSuperview];

}

-(void)show{

    [[UIApplication sharedApplication].keyWindow addSubview:self];

}

-(void)doneClick{
    
    if (_pickerView) {
        
        NSInteger row = [_pickerView selectedRowInComponent:0];
        
        NSString *resultS = _dataList[row];
//
        if (resultS) {
            
            if ([self.delegate respondsToSelector:@selector(tooBarDonBtnHaveClick:resultString:)]) {
                
                [self.delegate tooBarDonBtnHaveClick:self resultString:resultS];
                
            }
            
        }
        
    }
    
    [self removeFromSuperview];

}

@end
