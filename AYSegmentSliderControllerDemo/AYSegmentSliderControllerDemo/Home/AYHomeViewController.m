//
//  AYHomeViewController.m
//  SegmentSliderControllerDemo
//
//  Created by hl on 17/2/22.
//  Copyright © 2017年 ay. All rights reserved.
//

#import "AYHomeViewController.h"
#import "AYCustomSegmentView.h"
#import "AYSliderViewController.h"
#import "TempViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface AYHomeViewController ()
//公司和个人选择器
@property (nonatomic, strong) AYCustomSegmentView *segMent;
@property (nonatomic, strong) AYSliderViewController *slideViewController;
@property (nonatomic, strong) TempViewController *tempController;
@property (nonatomic, strong) UIViewController *currentVC;

@end

@implementation AYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
    label.text = @"AYHomeViewController";
    [self.view addSubview:label];

    self.view.backgroundColor = [UIColor grayColor];
//    [self setControllers];
    
    [self setSegmentTitle];
    

}

//设置公司注册和个人注册
- (void)setSegmentTitle {
    self.segMent = [[AYCustomSegmentView alloc] initWithItemTitles:@[@"公司注册", @"个人注册"]];
    self.navigationItem.titleView = self.segMent;
    self.segMent.frame = CGRectMake(0, 0, 200, 35);
    __weak typeof(self) weakSelf = self;
    self.segMent.AYCustomSegmentViewBtnClickHandle = ^(AYCustomSegmentView *segment, NSString *title, NSInteger currentIndex) {
        [weakSelf changeChildViewWithCurrentIndex:currentIndex];
    };
    [self.segMent clickDefault];
}

#pragma mark -------- 方法1.
//- (void)setControllers {
//    AYSliderViewController *slideViewController = [[AYSliderViewController alloc] init];
//    slideViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49);
//    [self addChildViewController:slideViewController];
//    _slideViewController = slideViewController;
//    
//    TempViewController *tempController = [[TempViewController alloc] init];
//    tempController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49);
//    _tempController = tempController;
//
//    //  默认,第一个视图(全程就这一个用了addSubview)
//    [self.view addSubview:self.slideViewController.view];
//    self.currentVC = self.slideViewController;
//
//}
//
//- (void)changeChildViewWithCurrentIndex:(NSInteger)currentIndex {
//    //  点击处于当前页面的按钮,直接跳出
//    if ((self.currentVC == self.slideViewController && currentIndex == 0)||(self.currentVC == self.tempController && currentIndex == 1)) {
//        return;
//    }else{
//        
//        //  展示2个,其余一样,自行补全
//        switch (currentIndex) {
//            case 0:
//                [self replaceController:self.currentVC newController:self.slideViewController];
//                break;
//            case 1:
//                [self replaceController:self.currentVC newController:self.tempController];
//                break;
//                
//                //.......
//            default:
//                break;
//        }
//    }
//}
//
////  切换各个标签内容
//- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
//{
//    /**
//     transitionFromViewController:toViewController:duration:options:animations:completion:
//     *  fromViewController	  当前显示在父视图控制器中的子视图控制器
//     *  toViewController		将要显示的姿势图控制器
//     *  duration				动画时间(这个属性,old friend 了 O(∩_∩)O)
//     *  options				 动画效果(渐变,从下往上等等,具体查看API)
//     *  animations			  转换过程中得动画
//     *  completion			  转换完成
//     */
////    [newController willMoveToParentViewController:self];
//    [self addChildViewController:newController];
//    [self transitionFromViewController:oldController toViewController:newController duration:0.01 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
//        
//        if (finished) {
//            [newController didMoveToParentViewController:self];
//            [oldController willMoveToParentViewController:nil];
//            [oldController removeFromParentViewController];
//            self.currentVC = newController;
//            
//        }else{
//            self.currentVC = oldController;
//        }
//    }];
//}

#pragma mark -------- NH
- (void)changeChildViewWithCurrentIndex:(NSInteger)currentIndex {
//        BOOL isFeatured = (currentIndex == 0);
//        self.slideViewController.view.hidden = !isFeatured;
//        self.tempController.view.hidden =  isFeatured;

    BOOL isHot = (currentIndex == 0);
    
    if (isHot) { // 热门
        [self addChildVc:self.slideViewController];

        [self removeChildVc:self.tempController];
    } else { // 订阅
        [self addChildVc:self.tempController];
        [self removeChildVc:self.slideViewController];
    }
    
}


- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];

}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);

    [childVc didMoveToParentViewController:self];
}

- (AYSliderViewController *)slideViewController {
    if (!_slideViewController) {
        _slideViewController = [[AYSliderViewController alloc] init];
        [self addChildVc:_slideViewController];
        [_slideViewController setUpContentViewFrame:^(UIView *contentView) {
            contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        }];

    }
    return _slideViewController;
}

- (TempViewController *)tempController {
    if (!_tempController) {
        _tempController = [[TempViewController alloc] init];
        [self addChildVc:_tempController];
    }
    return _tempController;
}

//- (AYSliderViewController *)slideViewController {
//    if (!_slideViewController) {
//        AYSliderViewController *slide = [[AYSliderViewController alloc] init];
//        [slide willMoveToParentViewController:self];
//        [self addChildViewController:slide];
//        [self.view addSubview:slide.view];
////        slide.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49);
//        [slide setUpContentViewFrame:^(UIView *contentView) {
//            contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
//        }];
//
//        _slideViewController = slide;
//    }
//    return _slideViewController;
//}
//
//- (TempViewController *)tempController {
//    if (!_tempController) {
//        TempViewController *tempController = [[TempViewController alloc] init];
//        [tempController willMoveToParentViewController:self];
//        [self addChildViewController:tempController];
//        [self.view addSubview:tempController.view];
//        tempController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49);
//        _tempController = tempController;
//    }
//    return _tempController;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
