//
//  TDSearchResultView.h
//  成长之路APP
//
//  Created by mac on 2017/8/25.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDSearchResultView : UIView

@property(nonatomic ,copy) void(^resultIndexPathBlock)(BMKPoiInfo *info);

-(void)getDataWithInfo:(NSMutableArray <BMKPoiInfo *> *)suggestionSearchArr;


@end
