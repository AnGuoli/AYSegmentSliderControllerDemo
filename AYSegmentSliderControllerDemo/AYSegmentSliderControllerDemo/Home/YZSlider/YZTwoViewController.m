//
//  YZTwoViewController.m
//  SegmentSliderControllerDemo
//
//  Created by hl on 17/2/23.
//  Copyright © 2017年 ay. All rights reserved.
//

#import "YZTwoViewController.h"

@interface YZTwoViewController ()

@end

@implementation YZTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
    label.text = @"TwoVC";
    [self.view addSubview:label];

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
