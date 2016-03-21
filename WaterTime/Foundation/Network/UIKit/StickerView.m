//
//  StickerView.m
//  TestCamera
//
//  Created by Mogu_Bj_MacPro on 15/10/28.
//  Copyright © 2015年 WaterLiu. All rights reserved.
//

#import "StickerView.h"


//#define StickerView_StickerButton_Tag       200

@implementation StickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _stickerDic = [NSMutableDictionary dictionaryWithCapacity:10];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        CGFloat x = 0.0f;
        CGFloat space = 5.0f;
        for (NSInteger i = 1; i < NSIntegerMax; i++)
        {
            NSString* path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Images/%ld",i]  ofType:@"png"];
            if (path == nil)
            {
                break;
            }
            UIImage* image = [UIImage imageNamed:path];
            if (!image)
            {
                break;
            }
            
            //UIImage* image = [UIImage imageNamed:path];
            UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0.0f, CGRectGetHeight(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
            [button setImage:image forState:UIControlStateNormal];
            button.tag = i;
            [button addTarget:self action:@selector(stickerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = 8.0f;
            button.backgroundColor = [UIColor groupTableViewBackgroundColor];
            x += (space + CGRectGetWidth(button.frame));
            [_scrollView addSubview:button];
            
            NSMutableArray* substickerArray = [NSMutableArray arrayWithCapacity:10];
            for (NSInteger j = 1; j < NSIntegerMax; j ++)
            {
                NSString* path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Images/%ld-%ld",i,j]  ofType:@"png"];
                if (path == nil)
                {
                    if (substickerArray != nil && [substickerArray count] > 0)
                    {
                        [_stickerDic setObject:substickerArray forKey:[image description]];
                    }
                    break;
                }
                UIImage* subImage = [UIImage imageNamed:path];
                if (image == nil)
                {
                    break;
                }
                
                if (subImage != nil)
                {
                    [substickerArray addObject:subImage];
                }

            }
        }
        
        _scrollView.contentSize = CGSizeMake(x, CGRectGetHeight(_scrollView.frame));
    }
    return self;
}


- (void)dealloc
{
    _scrollView.delegate = nil;
    _scrollView = nil;
}

#pragma mark - Private

- (void)stickerButtonClicked:(UIButton*)sender
{
    NSInteger tag = sender.tag;;
    UIImage * stickerImage = [sender imageForState:UIControlStateNormal];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(stickerViewItem:stickerViewItemClicked:stickerImage:substickerArray:)])
    {
        [_delegate stickerViewItem:sender stickerViewItemClicked:tag stickerImage:stickerImage substickerArray:[_stickerDic objectForKey:[stickerImage description]]];
    }
}


#pragma mark - Public


#pragma mark - UIScrollViewDelegate




@end
