//
//  NTCArticleImageAttachmentView.h
//  TextView
//
//  Created by NetEase on 15/9/9.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

#import "NTCArticleAttachmentView.h"

@protocol NTCArticleImageAttachmentDelegate;

@interface NTCArticleImageAttachmentView : NTCArticleAttachmentView

@property (nonatomic, strong) NSString *mediaURL;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, weak) id<NTCArticleImageAttachmentDelegate> delegate;

- (instancetype)initWithMediaURL:(NSString *)mediaURL imageSize:(CGSize)size;



@end

@protocol NTCArticleImageAttachmentDelegate <NSObject>

- (void)imageAttachmentViewDidClickClose:(NTCArticleImageAttachmentView *)attachmentView;

@end

