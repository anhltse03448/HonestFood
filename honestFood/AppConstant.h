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



#define kAPIBaseUrl                         @"http://192.168.43.42:8080/"
#define kAPIGetListFoodCat                  @"getlistfoodcat"
#define kAPIGetListFood                     @"getlistfood"
#define kAPIGetHistoryOrder                 @"gethistoryorder"



#define kNotifyAddFoodToCartName                @"FoodAddedToCart"
#define kNotifyCarbonKitWillBeginTransition     @"CarbonKitWillBeginTransition"
#define kNotifyCarbonKitDidFinishTransition    @"CarbonKitWillBeginTransition"



#define kAppColor                           [UIColor hx_colorWithHexRGBAString:@"#75d92f"]
#define kNavigationBarColor                 [UIColor hx_colorWithHexRGBAString:@"#0e0d0e"]
#define kGalleryTabExtraWidth               15.0f
#define kGallerySegmentWidth                kscreenWidth/3.0f




#endif /* AppConstant_h */
