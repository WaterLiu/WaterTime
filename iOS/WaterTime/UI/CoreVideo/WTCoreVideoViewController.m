//
//  WTCoreVideoViewController.m
//  WaterTime
//
//  Created by WaterLiu on 12/10/15.
//  Copyright © 2015 WaterLiu. All rights reserved.
//

#import "WTCoreVideoViewController.h"
#import "GIFDownloader.h"


@implementation WTCoreVideoViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - Private

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupScrollView:YES];
    [self addShowTestButtons:@[@"CoreVideo"]];
    [self setDescriptionText:@"Conver Gif File to Video with used CoreVideo Framework."];
    
    

 
}



- (void)showTestButtonsClicked:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docDir = [paths objectAtIndex:0];
    NSString* path = [docDir stringByAppendingString:@"/test.mp4"];
    
    [GIFDownloader sendAsynchronousRequest:@"http://g.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=8761ab575b82b2b7a7ca31c2019de7d7/622762d0f703918f86c90e99533d269759eec44c.jpg" downloadFilePath:path thumbnailFilePath:nil completed:^(NSString *outputFilePath, NSError *error) {
        
        if (error == nil)
        {
            NSURL *URL = [[NSURL alloc] initFileURLWithPath:path];
            _player = [[MPMoviePlayerController alloc] initWithContentURL:URL];
            _player.movieSourceType = MPMovieSourceTypeFile;
            [_player prepareToPlay];
            [self.view addSubview:_player.view];
            [_player setFullscreen:YES animated:NO];
            _player.repeatMode = MPMovieRepeatModeOne;
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(movieFinishedCallback:)
                                                         name:MPMoviePlayerPlaybackDidFinishNotification
                                                       object:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_player play];
            });
        }
    }];
}


- (void)movieFinishedCallback:(NSNotification*)notification
{
    [_player.view removeFromSuperview];
    _player = nil;
}



#pragma mark - Public

@end
