//
//  Menu.h
//  Amazing
//
//  Created by Tuan Vu on 11/30/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuController.h"
#import "NavigationController.h"


@interface Menu : NSObject


@property (copy , nonatomic) NSString *title;
@property (strong , nonatomic) UIImage *icon;
@property (strong ,nonatomic) UINavigationController *navi;

+(void)settingSlideMenuController;
+(NSArray*)segment;
+(NavigationController*)naviGallery;
+(Menu*)menuWithTitle:(NSString*)title icon:(UIImage*)icon navi:(UINavigationController*)navi;
+(NavigationController*)naviCart;
+(NavigationController*)naviHistory;
+(NavigationController*)naviFav ;
+(NavigationController*)navProfile;

@end
