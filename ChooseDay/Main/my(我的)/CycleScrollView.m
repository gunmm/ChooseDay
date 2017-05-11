//
//  Created by 51 on 16/2/17.
//  Copyright © 2016年 Caoyq. All rights reserved.

#import "CycleScrollView.h"
#import "UIImageView+WebCache.h"

@interface CycleScrollView ()<UIScrollViewDelegate,UIPageViewControllerDelegate>
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIPageControl *page;
@property (assign, nonatomic) CGRect mainRect;/**< 当前视图尺寸 */
@property (assign, nonatomic) NSInteger imgCount;/**< 图片个数 */
@property (assign, nonatomic) BOOL hasUrlImg;/**< 图片数组是否是以url形式存储 */
@end

@implementation CycleScrollView

- (void)drawRect:(CGRect)rect {
    _mainRect = rect;
    if (_imgArray) {
        _imgCount = _imgArray.count;
        _hasUrlImg = NO;
    }else if (_urlArray){
        _imgCount = _urlArray.count;
        _hasUrlImg = YES;
    }
    [self setScrollView];
    [self setPageController];
    [self setImageView];
    [self setAutoCycleScroll];
}
- (void)setScrollView {
    _mainScrollView = [[UIScrollView alloc]initWithFrame:_mainRect];
    [self addSubview:_mainScrollView];
    _mainScrollView.delegate = self;
    _mainScrollView.pagingEnabled = !_pageHidden;
    _mainScrollView.contentSize = CGSizeMake(_mainRect.size.width * (_imgCount+2), 0);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.contentOffset = CGPointMake(_mainRect.size.width, 0);
}

- (void)setPageController {
    _page = [[UIPageControl alloc]init];
    _page.frame = CGRectMake(0, _mainRect.size.height - 20, _mainRect.size.width, 20);
    [self addSubview:_page];
    _page.numberOfPages = _imgCount;
    _page.currentPage = 0;
    _page.defersCurrentPageDisplay = YES;
    _page.currentPageIndicatorTintColor = _pageControlCurrentPageIndicatorTintColor;
    _page.pageIndicatorTintColor = _PageControlPageIndicatorTintColor;
}

- (void)setImageView {
    for (int i = 0; i < _imgCount+2; i++) {
        UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(i*_mainRect.size.width, 0, _mainRect.size.width, _mainRect.size.height)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(-1, -1, _mainRect.size.width+2, _mainRect.size.height+2)];
        if (i == 0) {
            if (_hasUrlImg) {
                [imageView setImageWithURL:_urlArray[_imgCount-1]];
            }else{
                imageView.image = [UIImage imageNamed:_imgArray[_imgCount-1]];
            }
            imageView.tag = _imgCount-1;
        }else if (i == _imgCount+1){
            if (_hasUrlImg) {
                [imageView setImageWithURL:_urlArray[0]];
            }else{
                imageView.image = [UIImage imageNamed:_imgArray[0]];
            }
            imageView.tag = 0;
        }else{
            if (_hasUrlImg) {
                [imageView setImageWithURL:_urlArray[i-1]];
            }else{
                imageView.image = [UIImage imageNamed:_imgArray[i-1]];
            }
            imageView.tag = i-1;
        }
        [sv addSubview:imageView];
        [_mainScrollView addSubview:sv];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgClicked:)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
}

- (void)setAutoCycleScroll {
    if (_autoScroll) {
        if (!_autoTime) {
            _autoTime = 2.0f;
        }
        NSTimer *myTimer = [NSTimer timerWithTimeInterval:_autoTime target:self selector:@selector(runTimePage)userInfo:nil repeats:YES];
        [[NSRunLoop  currentRunLoop] addTimer:myTimer forMode:NSDefaultRunLoopMode];
    }
}
#pragma mark - 定时器
- (void)runTimePage
{
    NSInteger page = _page.currentPage;
    page ++;
    [self turnPage:page];
}

- (void)turnPage:(NSInteger)page
{
    [_mainScrollView setContentOffset:CGPointMake(_mainRect.size.width * (page + 1), 0) animated:YES];
}


#pragma mark - 点击图片
- (void)imgClicked:(UITapGestureRecognizer *)tap{
    UIImageView *imageView = (UIImageView *)tap.view;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickImgAtIndex:)]) {
        [self.delegate clickImgAtIndex:imageView.tag];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger x = scrollView.contentOffset.x/_mainRect.size.width;
    if (x == _imgCount + 1) {
        [scrollView setContentOffset:CGPointMake(_mainRect.size.width, 0) animated:NO];
        [_page setCurrentPage:0];
    }else if (scrollView.contentOffset.x <= 0){
        [scrollView setContentOffset:CGPointMake(_mainRect.size.width*_imgCount, 0) animated:NO];
        [_page setCurrentPage:_imgCount];
    }else{
        [_page setCurrentPage:x-1];
    }
}

@end
