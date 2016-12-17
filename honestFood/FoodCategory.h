//
//  FoodCategory.h
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodCategory : NSObject

@property (nonatomic,copy) NSString *foodCategoryId;
@property (nonatomic,copy) NSString *foodCategoryName;
@property (nonatomic,copy) NSString *note;
@property (nonatomic,copy) NSString *imgUrl;


+(id)foodCategoryWithDictionary:(NSDictionary*)dict;
@end
