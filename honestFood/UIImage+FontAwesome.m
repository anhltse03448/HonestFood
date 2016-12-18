//
//  UIImage+FontAwesome.m
//  AppBliss
//
//  Created by Tuan Vu on 11/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "UIImage+FontAwesome.h"

@implementation UIImage (FontAwesome)

+(UIImage*)backImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome arrowLeftIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}


+(UIImage*)nextImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome chevronRightIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

+(UIImage*)listUIImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome listUlIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

+(UIImage*)barImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome barsIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
    
}

+(UIImage*)camaraImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome cameraRetroIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
    
}
+(UIImage*)gearImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome cogIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
    
}
+(UIImage*)galleryImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome pictureOIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
    
}

//+(UIImage*)fbImage;
//{
//    FAKFontAwesome* icon = [FAKFontAwesome facebookSquareIconWithSize:25.0f];
//    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    return image;
//    
//}

+(UIImage*)magicImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome magicIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
    
}

+(UIImage*)plusImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome plusIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
    
}

+(UIImage*)editTextImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome textHeightIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

+(UIImage*)gridImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome thLargeIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

+(UIImage*)shareImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome shareSquareIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}
+(UIImage*)slideImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome slidersIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

+(UIImage*)moreImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome ellipsisHIconWithSize:25.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

+(UIImage*)searchImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome searchIconWithSize:20.0f];
    UIImage* image = [[icon imageWithSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

+(UIImage*)barChartImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome barChartIconWithSize:20];
    UIImage* image = [[icon imageWithSize:CGSizeMake(25, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}


+(UIImage*)menuImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome compassIconWithSize:20];
    UIImage* image = [[icon imageWithSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}
+(UIImage*)cartImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome shoppingCartIconWithSize:20];
    UIImage* image = [[icon imageWithSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}
+(UIImage*)historyImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome historyIconWithSize:20];
    UIImage* image = [[icon imageWithSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}
+(UIImage*)favoriteImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome thumbsUpIconWithSize:20];
    UIImage* image = [[icon imageWithSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}
+(UIImage*)profileImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome gearIconWithSize:20];
    UIImage* image = [[icon imageWithSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

+(UIImage*)locationImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome locationArrowIconWithSize:20];
    UIImage* image = [[icon imageWithSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

+(UIImage*)xImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome timesIconWithSize:20];
    UIImage* image = [[icon imageWithSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

+(UIImage*)fbImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome facebookIconWithSize:20];
    UIImage* image = [[icon imageWithSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}
+(UIImage*)heartImage;
{
    FAKFontAwesome* icon = [FAKFontAwesome heartIconWithSize:20];
    UIImage* image = [[icon imageWithSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}




@end
