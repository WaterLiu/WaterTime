//
//  WTCricleView.h
//  WaterTime
//
//  Created by WaterLiu on 3/21/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTCricleCell.h"

@interface WTCricleView : UIView <WTCricleCellDelegate>
{
    
    WTCricleCell*   _cricleView;
    
    CGPoint         _drag_point;            //拖拽的坐标
    CGPoint         _center_point;          //中心点
    CGFloat         _drag_sensitivity;      //拖拽灵敏度
    CGFloat         _deviation_Radian;      //偏移弧度
    CGFloat         _average_radina;        //平均弧度
    CGFloat         _radius;                //半径长度
    NSInteger       _current_index;         //当前用户选择Index
    BOOL            _is_clockwise;

    
    NSMutableArray* _cellArray;
}

@end
