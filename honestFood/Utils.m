//
//  Utils.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "Utils.h"
@import Charts ;

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


+(double)totalPayWithListFood:(NSMutableArray *)foodList;
{
    double price = 0;
    for (Food *food in foodList) {
        price += [food.quantity integerValue] * [[food price] doubleValue];
    }
    return price;
}
+(void)showChartWiewWithChart:(UIView*)chart;
{
    KLCPopup* popup =  [KLCPopup popupWithContentView:chart showType:KLCPopupShowTypeFadeIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    popup.showType = KLCPopupShowTypeSlideInFromBottom;
//    [popup showWithLayout:KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,KLCPopupVerticalLayoutBottom)];

    [popup show];
}

+(UIView*)chartViewWithFoodList:(NSMutableArray *)foodList AndFrame : (CGRect)frame ;
{
    PieChartView *pieChart = [[PieChartView alloc]initWithFrame:frame];
    [self setupPieChartView:pieChart];
    double fat = 0 ;
    double cab = 0 ;
    double protein = 0 ;
    
    for (Food *food in foodList) {
        fat += food.nutrition.fat.doubleValue;
        cab += food.nutrition.carbohydrate.doubleValue;
        protein += food.nutrition.protein.doubleValue ;
    }
    [self setDataCount:fat andCab:cab andProtein:protein andChart:pieChart];
    return pieChart ;
}
+ (void)setupPieChartView:(PieChartView *)chartView;
{
    chartView.usePercentValuesEnabled = YES;
    
    chartView.drawSlicesUnderHoleEnabled = NO;
    chartView.holeRadiusPercent = 0.58;
    chartView.transparentCircleRadiusPercent = 0.61;
    chartView.chartDescription.enabled = NO;
    [chartView setExtraOffsetsWithLeft:5.f top:10.f right:5.f bottom:5.f];
    
    chartView.drawCenterTextEnabled = YES;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@""];
    
    
    chartView.centerAttributedText = centerText;
    
    chartView.drawHoleEnabled = NO;
    chartView.rotationAngle = 0.0;
    chartView.rotationEnabled = YES;
    chartView.highlightPerTapEnabled = YES;
    
    ChartLegend *l = chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 0.0;
    l.yOffset = 0.0;
}

+ (void)setDataCount:(double)fat andCab:(double)cab andProtein:(double)protein andChart:(PieChartView *)pieChart;
{
    
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    [values addObject:[[PieChartDataEntry alloc] initWithValue:fat label:@"Fat"]];
    [values addObject:[[PieChartDataEntry alloc] initWithValue:cab label:@"Cab"]];
    [values addObject:[[PieChartDataEntry alloc] initWithValue:protein label:@"Protein"]];
    
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@""];
    dataSet.sliceSpace = 2.0;
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    UIColor *color1 = [UIColor hx_colorWithHexRGBAString:@"#90EBFE"];
    UIColor *color2 = [UIColor hx_colorWithHexRGBAString:@"#C6FD92"];
    UIColor *color3 = [UIColor hx_colorWithHexRGBAString:@"#FED191"];
    [colors addObject:color1];
    [colors addObject:color2];
    [colors addObject:color3];
    
    
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 0;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"Montserrat-Bold" size:13.f]];
    [data setValueTextColor:UIColor.blackColor];
    pieChart.data = data;
    [pieChart highlightValue:nil];
}

@end
