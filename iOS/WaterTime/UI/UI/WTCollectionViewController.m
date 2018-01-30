//
//  WTCollectionViewController.m
//  WaterTime
//
//  Created by WaterLiu on 1/20/16.
//  Copyright © 2016 WaterLiu. All rights reserved.
//

#import "WTCollectionViewController.h"
#import "WTCollectionViewLayout.h"

static NSString *reuseId = @"collectionViewCellReuseId";

@implementation WTCollectionViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    _collectionView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WTCollectionViewLayout* layout = [[WTCollectionViewLayout alloc] init];
    layout.contentItemSize = CGSizeMake(CGRectGetWidth(self.view.frame) - 20.0f - 50.0f, CGRectGetHeight(self.view.frame));

    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseId];
    _collectionView.backgroundColor = [UIColor blueColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.layer.masksToBounds = YES;
    [self.view addSubview:_collectionView];
    [_collectionView reloadData];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}

#pragma mark - Private


#pragma mark - Public




#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

#pragma mark - UICollectionViewDelegate




@end
