//
//  TDGroupTableViewCell.h
//  成长之路APP
//
//  Created by mac on 2017/10/16.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTableCellDelegate;
@interface TDGroupTableViewCell : UITableViewCell
{
    UILongPressGestureRecognizer *_headerLongPress;
}

@property (weak, nonatomic) id<BaseTableCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) NSString *username;

@end

@protocol TDGroupTableViewCell <NSObject>

- (void)cellImageViewLongPressAtIndexPath:(NSIndexPath *)indexPath;

@end
