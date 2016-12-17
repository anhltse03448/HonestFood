//
//  FacebookAPI.h
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookAPI : NSObject
-(void)shareFood:(Food*)food On:(UIViewController *)view ;
-(void)inviteFriends:(UIViewController *)viewController;
+ (id)sharedManager ;
@end
