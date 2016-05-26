//  EGTextView.m
//
//  Copyright (c) 2014 egg. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the “Software”), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "EGTextView.h"

#define EGAUTOMATIC_HEIGHT_ANIMATION_DURATION 0.2

@interface EGTextView ()
{
    UILabel *_placeHolderLabel;
    CGFloat _heightWhenKeyboard;
}
@property BOOL editing;
@end

@implementation EGTextView

#pragma mark - Life Circle
- (void)dealloc {
    _placeHolder = [NSAttributedString new];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidBeginEditingNotification
                                                  object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:self];
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    if (self = [super initWithFrame:frame textContainer:textContainer])
    {
        [self _placeholderSetup];
        [self _commonSetup];
        [self _registerObserver];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self _placeholderSetup];
        [self _commonSetup];
        [self _registerObserver];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self _placeholderSetup];
    [self _commonSetup];
    [self _registerObserver];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self _needUpdateDisplayPlaceholder];
}

#pragma mark - Set up method
- (void)_placeholderSetup{
    _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _placeHolderLabel.hidden = YES;
    [self insertSubview:_placeHolderLabel atIndex:0];
}

- (void)_registerObserver{
    // UITextViewTextDidChangeNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewTextDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    // UITextViewTextDidBeginEditingNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewTextDidBegin:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];
    
    // UITextViewTextDidEndEditingNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewTextDidEnd:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
    
    // UIKeyboardDidShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    // UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)_commonSetup
{
    self.editing = NO;
    self.automaticHeightWhenKeyboard = NO;
    self.automaticTransformInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    self.layoutManager.allowsNonContiguousLayout = NO;
    self.scrollsToTop = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 0.0f);
    self.textContainerInset = UIEdgeInsetsMake(8.0, 5.0, 8.0, 5.0);
    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.userInteractionEnabled = YES;
    self.font = [UIFont systemFontOfSize:16.0f];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDefault;
    self.textAlignment = NSTextAlignmentLeft;
}

- (void)_needUpdateDisplayPlaceholder
{
    if([self.text length] == 0 && self.placeHolder)
    {
        _placeHolderLabel.attributedText = _placeHolder;
        [_placeHolderLabel sizeToFit];
        
        CGRect firstGlyph = [self caretRectForPosition:self.selectedTextRange.start];
        CGRect placeHolderRect = CGRectMake(firstGlyph.origin.x,
                                            firstGlyph.origin.y,
                                            _placeHolderLabel.bounds.size.width,
                                            firstGlyph.size.height);
        _placeHolderLabel.frame = placeHolderRect;
        _placeHolderLabel.hidden = NO;
    }
    else
    {
        _placeHolderLabel.hidden = YES;
    }
}

#pragma mark - Observer
- (void)textViewTextDidChange:(NSNotification *)noti
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UITextView *textView = noti.object;
        CGRect line = [textView caretRectForPosition:textView.selectedTextRange.start];
        CGFloat overflow = line.origin.y + line.size.height - ( textView.contentOffset.y + textView.bounds.size.height - textView.contentInset.bottom - textView.contentInset.top );
        if ( overflow > 0 )
        {
            CGPoint offset = textView.contentOffset;
            offset.y += overflow + 7;
            
            [UIView animateWithDuration:.2 animations:^{
                [textView setContentOffset:offset];
            } completion:^(BOOL finished) {
                
            }];
        }
        [self _needUpdateDisplayPlaceholder];
    });
}

- (void)textViewTextDidBegin:(NSNotification *)noti
{
    self.editing = YES;
    _heightWhenKeyboard = self.frame.size.height;
}

- (void)textViewTextDidEnd:(NSNotification *)noti
{
    self.editing = NO;
}

-(void)keyboardDidShow:(NSNotification *)notification
{
    if (!self.isEditing || !self.automaticHeightWhenKeyboard)
    {
        return;
    }
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  keyboardRect = [keyboardObject CGRectValue];
    CGRect  containRect = CGRectIntersection(self.frame, keyboardRect);
    [UIView animateWithDuration:EGAUTOMATIC_HEIGHT_ANIMATION_DURATION delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect rect = self.frame;
        rect.size.height = _heightWhenKeyboard - containRect.size.height - self.automaticTransformInset.bottom;
        self.frame = rect;
    } completion:nil];
}

-(void)keyboardWillHidden:(NSNotification *)notification
{
    if (!self.isEditing || !self.automaticHeightWhenKeyboard)
    {
        return;
    }
    [UIView animateWithDuration:EGAUTOMATIC_HEIGHT_ANIMATION_DURATION delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect rect = self.frame;
        rect.size.height = _heightWhenKeyboard;
        self.frame = rect;
    } completion:nil];
}

#pragma mark - SET/GET
- (void)setPlaceHolder:(NSAttributedString *)placeHolder
{
    if([placeHolder isEqualToAttributedString:_placeHolder])
    {
        return;
    }
    _placeHolder = [placeHolder copy];
    [self _needUpdateDisplayPlaceholder];
}

@end
