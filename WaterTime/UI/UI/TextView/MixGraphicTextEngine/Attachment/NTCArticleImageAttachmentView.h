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

@property (nonatomic, weak) id<NTCArticleImageAttachmentDelegate> delegate;
@property (nonatomic, readonly) UIImage* image;

- (instancetype)initWithImage:(UIImage*)image;

@end

@protocol NTCArticleImageAttachmentDelegate <NSObject>

- (void)imageAttachmentViewDidClickClose:(NTCArticleImageAttachmentView *)attachmentView;

@end

