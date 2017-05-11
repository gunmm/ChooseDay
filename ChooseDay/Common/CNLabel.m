//
//  CNLabel.m
//  项目二
//
//  Created by Vivian on 16/1/5.
//  Copyright © 2016年 Vivian. All rights reserved.
//

#import "CNLabel.h"

@implementation CNLabel
{

    NSMutableDictionary *_iconDic;
}

-(void)awakeFromNib{
    
    //初始化textView
    [self createTextView];
    
    //清空背景颜色
    self.backgroundColor = [UIColor clearColor];
    
    //解析plist文件，包含中文字符对应的图片
    [self loadIconDic];

}

//入口方法
-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        //初始化textView
        [self createTextView];
        
        //清空背景颜色
        self.backgroundColor = [UIColor clearColor];
        
        //解析plist文件，包含中文字符对应的图片
        [self loadIconDic];
        
    }

    return self;

}

//解析中文字符对应的图片数据
-(void)loadIconDic{

    //获取文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"emoticons" ofType:@"plist"];
    
    //解析该文件
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    
    //初始化字典
    _iconDic = [NSMutableDictionary dictionary];
    
    //遍历数组
    for (NSDictionary *dic in arr) {
    
        //拿出代表图片的字符串 [**]
        NSString *imgNameKey =[dic objectForKey:@"chs"];
        
        //拿出图片
        NSString *imgNameValue = [dic objectForKey:@"png"];
        
        //把对应的图片与名字作为键值对存放到新的字典中
        [_iconDic setValue:imgNameValue forKey:imgNameKey];
    
    }

}

//创建textView---显示不开了可以滚动
-(void)createTextView{

    //初始化frame
    _textView = [[CNTextView alloc]initWithFrame:self.bounds];
    
    //滚动模式
    _textView.scrollEnabled = NO;
    
    //编辑
    _textView.editable = NO;
    
    //设置代理
    _textView.delegate = self;
    
    _textView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_textView];

}

//复写set方法
-(void)setText:(NSString *)text{

    //使用copy就可以将text里的所有内容都传过来
    _text = [text copy];
    
    //实现文本高度的计算
    [self loadAttributedString];
    
}

//实现文本高度的计算
-(void)loadAttributedString{

    //将普通文本字符串转换为带有富文本属性的字符串
    NSMutableAttributedString *att;
    
    if (self.textAttributes) {
        
        //如果在外部设置了文本的其他属性则使用方法初始化
        att = [[NSMutableAttributedString alloc]initWithString:_text attributes:_textAttributes];
        
    }else {
    
        att = [[NSMutableAttributedString alloc]initWithString:_text];
    
    }
    
    //进行图文混排
    [self praseString:att];
    
    //超链接
    [self praseLink:att];
    
    //计算文本高度
    [self height:att];
    
    //给textView设置富文本字符串
    _textView.attributedText = att;
    
    //设置当前CNLabel的高度==textView的高度
    self.height = _textView.height;

}

//实现图文混排
-(void)praseString:(NSMutableAttributedString *)att{
    
    //1.查找符合要求的字符串，并且获取到range范围
    //正则表达式[**]至少一个，最多5个
    NSArray *ranges = [self rangeOgString:@"\\[\\w{1,5}\\]"];

    //倒序遍历数组并且替换字符串
    for (int i = (int)ranges.count-1; i>=0; i--) {
        
        //把NSValve转换为NSRange
        //获取到range范围---将要替换的字符串的范围
        NSRange range = [ranges[i] rangeValue];
        
        //铜鼓range截取字符串范围
        NSString *subStr = [_text substringWithRange:range];
        
        //通过截取的字符串去替换图片
        //获取图片名字
        NSString *imgName = [_iconDic objectForKey:subStr];
        
        //NSTextAttachment:这时一个文本，但是可以存放一个图片属性
        CNTextAttachment *attachment = [[CNTextAttachment alloc]init];
        
        //设置image属性
        attachment.image = [UIImage imageNamed:imgName];
        
        //可以设置图像文本大小
//        attachment.bounds
        
        //删除原有的字符串
        if (imgName) {
            
            [att deleteCharactersInRange:range];
            
        }
        
        //将带有图片属性的attachment对象转换为NSAttributedString
        NSAttributedString *insertStr = [NSAttributedString attributedStringWithAttachment:attachment];
        
        //在删除原有字符串的location位置插入新的图片文本对象
        [att insertAttributedString:insertStr atIndex:range.location];
        
    }
    
}

