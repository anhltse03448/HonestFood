//
//  Utils.h
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Charts ;
@interface Utils : NSObject

+(NSString*)stringDateFormatFrom:(NSNumber*)longDate;
+(NSString*)totalPriceWithListFood:(NSMutableArray<Food*>*)foodList;
+(void)showChartWiewWithChart:(UIView*)chart;
+ (void)setupPieChartView:(PieChartView *)chartView;
+(UIView*)chartViewWithFoodList:(NSMutableArray *)foodList AndFrame : (CGRect)frame ;
@end
