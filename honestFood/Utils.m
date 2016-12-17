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

@end
