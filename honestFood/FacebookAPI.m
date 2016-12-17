//
//  FacebookAPI.m
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "FacebookAPI.h"
@import FBSDKShareKit ;


@implementation FacebookAPI
-(void)shareFood:(Food*)food On:(UIViewController *)view ;
{
        UIImageView *imageView = [[UIImageView alloc]init];
        NSString *url = food.imgUrl ;
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                     placeholderImage:nil];
    
        UIImage *image = imageView.image ;
    
        FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
        photo.image = image;
        photo.userGenerated = YES;
        photo.caption = @"Test Caption" ;
    
    
        FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
        content.photos = @[photo];
    
        FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
        dialog.fromViewController = view;
        dialog.shareContent = content ;
        dialog.mode = FBSDKShareDialogModeShareSheet;
        [dialog show];
}

+ (id)sharedManager {
    static FacebookAPI *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
@end
