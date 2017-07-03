//
//  TabbarViewView.m
//  Water
//
//  Created by WaterLiu on 2017/4/29.
//  Copyright © 2017年 QQ. All rights reserved.
//

#import "TabbarView.h"

#define TabbarViewView_AnimationDuration 0.15

@implementation TabbarView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _buttonArray = [NSMutableArray arrayWithCapacity:10];
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [self addSubview:_scrollView];
        
        _vernierView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 3.0f)];
        _vernierView.layer.cornerRadius = 1.5f;
        _vernierView.backgroundColor = [UIColor colorWithRed:0x57/255.0f green:0xd4/255.0f blue:0xd9/255.0f alpha:1.0f];
        _vernierView.layer.anchorPoint = CGPointMake(0.0f, 0.0f);
        [_scrollView addSubview:_vernierView];
        _currentIndex = -1;
        
        _buttonSpace = 20.0f;
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;
    _vernierView.frame = CGRectMake(CGRectGetMinX(_vernierView.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(_vernierView.frame), CGRectGetWidth(_vernierView.frame), CGRectGetHeight(_vernierView.frame));
    
    [self layoutButtons];
    
}

#pragma mark - Private

- (void)clear
{
    for (int i = 0; i < _buttonArray.count; i++)
    {
        UIButton* button = [_buttonArray objectAtIndex:i];
        [button removeFromSuperview];
    }
    [_buttonArray removeAllObjects];
}

- (void)setVernierSelectIndex:(NSInteger)index animation:(BOOL)animation
{
    if (index < 0 || index >= _buttonArray.count)
    {
        return;
    }
    else
    {
        if (index == _currentIndex)
        {
            return;
        }
        
        
        if (animation)
        {
            UIButton* button = [_buttonArray objectAtIndex:index];
            
            if (index > _currentIndex)
            {
                CGRect fromFrame1 = _vernierView.frame;
                CGRect toFrame1 = CGRectMake(CGRectGetMinX(_vernierView.frame),
                                             CGRectGetMinY(_vernierView.frame),
                                             CGRectGetMidX(button.frame) - CGRectGetMinX(_vernierView.frame),
                                             CGRectGetHeight(_vernierView.frame));
                
                CGRect fromFrame2 = CGRectMake(CGRectGetMinX(_vernierView.frame),
                                               CGRectGetMinY(_vernierView.frame),
                                               CGRectGetMidX(button.frame) - CGRectGetMinX(_vernierView.frame),
                                               CGRectGetHeight(_vernierView.frame));
                CGRect toFrame2 = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMinY(_vernierView.frame), CGRectGetWidth(button.frame), CGRectGetHeight(_vernierView.frame));
                
                _vernierView.layer.frame = toFrame2;
                
                CABasicAnimation* animation1 = [CABasicAnimation animationWithKeyPath:@"bounds"];
                animation1.duration = TabbarViewView_AnimationDuration;
                animation1.fromValue = [NSValue valueWithCGRect:fromFrame1];
                animation1.toValue = [NSValue valueWithCGRect:toFrame1];
                
                CABasicAnimation* animation2 = [CABasicAnimation animationWithKeyPath:@"position"];
                animation2.duration = TabbarViewView_AnimationDuration;
                animation2.fromValue = [NSValue valueWithCGPoint:fromFrame1.origin];
                animation2.toValue = [NSValue valueWithCGPoint:toFrame1.origin];
                
                CABasicAnimation* animation3 = [CABasicAnimation animationWithKeyPath:@"bounds"];
                animation3.beginTime = TabbarViewView_AnimationDuration;
                animation3.duration = TabbarViewView_AnimationDuration;
                animation3.fromValue = [NSValue valueWithCGRect:fromFrame2];
                animation3.toValue = [NSValue valueWithCGRect:toFrame2];
                
                CABasicAnimation* animation4 = [CABasicAnimation animationWithKeyPath:@"position"];
                animation4.beginTime = TabbarViewView_AnimationDuration;
                animation4.duration = TabbarViewView_AnimationDuration;
                animation4.fromValue = [NSValue valueWithCGPoint:fromFrame2.origin];
                animation4.toValue = [NSValue valueWithCGPoint:toFrame2.origin];
                
                CAAnimationGroup* group = [CAAnimationGroup animation];
                group.duration = TabbarViewView_AnimationDuration * 2;
                group.delegate = self;
                group.animations = @[animation1,animation2,animation3,animation4];
                
                [_vernierView.layer addAnimation:group forKey:nil];
                
            }
            else
            {
                CGRect fromFrame1 = _vernierView.frame;
                
                
                CGRect toFrame1 = CGRectMake(CGRectGetMidX(button.frame),
                                             CGRectGetMinY(_vernierView.frame),
                                             CGRectGetMaxX(_vernierView.frame) - CGRectGetMidX(button.frame),
                                             CGRectGetHeight(_vernierView.frame));
                
                CGRect fromFrame2 = CGRectMake(CGRectGetMidX(button.frame),
                                               CGRectGetMinY(_vernierView.frame),
                                               CGRectGetMaxX(_vernierView.frame) - CGRectGetMidX(button.frame),
                                               CGRectGetHeight(_vernierView.frame));
                CGRect toFrame2 = CGRectMake(CGRectGetMinX(button.frame),
                                             CGRectGetMinY(_vernierView.frame),
                                             CGRectGetWidth(button.frame),
                                             CGRectGetHeight(_vernierView.frame));
                
                _vernierView.layer.frame = toFrame2;
                
                CABasicAnimation* animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
                animation1.duration = TabbarViewView_AnimationDuration;
                animation1.fromValue = [NSValue valueWithCGPoint:fromFrame1.origin];
                animation1.toValue = [NSValue valueWithCGPoint:toFrame1.origin];
                
                CABasicAnimation* animation2 = [CABasicAnimation animationWithKeyPath:@"bounds"];
                animation2.duration = TabbarViewView_AnimationDuration;
                animation2.fromValue = [NSValue valueWithCGRect:fromFrame1];
                animation2.toValue = [NSValue valueWithCGRect:toFrame1];
                
                CABasicAnimation* animation3 = [CABasicAnimation animationWithKeyPath:@"position"];
                animation3.beginTime = TabbarViewView_AnimationDuration;
                animation3.duration = TabbarViewView_AnimationDuration;
                animation3.fromValue = [NSValue valueWithCGPoint:fromFrame2.origin];
                animation3.toValue = [NSValue valueWithCGPoint:toFrame2.origin];
                
                CABasicAnimation* animation4 = [CABasicAnimation animationWithKeyPath:@"bounds"];
                animation4.beginTime = TabbarViewView_AnimationDuration;
                animation4.duration = TabbarViewView_AnimationDuration;
                animation4.fromValue = [NSValue valueWithCGRect:fromFrame2];
                animation4.toValue = [NSValue valueWithCGRect:toFrame2];
    
                
                CAAnimationGroup* group = [CAAnimationGroup animation];
                group.duration = TabbarViewView_AnimationDuration * 2;
                group.delegate = self;
                group.animations = @[animation1,animation2,animation3,animation4];
                
                [_vernierView.layer addAnimation:group forKey:nil];
            }
        }
        else
        {
            [_vernierView.layer removeAllAnimations];
            
            UIButton* button = [_buttonArray objectAtIndex:index];
            _vernierView.frame = CGRectMake(CGRectGetMinX(button.frame), CGRectGetMaxY(button.frame), CGRectGetWidth(button.frame), 3.0f);
            _frame = _vernierView.frame;
        }
        _currentIndex = index;
    }
}

