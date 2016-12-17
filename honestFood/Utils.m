//
//  Utils.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+(NSString*)stringDateFormatFrom:(NSNumber*)longDate;
{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[longDate longValue]];
    return [NSString stringWithFormat:@"%d Tháng %d",[date day],[date month]];
 }

+(NSString*)totalPriceWithListFood:(NSMutableArray<Food*>*)foodList;
{
    double price = 0;
    for (Food *food in foodList) {
        price += [food.quantity integerValue] * [[food price] doubleValue];
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *result = [numberFormatter stringFromNumber:@(price)];
    return result;
    
}

@end
