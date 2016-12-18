//
//  AppDelegate.m
//  honestFood
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#ifndef AppConstant_h
#define AppConstant_h


#define kscreenRect [[UIScreen mainScreen] bounds]
#define kscreenWidth kscreenRect.size.width
#define kscreenHeight kscreenRect.size.height



#define kAPIBaseUrl                         @"http://112.213.94.177:8080/honestfood/"
#define kAPIGetListFoodCat                  @"getlistfoodcat"
#define kAPIGetListFood                     @"getlistfood"
#define kAPIGetHistoryOrder                 @"gethistoryorder"
#define kAPIFoodActionFavorite               @"changestatusoffavoritefood"
#define kApiLogin                           @"loginfb"


#define kNotifyAddFoodToCartName                @"FoodAddedToCart"
#define kNotifyAddFoodIncreaseCount                  @"FoodIncreaseCount"
#define kNotifyCarbonKitWillBeginTransition     @"CarbonKitWillBeginTransition"
#define kNotifyCarbonKitDidFinishTransition    @"CarbonKitDidFinishTransition"



#define kUserDeffaultKeyUserInfo                @"UserInfo"
#define kUserDefaultUserID                      @"UserID"
#define kAppColor                           [UIColor hx_colorWithHexRGBAString:@"#75d92f"]
#define kNavigationBarColor                 [UIColor hx_colorWithHexRGBAString:@"#0e0d0e"]
#define kGalleryTabExtraWidth               15.0f
#define kGallerySegmentWidth                kscreenWidth/3.0f




#endif /* AppConstant_h */
