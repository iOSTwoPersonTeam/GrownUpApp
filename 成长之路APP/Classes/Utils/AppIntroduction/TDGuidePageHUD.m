//
//  TDGuidePageHUD.m
//  成长之路APP
//
//  Created by mac on 2017/8/22.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDGuidePageHUD.h"

@implementation TDGuidePageHUD

- (void)removeGuidePageHUD {
    [self removeFromSuperview];
    
    if (self.startButtonBlock) {
        
        self.startButtonBlock();
    }
    
}

@end
