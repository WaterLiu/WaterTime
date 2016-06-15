//
//  WTCollectionViewLayout.m
//  WaterTime
//
//  Created by WaterLiu on 1/21/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTCollectionViewLayout.h"

@implementation WTCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 0.0f;
    }
    return self;
}

- (void)dealloc
{
    
}


- (void)prepareLayout
{
    [super prepareLayout];
}

#pragma mark - Override


-(CGSize)collectionViewContentSize
{
    return CGSizeMake(100.0f, 1500.0f);
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    return array;
}

#pragma mark - Privates


#pragma mark - Public


#pragma mark - Setter&Getter

- (void)setContentItemSize:(CGSize)contentItemSize
{
    self.itemSize = contentItemSize;
}

@end
