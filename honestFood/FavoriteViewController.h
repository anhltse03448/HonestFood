//
//  FavoriteViewController.h
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Delegate.m"
@import FBSDKCoreKit ;
@import FBSDKShareKit ;

@interface FavoriteViewController : BaseController<UITableViewDataSource,UITableViewDelegate, SomethingDelegate,FBSDKAppInviteDialogDelegate>

@end
