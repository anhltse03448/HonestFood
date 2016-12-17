//
//  FoodCategory.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "FoodCategory.h"

@implementation FoodCategory

+(id)foodCategoryWithDictionary:(NSDictionary*)dict
{
    FoodCategory *foodCategory = [FoodCategory new];
    if (foodCategory) {
        
        foodCategory.foodCategoryId = dict[@"foodCategoryId"];
        foodCategory.foodCategoryName  = dict[@"foodCategoryName"];
        foodCategory.note = dict[@"note"];
        foodCategory.imgUrl = dict[@"imgUrl"];
        
    }
    
    return foodCategory;
    
}


@end
