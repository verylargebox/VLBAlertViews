//
//  VLBAlertViewsTests.m
//  VLBAlertViewsTests
//
//  Created by Markos Charatzas on 07/07/2013.
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
#import <SenTestingKit/SenTestingKit.h>
#import <Kiwi/Kiwi.h>


@interface VLBAlertViewsTests : SenTestCase

@end
#import "VLBAlertViews.h"

@implementation VLBAlertViewsTests

@end

SPEC_BEGIN(VLBAlertViewsSpec)

context(@"given a alert view delegate on ok", ^{
    it(@"should callback with the ok button index and alert view", ^{
        __block NSInteger actualButtonIndex;
        __block UIAlertView *actualAlertView;
        
        id<UIAlertViewDelegate> alertViewDelegateOnOk = [VLBAlertViews newAlertViewDelegateOnOk:^(UIAlertView *alertView, NSInteger buttonIndex) {
            actualAlertView = alertView;
            actualButtonIndex = buttonIndex;
        }];
        
        UIAlertView *alertView = [VLBAlertViews newAlertViewWithOk:@"Hello blocks" message:nil];
        alertView.delegate = alertViewDelegateOnOk;
    });
});


context(@"given a alert view delegate on ok and a delegate on cancel ", ^{
    it(@"should callback on both delegates", ^{
        id<UIAlertViewDelegate> alertViewDelegateOnOkDismiss =
        [VLBAlertViews newAlertViewDelegateOnOkDismiss];
        id<UIAlertViewDelegate> alertViewDelegateOnCancelDismiss =
        [VLBAlertViews newAlertViewDelegateOnCancelDismiss];
        
        id<UIAlertViewDelegate> delegate = [VLBAlertViews all:@[alertViewDelegateOnOkDismiss, alertViewDelegateOnCancelDismiss]];
        
        UIAlertView *alertView = [VLBAlertViews newAlertViewWithOkAndCancel:@"Hello all delegates" message:nil];
        
        alertView.delegate = delegate;
    });
});

context(@"given a alert view delegate on local scope", ^{
    it(@"it should still be available to callback at the end of the scope", ^{
        id<UIAlertViewDelegate> alertViewDelegateOnOkDismiss = [VLBAlertViews newAlertViewDelegateOnOkDismiss];
        
        UIAlertView *alertView = [VLBAlertViews newAlertViewWithOk:@"Hello VLBAlertViews" message:nil];
        alertView.delegate = alertViewDelegateOnOkDismiss;        
    });
});

SPEC_END