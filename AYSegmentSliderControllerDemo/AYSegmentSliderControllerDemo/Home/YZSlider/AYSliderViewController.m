//
//  AYSliderViewController.m
//  SegmentSliderControllerDemo
//
//  Created by hl on 17/2/22.
//  Copyright © 2017年 ay. All rights reserved.
//

#import "AYSliderViewController.h"
#import "YZOneViewController.h"
#import "YZTwoViewController.h"
#import "YZThreeViewController.h"
#import "YZFourViewController.h"
#import "YZFiveViewController.h"
#import "YZSixViewController.h"
#import "YZSevenViewController.h"

@interface AYSliderViewController ()

@end

@implementation AYSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.autoresizingMask = UIViewAutoresizingNone;


    [self setupScrollContent];
    
    [self setupChildVc];
    

    
//    CGFloat y = self.navigationController?64:0;
//    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
//
//    // 设置整体内容尺寸（包含标题滚动视图和底部内容滚动视图）
//    [self setUpContentViewFrame:^(UIView *contentView) {
//        
//        CGFloat contentX = 0;
//        
//        CGFloat contentY = 0;
//        
//        CGFloat contentH = screenH - 64 - 49;
//        
//        contentView.frame = CGRectMake(contentX, contentY, screenW, contentH);
//        
//    }];


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self controllRedRoundsHidden:@[@"3", @"4"].mutableCopy];

}


- (void)setupScrollContent {
    // 设置标题的颜色
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        
        *norColor = [UIColor lightGrayColor];
        *selColor = [UIColor blueColor];
        *titleWidth = [UIScreen mainScreen].bounds.size.width / 4;

    }];
    
    
    // 标题渐变
    // *推荐方式(设置标题渐变)
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        
    }];

    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        //        *isUnderLineDelayScroll = YES;
        *underLineColor = [UIColor blueColor];
//        *isUnderLineEqualTitleWidth = YES;
    }];
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
//    self.isfullScreen = YES;

    
    
    
//    // 设置下划线
//    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
//        
//        *isShowUnderLine = YES;
//        
//        *underLineColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
//        
//    }];
//    
//    // 设置标题的颜色
//    [self setUpTitleGradient:^(BOOL *isShowTitleGradient, YZTitleColorGradientStyle *titleColorGradientStyle, CGFloat *startR, CGFloat *startG, CGFloat *startB, CGFloat *endR, CGFloat *endG, CGFloat *endB) {
//        *startR = 0.6;
//        *startG = 0.6;
//        *startB = 0.6;
//        
//        *endR = 0.7;
//        *endG = 0.7;
//        *endB = 0.7;
//        
//        // 不需要设置的属性，可以不管
//        *isShowTitleGradient = YES;
//        
//        *titleColorGradientStyle = YZTitleColorGradientStyleRGB;
//    }];

}


/**
 *  添加子控制器
 */
- (void)setupChildVc {
    
    
    YZOneViewController *oneVC = [[YZOneViewController alloc] init];
    oneVC.title = @"常用常用常用";
    [self addChildViewController:oneVC];
    
    YZTwoViewController *twoVC = [[YZTwoViewController alloc] init];
    twoVC.title = @"312312312312312312";
    [self addChildViewController:twoVC];
    
    YZThreeViewController *threeVC = [[YZThreeViewController alloc] init];
    threeVC.title = @"444";
    [self addChildViewController:threeVC];
    
    YZFourViewController *fourVC = [[YZFourViewController alloc] init];
    fourVC.title = @"dsfwe";
    [self addChildViewController:fourVC];
    
    YZFiveViewController *fiveVC = [[YZFiveViewController alloc] init];
    fiveVC.title = @"effef";
    [self addChildViewController:fiveVC];
    
    YZSixViewController *sixVC = [[YZSixViewController alloc] init];
    sixVC.title = @"htrh";
    [self addChildViewController:sixVC];
    
    YZSevenViewController *sevenVC = [[YZSevenViewController alloc] init];
    sevenVC.title = @"egerg";
    [self addChildViewController:sevenVC];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存或删除数据" message:@"删除数据将不可恢复" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:nil];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
