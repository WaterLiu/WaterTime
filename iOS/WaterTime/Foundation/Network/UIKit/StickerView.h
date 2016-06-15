//
//  StickerView.h
//  TestCamera
//
//  Created by Mogu_Bj_MacPro on 15/10/28.
//  Copyright © 2015年 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol StickerViewDelegate <NSObject>

- (void)stickerViewItem:(UIButton*)button stickerViewItemClicked:(NSInteger)i stickerImage:(UIImage*)image substickerArray:(NSArray*)substickerArray;

@end


@interface StickerView : UIView <UIScrollViewDelegate>
{
    UIScrollView*               _scrollView;
    NSMutableDictionary*        _stickerDic;
}

@property (nonatomic, weak)id<StickerViewDelegate> delegate;
@property (nonatomic, readonly)NSDictionary* stickerDic;

@end
