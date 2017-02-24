//
//  AYTabBarController.m
//  SegmentSliderControllerDemo
//
//  Created by hl on 17/2/22.
//  Copyright © 2017年 ay. All rights reserved.
//

#import "AYTabBarController.h"
#import "AYHomeViewController.h"
#import "AYDiscoverViewController.h"
#import "AYCheckViewController.h"
#import "AYMessageViewController.h"

@interface AYTabBarController ()

@end

@implementation AYTabBarController

+ (void)initialize {
    
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
//    [UITabBar appearance].barTintColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    
//    UIImage *tabbarSelectBackImage = [[UIImage imageNamed:@"tabbar-sel"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) resizingMode:UIImageResizingModeStretch];

    UIImage *tabbarSelectBackImage = [self OriginImage:[UIImage imageNamed:@"tabbar-sel"] scaleToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 4.0, 49)] ;
    [UITabBar appearance].selectionIndicatorImage = tabbarSelectBackImage;
    
    UIImage *tabbarBackImage = [self OriginImage:[UIImage imageNamed:@"tabbar-nor"] scaleToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 4.0, 49)] ;
    [UITabBar appearance].backgroundImage = tabbarBackImage;


    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewControllerWithClassname:[AYHomeViewController description] imagename:@"home" title:@"首页"];
    [self addChildViewControllerWithClassname:[AYDiscoverViewController description] imagename:@"Found" title:@"发现"];
    [self addChildViewControllerWithClassname:[AYCheckViewController description]imagename:@"audit" title:@"审核"];
    [self addChildViewControllerWithClassname:[AYMessageViewController description] imagename:@"newstab" title:@"消息"];
    
    // tabbar 背景颜色
//    self.tabBar.barTintColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1];
//    UIImage *tabbarSelectBackImage = [[UIImage imageNamed:@"tabbar-sel"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) resizingMode:UIImageResizingModeStretch];
//
//    self.tabBar.selectionIndicatorImage = tabbarSelectBackImage;
    // icon 图标选中颜色


}

// 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    // 图片不被渲染
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_press"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 图片会被渲染
//    nav.tabBarItem.selectedImage = [UIImage imageNamed:[imagename stringByAppendingString:@"_press"]];
//    self.tabBar.tintColor = [UIColor redColor];
    // 设置导航条背景图片
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbg-image"] forBarMetrics:UIBarMetricsDefault];

    [self addChildViewController:nav];
}

//修改图片大小
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

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
