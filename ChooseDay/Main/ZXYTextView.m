//
//  ZXYTextView.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "ZXYTextView.h"

@implementation ZXYTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
//        self.backgroundColor=[UIColor yellowColor];
        
        self.layer.cornerRadius=5;
        
        self.layer.masksToBounds=YES;
        
        self.layer.borderWidth=2;
        
        UIColor *color = kBgColor;
        self.layer.borderColor= color.CGColor;//背景颜色

        
        
        _lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenW, 20)];
        _lable.text=@"  填写待办事项（回车保存）...";
        _lable.textColor=[UIColor grayColor];
        [self addSubview:_lable];
        self.textColor=[UIColor blackColor];
        
        self.font=[UIFont systemFontOfSize:17];
        
     
        [[NSNotificationCenter defaultCenter]addObserverForName:UITextViewTextDidChangeNotification object:self queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            
            if (self.text.length) {
                _lable.hidden=YES;
            }else{
                
                _lable.hidden=NO;
                
            }
            
            
            [self sizeToFit];
            
            self.width=kScreenW-20;
            
            

            
            
            
            if (_textViewHeight!=self.height) {
                
                _textViewHeight=  self.height;
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"heightChange" object:nil];
            }
            
            
        }];



        
    }
    return self;
}

@end
