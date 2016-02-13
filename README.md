# Introduction
An API that introduces local scope to a UIAlertView's delegate, adds support for multiple delegates per UIAlertView and blocks.

All too often a UIAlertView is used within a controller, set as its delegate. Since a controller outlives the UIAlertView, it provides a convenient workaround on the weak property of its delegate.

In addition, the controller is designed to respond to every callback as a result of a clicked button index. That usually leads to a long list of if statements within the callback.

VLBAlertViewDelegate aims to address those issues. 

# VLBAlertViewDelegate 

A VLBAlertViewDelegate is assigned a predicate on the button index and an associated block to execute should the predicate evaluate to true.

The VLBAlertViewDelegate purposely creates a retain cycle with its block, that breaks upon a clickedButtonAtIndex event to have an equal lifecycle as its UIAlertView, thus achieving local scope.
 
A composite of VLBAlertViewDelegate(s), can be used to respond to different clickedButtonAtIndex events.

# What is included

* VLBAlertViews
The 'VLBAlertViews.xcodeproj' builds a static library 'libVLBAlertViews.a'

# CocoaPods

-> VLBAlertViews (1.0)
   An API that uses blocks with UIAlertView(s), adds support for multiple delegates and introduces local scope to a UIAlertViewDelegate.
   - Homepage: https://github.com/qnoid/VLBAlertViews
   - Source:   https://github.com/qnoid/VLBAlertViews.git
   - Versions: 1.0 [master repo]

# Versions
1.0 initial version. Supports blocks, multiple delegate assignment, local scope.

# How to use

## Local Scope

	    id<UIAlertViewDelegate> alertViewDelegateOnOkDismiss = [VLBAlertViews newAlertViewDelegateOnOkDismiss];
    
    UIAlertView *alertView = [VLBAlertViews newAlertViewWithOk:title message:message];
    alertView.delegate = alertViewDelegateOnOkDismiss;
    
    [alertView show];

## Multiple Delegates

    id<UIAlertViewDelegate> alertViewDelegateOnOkDismiss =
        [VLBAlertViews newAlertViewDelegateOnOkDismiss];
    id<UIAlertViewDelegate> alertViewDelegateOnCancelDismiss =
        [VLBAlertViews newAlertViewDelegateOnCancelDismiss];
    
    id<UIAlertViewDelegate> delegate = [VLBAlertViews all:@[alertViewDelegateOnOkDismiss, alertViewDelegateOnCancelDismiss]];

    UIAlertView *alertView = [VLBAlertViews newAlertViewWithOkAndCancel:title message:message];
    
    alertView.delegate = delegate;

    [alertView show];

## Blocks

    id<UIAlertViewDelegate> alertViewDelegateOnOk = [VLBAlertViews newAlertViewDelegateOnOk:^(UIAlertView *alertView, NSInteger buttonIndex) {
        }];

    UIAlertView *alertView = [VLBAlertViews newAlertViewWithOk:title message:message];
    alertView.delegate = alertViewDelegateOnOk;
    
    [alertView show];

# Future Work

TBD

# Notes

There are no tests to guard the code. 

# Licence

VLBAlertViews published under the MIT license:

Copyright (C) 2013, www.verylargebox.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

