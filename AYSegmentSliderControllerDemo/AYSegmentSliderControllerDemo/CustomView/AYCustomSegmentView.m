//
//  AYCustomSegmentView.m
//  SegmentSliderControllerDemo
//
//  Created by hl on 17/2/22.
//  Copyright © 2017年 ay. All rights reserved.
//

#import "AYCustomSegmentView.h"
#import "UIView+Layer.h"
#import "UIView+Extension.h"

/***  选中字体 白色 */
#define kCommonTintColor [UIColor whiteColor]
/***  背景颜色 */
#define kCommonBgColor [UIColor colorWithRed:0.25f green:0.49f blue:0.84f alpha:1.00f]
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]

@implementation AYCustomSegmentView {
    NSArray *_itemTitles;
    UIButton *_selectedBtn;
}

- (instancetype)initWithItemTitles:(NSArray *)itemTitles {
    if (self = [super init]) {
        _itemTitles = itemTitles;
        
        self.layerCornerRadius = 3.0;
        self.layerBorderColor = kCommonTintColor;
        self.layerBorderWidth = 1.0;
        
        [self setUpViews];
    }
    return self;
}

- (void)clickDefault {
    if (_itemTitles.count == 0) {
        return ;
    }
    [self btnClick:(UIButton *)[self viewWithTag:1]];
}

- (void)setUpViews {
    if (_itemTitles.count > 0) {
        NSInteger i = 0;
        for (id obj in _itemTitles) {
            if ([obj isKindOfClass:[NSString class]]) {
                NSString *objStr = (NSString *)obj;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [self addSubview:btn];
                btn.backgroundColor = kCommonBgColor;
                [btn setTitle:objStr forState:UIControlStateNormal];
                [btn setTitleColor:kCommonBgColor forState:UIControlStateSelected];
                [btn setTitleColor:kCommonTintColor forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:16];
                i = i + 1;
                btn.tag = i;
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.adjustsImageWhenDisabled = NO;
                btn.adjustsImageWhenHighlighted = NO;
            }
        }
    }
}

- (void)btnClick:(UIButton *)btn {
    _selectedBtn.backgroundColor = kCommonBgColor;
    btn.backgroundColor = kCommonTintColor;
    
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    NSString *title = btn.currentTitle;
    if (self.AYCustomSegmentViewBtnClickHandle) {
        self.AYCustomSegmentViewBtnClickHandle(self, title, btn.tag - 1);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_itemTitles.count > 0) {
        CGFloat btnW = self.width / _itemTitles.count;
        for (int i = 0 ; i < _itemTitles.count; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:i + 1];
            btn.frame = CGRectMake(btnW * i, 0, btnW, self.height);
        }
    }
}


@end


