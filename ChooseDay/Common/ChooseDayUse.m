//
//  ChooseDayUse.m
//  ChooseDay
//
//  Created by 闵哲 on 2016/12/15.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "ChooseDayUse.h"

@implementation ChooseDayUse


+ (NSString *)getGoogleIconWithIconHexString:(NSString *)iconStr
{
    NSString *unicodeStr = [NSString stringWithFormat:@"\\u%@", iconStr];
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}




//设置google字体图标
+ (void)showGoogleIconForView:(UIView *)view iconName:(NSString *)iconName color:(UIColor *)iconColor font:(CGFloat)iconFont suffix:(NSString *)suffix{
    if([view isKindOfClass:[UIButton class]]){
        
        if(suffix){
            [(UIButton *)view setTitle:[NSString stringWithFormat:@"%@%@",iconName,suffix] forState:UIControlStateNormal];
        }else{
            [(UIButton *)view setTitle:iconName forState:UIControlStateNormal];
        }
        [((UIButton *)view).titleLabel setFont:[UIFont fontWithName:@"MaterialIcons-Regular" size:iconFont]];
        [(UIButton *)view setTitleColor:iconColor forState:UIControlStateNormal];
        
    }else if([view isKindOfClass:[UILabel class]]){
        
        if(suffix){
            [(UILabel *)view setText:[NSString stringWithFormat:@"%@%@",iconName,suffix]];
        }else{
            [(UILabel *)view setText:[NSString stringWithFormat:@"%@",iconName]];
        }
        [(UILabel *)view setFont:[UIFont fontWithName:@"Material Icons" size:iconFont]];
        [(UILabel *)view setTextColor:iconColor];
        
    }
}



@end
