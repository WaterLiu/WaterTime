//
//  WTFontViewController.h
//  WaterTime
//
//  Created by WaterLiu on 12/14/15.
//  Copyright © 2015 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTCommonBaseViewController.h"

@interface WTFontViewController : WTCommonBaseViewController
{
    NSMutableArray*         _fontList;
    UITextView*             _textView;
    NSInteger               _currentFontIndex;
    NSTimer*                _timer;
    
    UIBarButtonItem*        _rightButtonItemPlay;
    UIBarButtonItem*        _rightButtonitemPause;
}

@end
