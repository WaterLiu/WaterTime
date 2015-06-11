//
//  WTCommonBaseViewController.h
//  WaterTime
//
//  Created by WaterLiu on 15/1/23.
//  Copyright (c) 2015年 WaterLiu. All rights reserved.
//

#import "WTLayoutBaseViewController.h"

@interface WTCommonBaseViewController : WTLayoutBaseViewController
{
    UIScrollView*           _scrollView;
    UILabel*                _descriptionLabel;
    
    
    CGFloat                 _testBtnBottomY;
}

@property (nonatomic, readonly) UIScrollView* scrollView;

/**
 *  Set up Scroll View
 *
 *  @param setup whether set up Scroll View.
 */
- (void)setupScrollView:(BOOL)setup;

/**
 *  Add Test Buttons
 *
 *  @param btns btton's title
 */
- (void)addShowTestButtons:(NSArray*)btns;


- (void)addDescriptionLable:(BOOL)isAdd;

- (void)setDescriptionText:(NSString*)text;

@end

