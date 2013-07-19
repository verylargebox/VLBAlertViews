//
// 	VLBAlertViews.h
//  verylargebox
//
//  Created by Markos Charatzas on 25/05/2013.
//  Copyright (c) 2013 www.verylargebox.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^VLBAlertViewBlock)(UIAlertView* alertView, NSInteger buttonIndex);

typedef NS_ENUM(NSInteger, VLBButtonIndex)
{
    BUTTON_INDEX_OK = 0,
    BUTTON_INDEX_CANCEL = 1
};

@interface VLBAlertViewDelegate : NSObject <UIAlertViewDelegate>

@end

/**
 Provides access to alertviews and alert view delegates.
 
 */
@interface VLBAlertViews : NSObject

+(VLBAlertViewDelegate *)newAlertViewDelegateOnButtonIndex:(VLBButtonIndex)buttonIndex alertViewBlock:(VLBAlertViewBlock)alertViewBlock;

+(VLBAlertViewDelegate *)newAlertViewDelegateDismissOn:(VLBButtonIndex)buttonIndex;

/**
 @return a new VLBAlertViewDelegate instance that is retained until its alert view is dismissed.
 */
+(VLBAlertViewDelegate *)newAlertViewDelegateOnOkDismiss;

+(VLBAlertViewDelegate *)newAlertViewDelegateOnCancelDismiss;

/**
 
 */
+(VLBAlertViewDelegate *)newAlertViewDelegateOnOk:(VLBAlertViewBlock)alertViewBlock;

+(NSObject<UIAlertViewDelegate>*)all:(NSArray*)alertViewDelegates;

/**
 
 */
+ (UIAlertView *)newAlertViewWithOk:(NSString *)title message:(NSString *)message;

+ (UIAlertView *)newAlertViewWithOkAndCancel:(NSString *)title message:(NSString *)message;

@end
