//
//  SCHAnimationGroup.h

//
//  Created by WaterLiu on 16-03-24.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface WTAnimationGroup : CAAnimationGroup
{
    NSInteger _animation_tag;
}

@property (nonatomic,assign) NSInteger animation_tag;

@end
