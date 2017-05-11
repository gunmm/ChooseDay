//
//  CellView.h
//  ChooseDay
//
//  Created by 闵哲 on 16/2/27.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstellationModel.h"

@interface CellView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



@property(nonatomic,retain)ConstellationModel *model;


@property(nonatomic,copy)NSString *constellationData;

@property(nonatomic,retain)UIImage *image;

@end
