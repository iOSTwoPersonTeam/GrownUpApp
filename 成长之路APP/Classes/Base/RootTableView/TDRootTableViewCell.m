//
//  TDRootTableViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRootTableViewCell.h"

@implementation TDRootTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    return self;
}


-(void)setObject:(NSObject *)object
{
    
    
    
}



@end
