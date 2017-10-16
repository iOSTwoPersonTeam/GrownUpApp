//
//  TDGroupTableViewCell.m
//  成长之路APP
//
//  Created by mac on 2017/10/16.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDGroupTableViewCell.h"

@implementation TDGroupTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessibilityIdentifier = @"table_cell";

        self.textLabel.accessibilityIdentifier = @"textLabel";
        self.textLabel.backgroundColor = [UIColor clearColor];

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [super awakeFromNib];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10, 8, 34, 34);
    CGRect rect = self.textLabel.frame;
    rect.origin.x = CGRectGetMaxX(self.imageView.frame) + 10;
    self.textLabel.frame = rect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setUsername:(NSString *)username
{
    _username = username;
    [self.textLabel setText:_username];
    [self.imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"EaseUIResource.bundle/group"]];
}


@end

