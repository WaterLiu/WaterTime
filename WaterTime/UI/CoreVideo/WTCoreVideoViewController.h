//
//  WTCoreVideoViewController.h
//  WaterTime
//
//  Created by WaterLiu on 12/10/15.
//  Copyright © 2015 WaterLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTCommonBaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface WTCoreVideoViewController : WTCommonBaseViewController
{
    MPMoviePlayerController*            _player;
}

@end
