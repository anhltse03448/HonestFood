//
//  FoodCategoryController.h
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger ,FoodCategoryControllerType ) {
    
    FoodCategoryControllerTypeFreshFood = 0,
    FoodCategoryControllerTypeCannedFood,
    FoodCategoryControllerTypeServedFood,
    FoodCategoryControllerTypeDrinks
    
};

@interface FoodCategoryController : BaseCollectionController

-(id)initWithCategoryID:(NSString*)categoryId andType:(FoodCategoryControllerType)type;

@end
