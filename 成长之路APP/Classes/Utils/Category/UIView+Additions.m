//
//  UIView+Additions.m
//  成长之路APP
//
//  Created by mac on 2017/9/7.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "UIView+Additions.h"
static char TActionHandlerTapBlockKey;
static char TActionHandlerTapGestureKey;
static char TActionHandlerLongPressBlockKey;
static char TActionHandlerLongPressGestureKey;


@implementation UIView (Additions)

#pragma mark ---添加tap手势 轻拍手势
- (void)addGesture_TapActionWithBlock:(GestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &TActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jk_handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &TActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &TActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)jk_handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = objc_getAssociatedObject(self, &TActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}

#pragma mark ---添加Press手势 添加长按手势
- (void)addGesture_LongPressActionWithBlock:(GestureActionBlock)block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &TActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(jk_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &TActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &TActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)jk_handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        GestureActionBlock block = objc_getAssociatedObject(self, &TActionHandlerLongPressBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}


@end