- (UIButton*)buttonWithTitle:(NSString*)title
{
    UIButton* button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)buttonClicked:(id)sender
{
    NSInteger index = 0;
    for (int i = 0; i < _buttonArray.count; i++)
    {
        if (sender == [_buttonArray objectAtIndex:i])
        {
            index = i;
            break;
        }
    }
    
    if (_currentIndex == index)
    {
        return;
    }
    
    
    UIButton* oldButton = [_buttonArray objectAtIndex:_currentIndex];
    UIButton* newButton = [_buttonArray objectAtIndex:index];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:TabbarViewView_AnimationDuration];
    oldButton.alpha = 0.5;
    newButton.alpha = 1.0f;
    [UIView commitAnimations];
    
    [self setVernierSelectIndex:index animation:YES];
}

- (void)layoutButtons
{
    CGFloat buttonX = _buttonSpace;
    for (int i = 0; i < _buttonArray.count; i++)
    {
        UIButton* button = [_buttonArray objectAtIndex:i];
        [button sizeToFit];
        
        button.frame = CGRectMake(buttonX, (CGRectGetHeight(self.frame) - CGRectGetHeight(button.frame)) / 2, CGRectGetWidth(button.frame), CGRectGetHeight(button.frame));
        
        buttonX += (CGRectGetWidth(button.frame) + _buttonSpace);
    }
    
    _scrollView.contentSize = CGSizeMake(buttonX, _scrollView.contentSize.height);
}


#pragma mark - Public

- (void)setTitils:(NSArray *)titils
{
    [self clear];
    
    for (int i = 0; i < titils.count; i++)
    {
        UIButton* button = [self buttonWithTitle:[titils objectAtIndex:i]];
        [_buttonArray addObject:button];
        [_scrollView addSubview:button];
    }
    [self setVernierSelectIndex:0 animation:NO];
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    for (int i = 0; i < _buttonArray.count; i++)
    {
        UIButton* button = [_buttonArray objectAtIndex:i];
        button.titleLabel.font = font;
    }
}

- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state
{
    for (int i = 0; i < _buttonArray.count; i++)
    {
        UIButton* button = [_buttonArray objectAtIndex:i];
        [button setTitleColor:color forState:state];
    }
}


@end
