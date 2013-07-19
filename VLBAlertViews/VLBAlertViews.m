//
// 	VLBAlertViews.m
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

#import "VLBAlertViews.h"
#import "VLBMacros.h"

NS_INLINE
NSPredicate* isButtonIndex(VLBButtonIndex buttonIndex){
    return [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return ((NSNumber*)evaluatedObject).intValue == buttonIndex;
    }];
}

NS_INLINE
NSPredicate* isButtonIndexOk(){
    return isButtonIndex(BUTTON_INDEX_OK);
}

NS_INLINE
NSPredicate* isButtonIndexCancel(){
    return isButtonIndex(BUTTON_INDEX_CANCEL);
}

@interface VLBAlertViewDelegate ()
@property (nonatomic, strong) NSPredicate *predicateOnButtonIndex;
@property (nonatomic, copy) VLBAlertViewBlock alertViewBlock;
-(id)init:(NSPredicate*) predicateOnButtonIndex alertViewBlock:(VLBAlertViewBlock)alertViewBlock;
@end

@implementation VLBAlertViewDelegate

+(VLBAlertViewDelegate*) newAlertViewDelegateOnPredicate:(NSPredicate*)predicate alertViewBlock:(VLBAlertViewBlock)alertViewBlock {
return [[VLBAlertViewDelegate alloc] init:predicate alertViewBlock:alertViewBlock];
}

-(id)init:(NSPredicate*)predicateOnButtonIndex alertViewBlock:(VLBAlertViewBlock)alertViewBlock
{
    VLB_INIT_OR_RETURN_NIL();
    
    self.predicateOnButtonIndex = predicateOnButtonIndex;
    self.alertViewBlock = alertViewBlock;
    
    return self;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(![self.predicateOnButtonIndex evaluateWithObject:VLB_Integer(buttonIndex)]){
        return;
    }
    
    self.alertViewBlock(alertView, buttonIndex);
}

@end


@implementation VLBAlertViews

+(VLBAlertViewDelegate *)newAlertViewDelegateOnPredicate:(NSPredicate*)predicate alertViewBlock:(VLBAlertViewBlock)alertViewBlock
{
    __block VLBAlertViewDelegate *alertViewDelegate;
    alertViewDelegate = [VLBAlertViewDelegate newAlertViewDelegateOnPredicate:predicate alertViewBlock:^(UIAlertView* alertView, NSInteger buttonIndex){
        alertViewBlock(alertView, buttonIndex);
        alertViewDelegate = nil;
    }];
    
return alertViewDelegate;
}

+(VLBAlertViewDelegate *)newAlertViewDelegateOnButtonIndex:(VLBButtonIndex)buttonIndex alertViewBlock:(VLBAlertViewBlock)alertViewBlock{
    return [self newAlertViewDelegateOnPredicate:isButtonIndex(buttonIndex) alertViewBlock:alertViewBlock];
}

+(VLBAlertViewDelegate *)newAlertViewDelegateOnOk:(VLBAlertViewBlock)alertViewBlock{
    return [self newAlertViewDelegateOnPredicate:isButtonIndexOk() alertViewBlock:alertViewBlock];
}

+(VLBAlertViewDelegate *)newAlertViewDelegateOnCancel:(VLBAlertViewBlock)alertViewBlock {
    return [self newAlertViewDelegateOnPredicate:isButtonIndexCancel() alertViewBlock:alertViewBlock];
}

+(VLBAlertViewDelegate *)newAlertViewDelegateDismissOn:(VLBButtonIndex)buttonIndex
{
    __block VLBAlertViewDelegate *alertViewDelegate;
    alertViewDelegate = [VLBAlertViewDelegate newAlertViewDelegateOnPredicate:isButtonIndex(buttonIndex) alertViewBlock:^(UIAlertView* alertView, NSInteger buttonIndex){
        alertViewDelegate = nil;
    }];
    
    return alertViewDelegate;
}

+(VLBAlertViewDelegate *)newAlertViewDelegateOnOkDismiss {
    return [self newAlertViewDelegateDismissOn:BUTTON_INDEX_OK];
}

+(VLBAlertViewDelegate *)newAlertViewDelegateOnCancelDismiss {
    return [self newAlertViewDelegateDismissOn:BUTTON_INDEX_CANCEL];
}

+(NSObject<UIAlertViewDelegate>*)all:(NSArray*)alertViewDelegates
{
    __block NSObject<UIAlertViewDelegate>* all = [VLBAlertViewDelegate newAlertViewDelegateOnPredicate:[NSPredicate predicateWithValue:YES] alertViewBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        for (NSObject<UIAlertViewDelegate> *alertViewDelegate in alertViewDelegates) {
            [alertViewDelegate alertView:alertView clickedButtonAtIndex:buttonIndex];
        }
        all = nil;
    }];
    
    return all;
}

+ (UIAlertView *)newAlertViewWithOk:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    
    return alertView;
}

+ (UIAlertView *)newAlertViewWithOkAndCancel:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:@"Cancel", nil];
    
    return alertView;
}

@end
