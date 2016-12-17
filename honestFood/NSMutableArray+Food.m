//
//  NSMutableArray+Food.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "NSMutableArray+Food.h"

@implementation NSMutableArray (Food)

-(Food*)containsFood:(Food*)food;
{
    Food* returnFood = nil;
    for (int i = 0; i < self.count; i++) {
        
        Food *myfood = [self objectAtIndex:i];
        if ([myfood isEqualOtherFood:food]) {
            
            returnFood = myfood;
        }
    }
    return returnFood;
}

@end
