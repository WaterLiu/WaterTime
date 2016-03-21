//
//  WTCollectionViewLayout.h
//  WaterTime
//
//  Created by WaterLiu on 1/21/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTCollectionViewLayout :  UICollectionViewFlowLayout
{
    UIDynamicAnimator*          _animator;
}

@property (nonatomic, assign) CGSize contentItemSize;

@end
