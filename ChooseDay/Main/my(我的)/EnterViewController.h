//
//  EnterViewController.h
//  ChooseDay
//
//  Created by Vivian on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^MyBlock) (id result);

@interface EnterViewController : UIViewController

//@property (nonatomic,copy)MyBlock block;



@property (nonatomic, strong) NSUserDefaults *userDefault;


//复写init方法
//-(instancetype)initWithBlock:(MyBlock)block;

@end
