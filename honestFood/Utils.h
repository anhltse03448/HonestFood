//
//  Utils.h
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(NSString*)stringDateFormatFrom:(NSNumber*)longDate;
+(NSString*)totalPriceWithListFood:(NSMutableArray<Food*>*)foodList;

@end
