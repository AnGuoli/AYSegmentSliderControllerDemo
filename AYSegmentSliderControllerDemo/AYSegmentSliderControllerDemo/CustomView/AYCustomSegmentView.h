//
//  AYCustomSegmentView.h
//  SegmentSliderControllerDemo
//
//  Created by hl on 17/2/22.
//  Copyright © 2017年 ay. All rights reserved.
//
//  切换视图，类似于系统的UISegmentControl

#import <UIKit/UIKit.h>

@interface AYCustomSegmentView : UIView

- (instancetype)initWithItemTitles:(NSArray *)itemTitles;

/**
 *  从0开始
 */
@property (nonatomic, copy) void(^AYCustomSegmentViewBtnClickHandle)(AYCustomSegmentView *segment, NSString *currentTitle, NSInteger currentIndex);

- (void)clickDefault;

@end
