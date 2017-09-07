//
//  TDSettingsTableViewCell.h
//  成长之路APP
//
//  Created by mac on 2017/8/16.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootTableViewCell.h"

@interface TDSettingsTableViewCell : TDRootTableViewCell

- (void)getDataWithTitle:(nonnull NSString*)title WithDetailText:(NSString *_Nullable)detailText WithIndexPath:(NSInteger )index;

@end
