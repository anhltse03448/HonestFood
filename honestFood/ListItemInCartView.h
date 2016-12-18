//
//  ListItemInCartView.h
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^listItemIncartMoveToWindow)();
typedef  void (^btnBuyDidTap)();


@interface ListItemInCartView : UIView

@property listItemIncartMoveToWindow moveToWindow;
@property btnBuyDidTap buttonBuyDidTap;
@property UIViewController * ownerController;


+ (instancetype)sharedInstance;

@end
