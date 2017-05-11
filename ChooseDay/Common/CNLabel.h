//
//  CNLabel.h
//  项目二
//
//  Created by Vivian on 16/1/5.
//  Copyright © 2016年 Vivian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNTextView : UITextView

@end

@interface CNLabel : UIView<UITextViewDelegate>

{

    CNTextView *_textView;

}

@property (nonatomic,copy)NSString *text;

@property (nonatomic,retain)NSDictionary *textAttributes;

@end

@interface CNTextAttachment : NSTextAttachment

@end

