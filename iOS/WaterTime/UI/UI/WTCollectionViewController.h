//
//  WTCollectionViewController.h
//  WaterTime
//
//  Created by WaterLiu on 1/20/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTCommonBaseViewController.h"

@interface WTCollectionViewController : WTCommonBaseViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView*           _collectionView;
}

@end
