//
//  TDPaymentTableViewCell.h
//  成长之路APP
//
//  Created by mac on 2017/9/18.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootTableViewCell.h"

@interface TDPaymentTableViewCell : TDRootTableViewCell

@property(nonatomic,nonnull,strong)UIImageView *selectImageView; //选择图片

- (void)setTitle:(nonnull NSString*)title
   withImageShow:(nonnull NSString*)icon;

@end



