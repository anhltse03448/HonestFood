//
//  Food.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "Food.h"


@implementation Nutrition


-(id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        
        _protein = dict[@"protein"];
        _carbohydrate = dict[@"carbohydrate"];
        _protein = dict[@"protein"];
        
    }
    
    return self;
    
}



@end


@implementation Food


-(id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        
        _foodId = dict[@"foodId"];
        _note = dict[@"note"];
        _describe = dict[@"describe"];
        _foodName = dict[@"foodName"];
        _imgUrl = dict[@"imgUrl"];
        
    }
    
    return self;
    
}

-(BOOL)isEqualOtherFood:(Food*)otherFood;
{
    if ([self.foodId integerValue] == [otherFood.foodId integerValue]) {
        
        return YES;
        
    }else
    {
        return NO;
    }
}



@end