//超链接字符
-(void)praseLink:(NSMutableAttributedString *)att{
    
//---------正则表达式-------------

    //http地址链接  字符串
    //？表示判断是否显示前面的字符；.表示所有的标点符号但是不包括_-这两个，所以要在后面加上这两个符号；*表示包含任意字符；+表示至少前面的字符有一个
    NSString *linkStr = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    
    //@用户  字符串
    //\w表示任意字符；\\w表示匹配\w
    NSString *userStr = @"@[\\w]+";
    
    //话题  字符串
    NSString *topicStr = @"#[\\w]+#";
    
    //存入数组
    NSArray *arr = @[linkStr,userStr,topicStr];
    
    //遍历数组
    for (NSString *str in arr) {
    
        //将字符串初始化为正则对象
        NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:str options:NSRegularExpressionCaseInsensitive error:nil];
        
        //匹配字符串对象
        NSArray *results = [regular matchesInString:att.string options:NSMatchingReportProgress range:NSMakeRange(0, att.length)];
    
        //遍历匹配结果，获取range并放入新的数组里
        for (NSTextCheckingResult *result in results) {
        
            //获取range
            NSRange range = result.range;
            
            //通过range获取适配的字符串
            NSString *str = [att.string substringWithRange:range];
            
            //转化字符串为超链接样式
            NSString *linkstr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            //在富文本字符串中将适配的字符转化为可链接属性
            [att addAttribute:NSLinkAttributeName value:linkstr range:range];
        
        }
        
    }

}

//查找符合要求的字符串，并且返回一组range范围
-(NSArray *)rangeOgString:(NSString *)str{

    //1.将传入的字符串初始化为正则表达式对象
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:str options:NSRegularExpressionCaseInsensitive error:nil];
    
    //通过正则表达式到字符串中匹配正确对象
    //匹配全部文本
    NSArray *results = [regular matchesInString:self.text options:NSMatchingReportProgress range:NSMakeRange(0, self.text.length)];
    
    NSMutableArray *ranges = [NSMutableArray array];
    
    //遍历匹配结果，获取range并放入新的数组
    for (NSTextCheckingResult *result in results) {
    
        //获取到匹配字符串的range范围
        NSRange range = result.range;
    
        //range结构体转换为OC对象---放入数组中
        NSValue *value = [NSValue valueWithRange:range];
        
        //添加到数组中
        [ranges addObject:value];
        
    }
    
    return ranges;

}

//计算高度
-(void)height:(NSMutableAttributedString *)att{

    CGRect frame = [att boundingRectWithSize:CGSizeMake(_textView.frame.size.width-20, 9999.f) options:NSStringDrawingUsesLineFragmentOrigin context:nil];

    CGRect textFrame = _textView.frame;
    
    //更改高度
    textFrame.size.height = frame.size.height+20;
    
    _textView.frame = textFrame;
    
}


#pragma mark-----
//textView的代理方法，点击超链接执行
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{

    //点击超链接时执行
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    return YES;

}

@end

@implementation CNTextAttachment

//修改图像文本的大小
-(CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{

    return CGRectMake(0, 0, lineFrag.size.height, lineFrag.size.height);

}

@end

@implementation CNTextView
 
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.nextResponder touchesBegan:touches withEvent:event];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.nextResponder touchesEnded:touches withEvent:event];
    
}

@end
