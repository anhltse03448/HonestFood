//
//  ProjectObject.m
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "ProjectObject.h"

@implementation ProjectObject
-(id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        _date = dict[@"createdTime"];
        self.fat = dict[@"totalFat"];
        self.protein = dict[@"totalProtein"];
        self.carbohydrate = dict[@"totalCab"];
    }    
    return self;
    
}

@end
