//
//  CartController.h
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/16/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,CartControllerType) {
    
    CartControllerTypeNew = 0,
    CartControllerTypeHistory
    
};

@interface CartController : UIViewController

-(id)initWithFoodList:(NSMutableArray*)otherFoodList andType:(CartControllerType)type;

@end
