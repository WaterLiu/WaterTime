//
//  TabbarViewView.h
//  Water
//
//  Created by WaterLiu on 2017/4/29.
//  Copyright © 2017年 QQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarView : UIView <CAAnimationDelegate>
{
    UIScrollView*       _scrollView;
    NSMutableArray*     _buttonArray;
    UIView*             _vernierView;
    NSInteger           _currentIndex;
    CGRect              _frame;
    BOOL                _animation;
}


@property (nonatomic, strong) NSArray* _Nullable titils;
@property (nonatomic, assign) UIFont* _Nullable font;
@property (nonatomic, assign) CGFloat buttonSpace;


- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state;

@end
