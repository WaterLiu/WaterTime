//
//  WTTextViewViewController.h
//  WaterTime
//
//  Created by WaterLiu on 16/5/26.
//  Copyright © 2016年 WaterLiu. All rights reserved.
//

#import "WTCommonBaseViewController.h"
#import "NTCArticleTextView.h"


@interface WTTextViewViewController : WTCommonBaseViewController <UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NTCArticleTextView*     _textView;
}

@end
