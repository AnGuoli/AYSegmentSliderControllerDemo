//
//  TempViewController.m
//  SegmentSliderControllerDemo
//
//  Created by hl on 17/2/22.
//  Copyright © 2017年 ay. All rights reserved.
//

#import "TempViewController.h"
//#import "UIView+Frame.h"
#import "UIView+Extension.h"
#import "YZOneViewController.h"
#import "YZTwoViewController.h"
#import "YZThreeViewController.h"
#import "YZFourViewController.h"
#import "YZFiveViewController.h"
#import "YZSixViewController.h"
#import "YZSevenViewController.h"
#import "XMGTitleButton.h"

#define XMGARGBColor(a, r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define XMGColor(r, g, b) XMGARGBColor(255, (r), (g), (b))

#define XMGGrayColor(v) XMGColor((v), (v), (v))
#define XMGCommonBgColor XMGGrayColor(215)


@interface TempViewController ()<UIScrollViewDelegate>
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) XMGTitleButton *previousClickedTitleButton;
/** 用来存放所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation TempViewController

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化子控制器
    [self setupAllChildVcs];
    
    // 设置导航条
    [self setupNavBar];
    
    // scrollView
    [self setupScrollView];
    
    // 标题栏
    [self setupTitlesView];
    
    // 添加第0个子控制器的view
    [self addChildVcViewIntoScrollView:0];
    
}


/**
 *  初始化子控制器
 */
- (void)setupAllChildVcs
{
    [self addChildViewController:[[YZOneViewController alloc] init]];
    [self addChildViewController:[[YZTwoViewController alloc] init]];
    [self addChildViewController:[[YZThreeViewController alloc] init]];
    [self addChildViewController:[[YZFourViewController alloc] init]];
    [self addChildViewController:[[YZFiveViewController alloc] init]];
    [self addChildViewController:[[YZSixViewController alloc] init]];
    [self addChildViewController:[[YZSevenViewController alloc] init]];
}


#pragma mark - 设置导航条
- (void)setupNavBar
{
    
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    
    // titleView
    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.title = @"来买";
    
}



/**
 *  scrollView
 */
- (void)setupScrollView
{
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    //    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.backgroundColor = XMGCommonBgColor;
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    
    scrollView.scrollsToTop = NO; // 点击状态栏的时候，这个scrollView不会滚动到最顶部
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.width;
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
    
    
}

/**
 *  标题栏
 */
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.frame = CGRectMake(0, 0, self.view.width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标题栏按钮
    [self setupTitleButtons];
    
    // 标题下划线
    [self setupTitleUnderline];
}

/**
 *  标题栏按钮
 */
- (void)setupTitleButtons
{
    // 文字
    NSArray *titles = @[@"全部", @"未读", @"启程通知", @"驶离通知", @"驶离通知", @"驶离通知", @"驶离通知"];
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.width / count;
    CGFloat titleButtonH = self.titlesView.height;
    
    // 创建4个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        XMGTitleButton *titleButton = [[XMGTitleButton alloc] init];
        titleButton.tag = i;
        
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
}

/**
 *  标题下划线
 */
- (void)setupTitleUnderline
{
    // 标题按钮
    XMGTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.height = 2;
    titleUnderline.y = self.titlesView.height - titleUnderline.height;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; // 让label根据文字内容计算尺寸
    self.titleUnderline.width = firstTitleButton.titleLabel.width + 10;
    self.titleUnderline.centerX = firstTitleButton.centerX;
}

#pragma mark - 监听
/**
 *  点击标题按钮
 */
- (IBAction)titleButtonClick:(XMGTitleButton *)titleButton
{
    // 重复点击了标题按钮
    if (self.previousClickedTitleButton == titleButton) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:AYTitleButtonDidRepeatClickNotification object:nil];
    }
    
    // 处理标题按钮点击
    [self dealTitleButtonClick:titleButton];
}


/**
 *  处理标题按钮点击
 */
- (void)dealTitleButtonClick:(XMGTitleButton *)titleButton
{
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSUInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        // 处理下划线
        self.titleUnderline.width = titleButton.titleLabel.width + 10;
        self.titleUnderline.centerX = titleButton.centerX;
        
        // 滚动scrollView
        CGFloat offsetX = self.scrollView.width * index;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        // 添加子控制器的view
        [self addChildVcViewIntoScrollView:index];
    }];
    
    // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        // 如果view还没有被创建，就不用去处理
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        scrollView.scrollsToTop = (i == index);
    }
}


#pragma mark - <UIScrollViewDelegate>
/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 点击对应的标题按钮
    XMGTitleButton *titleButton = self.titlesView.subviews[index];
    [self dealTitleButtonClick:titleButton];
}

#pragma mark - 其他
/**
 *  添加第index个子控制器的view到scrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSUInteger)index
{
    //取出按钮索引对应的控制器
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
    //    if (childVcView.superview) return;
    //    if (childVcView.window) return;
    
    // 设置子控制器view的frame
    CGFloat scrollViewW = self.scrollView.width;
    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.scrollView.height);
    // 添加子控制器的view到scrollView中
    [self.scrollView addSubview:childVcView];
}

- (void)viewWillLayoutSubviews {
    self.scrollView.frame = self.view.bounds;
}


@end
