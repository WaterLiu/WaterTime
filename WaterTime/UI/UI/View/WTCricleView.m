//
//  WTCricleView.m
//  WaterTime
//
//  Created by WaterLiu on 3/21/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTCricleView.h"


#define Elements_Count  7

@implementation WTCricleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {        
        _center_point = self.center;
        _drag_sensitivity = 1.0f;       //灵敏度
        _deviation_Radian = 1.0f;       //偏移弧度
        _radius = 90.0f;                //半径
        
        
        _cellArray = [[NSMutableArray alloc] initWithCapacity:10];
        _average_radina = 2 * M_PI / Elements_Count;
        for (int i = 0; i < Elements_Count; i++)
        {
            WTCricleCell* cell = [[WTCricleCell alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
            cell.delegate = self;
            cell.backgroundColor = [UIColor greenColor];
            [_cellArray addObject:cell];
            [self addSubview:cell];
            
            CGFloat cell_radina = [self getRadinaByRadian:(i * _average_radina + _deviation_Radian)];
            cell.center = [self getPointByRadian:cell_radina
                                  centreOfCircle:_center_point
                                  radiusOfCircle:_radius];
        }
    }
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - Private




#pragma mark - Public


#pragma mark - Math

- (CGFloat)schAtan2f:(CGFloat)a theB:(CGFloat)b
{
    CGFloat rd = atan2f(a,b);
    
    if(rd < 0.0f)
    {
        return M_PI * 2 + rd;
    }
    else
    {
        return rd;
    }
}

- (CGFloat)getRadinaByRadian:(CGFloat)radian
{
    
    if(radian > 2 * M_PI)
    {
        return (radian - floorf(radian / (2.0f * M_PI)) * 2.0f * M_PI);
    }
    
    if(radian < 0.0f)
    {
        return (2.0f * M_PI + radian - ceilf(radian / (2.0f * M_PI)) * 2.0f * M_PI);
    }
    return radian;
}

- (CGPoint)getPointByRadian:(CGFloat)radian centreOfCircle:(CGPoint)circle_point radiusOfCircle:(CGFloat)circle_radius
{
    CGFloat c_x = sinf(radian) * circle_radius + circle_point.x;
    CGFloat c_y = cosf(radian) * circle_radius + circle_point.y;
    return CGPointMake(c_x, c_y);
}


#pragma mark - WTCricleCellDelegate

- (void)cellbeganMove:(WTCricleCell *)cell withLocation:(CGPoint)point
{
    _drag_point = point;
}

- (void)cellDidEndMoved:(WTCricleCell*)cell withLocation:(CGPoint)point
{    
    /*拖动*/
    [self dragPoint:_drag_point movePoint:point circleCenterPoint:_center_point];
    
    
    /*修正圆*/
//    [self reviseCirclePoint];
//    
//    if([_circle_view_delegate respondsToSelector:@selector(dragEndCircleViewCell:indexOfCircleViewCell:)])
//    {
//        NSInteger index = [_circle_cell_array indexOfObject:cell];
//        
//        [_circle_view_delegate dragEndCircleViewCell:cell indexOfCircleViewCell:index];
//    }
}


- (void)dragPoint:(CGPoint)drag_point movePoint:(CGPoint)move_point circleCenterPoint:(CGPoint)circle_center_point
{
    /*转换弧度*/
    CGFloat drag_radian = [self schAtan2f:drag_point.x - circle_center_point.x theB:drag_point.y - circle_center_point.y];
    CGFloat move_radian = [self schAtan2f:move_point.x - circle_center_point.x theB:move_point.y - circle_center_point.y];
    CGFloat change_radian = (move_radian - drag_radian) * _drag_sensitivity;
    
    /*改变位置*/
    for (int i = 0; i < [_cellArray count]; ++i)
    {
        WTCricleCell *cell = [_cellArray objectAtIndex:i];
        cell.current_radian = [self getRadinaByRadian:cell.current_radian + change_radian];
        cell.center = [self getPointByRadian:cell.current_radian centreOfCircle:_center_point radiusOfCircle:_radius];
    }
}

@end
