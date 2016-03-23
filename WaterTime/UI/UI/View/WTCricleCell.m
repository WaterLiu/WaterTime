//
//  WTCricleCell.m
//  WaterTime
//
//  Created by WaterLiu on 3/21/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTCricleCell.h"

@implementation WTCricleCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        /*增加单击事件*/
        UITapGestureRecognizer* single_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)] ;
        single_tap.numberOfTapsRequired = 1;
        single_tap.cancelsTouchesInView = NO;
        single_tap.numberOfTouchesRequired = 1;
        single_tap.delegate = self;
        [self addGestureRecognizer:single_tap];
        
        /*增加拖动事件*/
        UIPanGestureRecognizer* single_pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSinglePan:)];
        single_pan.cancelsTouchesInView = NO;
        single_pan.delegate = self;
        [self addGestureRecognizer:single_pan];
    }
    return self;
}


- (void)dealloc
{
    
}

#pragma mark - Private

- (void)handleSingleTap:(UITapGestureRecognizer*)gestureRecognizer
{
    NSLog(@"handleSingleTap");
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
        }
            break;
        default:
            
            break;
    }
}


- (void)handleSinglePan:(UIPanGestureRecognizer*)gestureRecognizer
{
    NSLog(@"handleSinglePan");
    static CGPoint beganPoint;
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            beganPoint = [gestureRecognizer locationInView:self];
            if (_delegate != nil && [_delegate respondsToSelector:@selector(cellbeganMove:withLocation:)])
            {
                [_delegate cellbeganMove:self withLocation:beganPoint];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [gestureRecognizer locationInView:self];
//            CGPoint movedPoint = CGPointMake(point.x - beganPoint.x, point.y - beganPoint.y);
            if (_delegate != nil && [_delegate respondsToSelector:@selector(cellDidEndMoved:withLocation:)])
            {
                [_delegate cellDidEndMoved:self withLocation:point];
            }
        }
            break;
        default:
            
            break;
    }
}



@end
