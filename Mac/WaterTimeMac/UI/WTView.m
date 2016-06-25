//
//  WTView.m
//  WaterTimeMac
//
//  Created by WaterLiu on 6/24/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTView.h"

@implementation WTView

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    
}

//翻转坐标系
- (BOOL)isFlipped
{
    return YES;
}


#pragma mark - Private



#pragma mark - Public



#pragma mark - Setter / Getter

- (void)setBackgroundColor:(NSColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    
    if (backgroundColor != nil)
    {
        [self setWantsLayer:YES];
    }
    else
    {
        [self setWantsLayer:NO];
    }
    
    self.layer.backgroundColor = [backgroundColor CGColor];
}

@end
