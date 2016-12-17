//
//  Food.h
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Nutrition : NSObject

@property (nonatomic , strong) NSNumber *protein;
@property (nonatomic , strong) NSNumber *fat;
@property (nonatomic , strong) NSNumber *carbohydrate;

-(id)initWithDictionary:(NSDictionary*)dict;


@end


@interface Food : NSObject

@property (nonatomic , strong) NSNumber * foodId;
@property (nonatomic , strong) NSString * foodName;
@property (nonatomic , strong) NSString * describe;
@property (nonatomic , strong) NSString * note;
@property (nonatomic , strong) NSNumber * price;
@property (nonatomic , strong) NSNumber * quantity;


@property (nonatomic , strong) NSString * imgUrl;


-(BOOL)isEqualOtherFood:(Food*)otherFood;
-(id)initWithDictionary:(NSDictionary*)dict;
@end
