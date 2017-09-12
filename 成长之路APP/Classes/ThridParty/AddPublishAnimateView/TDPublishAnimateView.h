//
//  TDPublishAnimateView.h
//  成长之路APP
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TDPublishAnimateViewDeleagte <NSObject>

-(void)addAnimateViewButton:(UIButton *)button andIndex:(NSInteger )index;

@end


@interface TDPublishAnimateView : UIView

@property(nonatomic,copy) void(^completion)();
/*
 * 默认每行3个
 */
@property(nonatomic, assign)int columnCount;
@property(nonatomic, strong)NSArray *textArray;
@property(nonatomic, strong)NSArray<NSString *> *imageNameArray;
@property(nonatomic, weak)id<TDPublishAnimateViewDeleagte>delegate;

-(void)show;
-(void)close:(void(^)())completion;

@end
