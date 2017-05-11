//
//  AboutViewController.h
//  ChooseDay
//
//  Created by Vivian on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CNLabel.h"

@interface AboutViewController : UITableViewController

@property (weak, nonatomic) IBOutlet CNLabel *emailAddress;

@property (weak, nonatomic) IBOutlet CNLabel *qqAddress;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;


@end
