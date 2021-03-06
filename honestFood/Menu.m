//
//  Menu.m
//  Amazing
//
//  Created by Tuan Vu on 11/30/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "Menu.h"
#import "FavoriteViewController.h"
#import "ProfileViewController.h"
@implementation Menu

+(Menu*)menuWithTitle:(NSString*)title icon:(UIImage*)icon navi:(UINavigationController*)navi
{
    Menu *menu = [Menu new];
    if (menu) {
        
        menu.title = title;
        menu.icon = icon;
        menu.navi = navi;
    }
    
    return menu;
    
}


+(void)settingSlideMenuController
{
    MenuController *menu = [[MenuController alloc]initWithNibName:@"MenuController" bundle:nil];
    
    MMDrawerController *slideMenu = [[MMDrawerController alloc]initWithCenterViewController:[self naviGallery] leftDrawerViewController:menu];
    
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [slideMenu setMaximumLeftDrawerWidth:mainWindow.frame.size.width*0.3f];
        
    }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        [slideMenu setMaximumLeftDrawerWidth:mainWindow.frame.size.width*0.8f];
    }
    
    [UIView transitionWithView:mainWindow
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [mainWindow setRootViewController:slideMenu];
                        [mainWindow makeKeyAndVisible];
                        mainWindow.backgroundColor = kNavigationBarColor;
                    }
                    completion:nil];
    
    

}

+(NavigationController*)naviGallery
{
    GalleryController *gallery = [[GalleryController alloc]initWithNibName:@"GalleryController" bundle:nil];
    NavigationController *navigationGallery = [[NavigationController alloc]initWithRootViewController:gallery];
    return navigationGallery;
}

+(NavigationController*)naviCart
{
    CartController *cart = [[CartController alloc]initWithFoodList:[[GlobalVar getInstance] foodList] andType:CartControllerTypeNew];
    NavigationController *naviCart = [[NavigationController alloc]initWithRootViewController:cart];
    return naviCart;
}

+(NavigationController*)naviHistory
{
    HistoryController *history = [[HistoryController alloc] initWithNibName:@"HistoryController" bundle:nil];
    NavigationController *naviHistory = [[NavigationController alloc]initWithRootViewController:history];
    return naviHistory;
}

+(NavigationController*)naviFav
{
    FavoriteViewController *favorite = [[FavoriteViewController alloc] initWithNibName:@"FavoriteViewController" bundle:nil];
    NavigationController *naviHistory = [[NavigationController alloc]initWithRootViewController:favorite];
    return naviHistory;
}

+(NavigationController*)navProfile
{
    ProfileViewController *profile = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    NavigationController *naviHistory = [[NavigationController alloc]initWithRootViewController:profile];
    return naviHistory;
}

+(NSArray*)segment
{
    NSArray *array = @[@"Tươi Sống",@"Đóng Hộp ",@"Chế Biến Sẵn",@"Đồ Uống"];
    return array;
}



@end
