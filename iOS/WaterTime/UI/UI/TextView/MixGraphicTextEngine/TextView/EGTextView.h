//  EGTextView.h
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

/*******************************  EGTextView  **********************************
 
 1、With a custom place holder.
 2、With a property, you can get the text view for editing status.
 3、Solve the problem that when the keyboard appears, the current text view is blocked,
    and the height of the text view is automatically adjusted.
 
 Note: When you customize a NSTextStorage object to bind textview‘s layoutManager,
       then the text view's place holder position will be abnormal!
       The solution is to re create the textStorage,layoutManager and textContainer.
       Use -initWithFrame:textContainer:.
 
 ********************************************************************************/

#import <UIKit/UIKit.h>

@interface EGTextView : UITextView

/**
 *  The place holder string.
 */
@property (nonatomic, copy) NSAttributedString *placeHolder;

/**
 *  Is editing or NOT,
 *  default = NO.
 *  UITextViewTextDidBeginEditingNotification 
 *  UITextViewTextDidEndEditingNotification
 */
@property (nonatomic, assign, readonly, getter=isEditing) BOOL editing;

/**
 *  Automatically adjust the height when the keyboard showed, or NOT.
 *  default = NO.
 */
@property (nonatomic, assign) BOOL automaticHeightWhenKeyboard;

/**
 *  Automatically adjust height inset
 */
@property (nonatomic, assign) UIEdgeInsets automaticTransformInset;

@end
