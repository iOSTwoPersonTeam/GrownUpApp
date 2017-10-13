//
//  TDEaseChatViewController.h
//  成长之路APP
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <EaseUI/EaseUI.h>

@interface TDEaseChatViewController : EaseMessageViewController<EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource>

- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType;


@end
