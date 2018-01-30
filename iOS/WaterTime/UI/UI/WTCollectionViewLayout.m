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
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 10.0f;
        self.minimumInteritemSpacing = 10.0f;
        self.sectionInset = UIEdgeInsetsMake(0.0f, 25.0f, 0.0f, 0.0f);
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

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSInteger pageNum = self.collectionView.contentOffset.x / self.itemSize.width;
    CGPoint targetPoint = CGPointMake(self.collectionView.contentOffset.x * pageNum, proposedContentOffset.y);
    
    return targetPoint;
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
    _contentItemSize = contentItemSize;
    self.itemSize = contentItemSize;
}

@end
