//
//  WTCricleCell.h
//  WaterTime
//
//  Created by WaterLiu on 3/21/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WTCricleCell;

@protocol WTCricleCellDelegate <NSObject>

- (void)cellbeganMove:(WTCricleCell*)cell withLocation:(CGPoint)point;
- (void)cellDidEndMoved:(WTCricleCell*)cell withLocation:(CGPoint)point;
- (void)cellDidMoved:(WTCricleCell*)cell withLocation:(CGPoint)point;

- (void)cellTouched:(WTCricleCell*)cell;

@end

@interface WTCricleCell : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGRect    view_rect;                  //自身view的大小
@property (nonatomic, assign) CGFloat   scale;                      //大小改变比例
@property (nonatomic, assign) CGPoint   view_point;                 //中心点
@property (nonatomic, assign) CGFloat   radian;                     //自己定义坐标的 弧度
@property (nonatomic, assign) CGFloat   animation_radian;           //动画坐标的 弧度

@property (nonatomic, assign) CGFloat   current_radian;             //当前的 自己定义坐标的 弧度
@property (nonatomic, assign) CGFloat   current_animation_radian;   //当前的动画 弧度
@property (nonatomic, assign) CGFloat   current_scale;              //当前的比例

@property (nonatomic, weak) id<WTCricleCellDelegate>  delegate;

@end
