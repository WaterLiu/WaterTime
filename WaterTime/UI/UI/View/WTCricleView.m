//
//  WTCricleView.m
//  WaterTime
//
//  Created by WaterLiu on 3/21/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTCricleView.h"
#import "WTAnimationGroup.h"
#import <SafariServices/SafariServices.h>


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
        _current_index = 0;             //当前用户select index
        
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
            cell.current_radian = cell_radina;
            cell.radian = cell_radina;
            cell.animation_radian = [self getAnimationRadianByRadian:cell_radina];
            cell.current_animation_radian = cell.animation_radian;
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

- (CGFloat)getAnimationRadianByRadian:(CGFloat)radian
{
    CGFloat an_r = 2.0f * M_PI -  radian + M_PI_2;
    
    if(an_r < 0.0f)
    {
        an_r =  - an_r;
    }
    return an_r;
}



#pragma mark - WTCricleCellDelegate

- (void)cellbeganMove:(WTCricleCell *)cell withLocation:(CGPoint)point
{
    _drag_point = point;
}

- (void)cellDidMoved:(WTCricleCell*)cell withLocation:(CGPoint)point
{
    /*拖动*/
    [self dragPoint:_drag_point movePoint:point circleCenterPoint:_center_point];
    _drag_point = point;
}

- (void)cellDidEndMoved:(WTCricleCell*)cell withLocation:(CGPoint)point
{    
    /*拖动*/
    [self dragPoint:_drag_point movePoint:point circleCenterPoint:_center_point];

    /*修正圆*/
    [self reviseCirclePoint];
}



- (void)cellTouched:(WTCricleCell*)cell
{
    
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
        WTCricleCell *cell = [_cellArray objectAtIndex :i];
        cell.current_radian = [self getRadinaByRadian:cell.current_radian + change_radian];
        cell.center = [self getPointByRadian:cell.current_radian centreOfCircle:_center_point radiusOfCircle:_radius];
    }
    
    
}

- (void)animateWithDuration:(CGFloat)time
               animateDelay:(CGFloat)delay
                changeIndex:(NSInteger)change_index
                    toIndex:(NSInteger)to_index
                circleArray:(NSMutableArray *)array
                  clockwise:(BOOL)is_clockwise
{
    
    WTCricleCell* change_cell = [array objectAtIndex:change_index];
    WTCricleCell* to_cell = [array objectAtIndex:to_index];
    
    /*圆*/
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:[NSString stringWithFormat:@"position"]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,change_cell.layer.position.x,change_cell.layer.position.y);
    
    BOOL clockwise = is_clockwise ? NO : YES;
    
    CGPathAddArc(path,
                 nil,
                 _center_point.x, _center_point.y, /*圆心*/
                 _radius,                          /*半径*/
                 change_cell.current_animation_radian, to_cell.animation_radian, /*弧度改变*/
                 clockwise);
    
    animation.path = path;
    CGPathRelease(path);
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.calculationMode = @"paced";
    
    /*缩放*/
//    CABasicAnimation *scale_anim  = [CABasicAnimation animationWithKeyPath:@"transform"];
//    scale_anim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(change_cell.current_scale, change_cell.current_scale,1.0f)];
//    
//    scale_anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(to_cell.scale, to_cell.scale, 1.0)];
//    scale_anim.fillMode = kCAFillModeForwards;
//    scale_anim.removedOnCompletion = NO;
    
    /*动画组合*/
    WTAnimationGroup *anim_group  = [WTAnimationGroup animation];
    anim_group.animations = [NSArray arrayWithObjects:animation, /* scale_anim, */ nil];
    anim_group.duration = time + delay;
    anim_group.delegate = self;
    anim_group.fillMode = kCAFillModeForwards;
    anim_group.removedOnCompletion = NO;
    anim_group.animation_tag = change_index;
    
    [change_cell.layer addAnimation:anim_group
                             forKey:[NSString stringWithFormat:@"anim_group_%ld",(long)change_index]];
    
    /*改变属性*/
    change_cell.current_animation_radian = to_cell.animation_radian;
//    change_cell.current_scale = to_cell.scale;
    change_cell.current_radian = to_cell.radian;
    
//    NSLog(@"frame = %@", NSStringFromCGRect(change_cell.frame));
    
}



- (void)reviseCirclePoint
{
    WTCricleCell *cell = [_cellArray objectAtIndex:0];
    CGFloat   temp_value  = [self getRadinaByRadian:(cell.current_radian - _deviation_Radian)] / _average_radina;
    NSInteger temp_number = (NSInteger)(floorf(temp_value));
    temp_value            = temp_value - floorf(temp_value);
    
    /*顺时针移动*/
    if((temp_value / _average_radina) < 0.5f)
    {
        _is_clockwise  = YES;
        _current_index = [_cellArray count] - temp_number;
    }
    /*逆时针移动*/
    else
    {
        _is_clockwise  = NO;
        _current_index = ([_cellArray count] - ++temp_number)% [_cellArray count];
    }
    
    /*动画*/
//    _is_drag_animation = YES;
    
    for (int i = 0; i < [_cellArray count]; i++)
    {
//        ++drag_animation_count;
        [self animateWithDuration:0.25f * (temp_value / _average_radina)
                     animateDelay:0.0f
                      changeIndex:(_current_index + i) % [_cellArray count]
                          toIndex:i
                      circleArray:_cellArray
                        clockwise:_is_clockwise];
    }
    
    
}

@end
