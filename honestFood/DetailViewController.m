//
//  DetailViewController.m
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView *btnBack;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:true];
    _btnBack.userInteractionEnabled = true;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_btnBack addGestureRecognizer:gesture];
    [_lblTitle setText:_food.foodName];
    NSString *price = [[NSString alloc]initWithFormat:@"%.0f", _food.price.doubleValue];
    [_lblPrice setText:price];
    [self initChart];
}

-(void)tap:(UITapGestureRecognizer *)gesture ;
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initChart ;
{
    
    
    
    self.barChartView.xAxis.drawLabelsEnabled = false ;
    self.barChartView.leftAxis.drawGridLinesEnabled = false ;
    self.barChartView.leftAxis.drawLabelsEnabled = false ;
    self.barChartView.leftAxis.drawAxisLineEnabled = false;
    
    self.barChartView.rightAxis.enabled = true ;
    self.barChartView.rightAxis.gridColor = [UIColor grayColor];
    self.barChartView.rightAxis.gridLineDashLengths  = @[@3 , @0.2 , @0.1];
    self.barChartView.rightAxis.labelTextColor = [UIColor grayColor];
    
    self.barChartView.xAxis.drawGridLinesEnabled = true;
    self.barChartView.xAxis.gridLineDashLengths = @[@3 , @0.2 , @0.1];
    self.barChartView.xAxis.drawAxisLineEnabled = true ;
    self.barChartView.xAxis.labelPosition = XAxisLabelPositionBottom ;
    self.barChartView.descriptionText = @"" ;
    
    
    
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    [yVals addObject:[[BarChartDataEntry alloc] initWithX:(double)0 y:_food.nutrition.fat.doubleValue]];
    
    
    BarChartDataSet *set1 = nil;
    
    set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"Fat"];
    [set1 setColors:ChartColorTemplates.material];
    set1.axisDependency = AxisDependencyRight ;
    
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    [yVals2 addObject:[[BarChartDataEntry alloc] initWithX:(double)1 y:_food.nutrition.protein.integerValue]];
    
    BarChartDataSet *set2 = nil;
    
    set2 = [[BarChartDataSet alloc] initWithValues:yVals2 label:@"Protein"];
    [set2 setColors:ChartColorTemplates.material];
    set2.axisDependency = AxisDependencyRight ;
    
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    [yVals3 addObject:[[BarChartDataEntry alloc] initWithX:(double)2 y:_food.nutrition.carbohydrate.integerValue]];
    
    BarChartDataSet *set3 = nil;
    
    set3 = [[BarChartDataSet alloc] initWithValues:yVals3 label:@"Carbonhydrate"];
    [set3 setColors:ChartColorTemplates.material];
    set3.axisDependency = AxisDependencyRight ;
    
    
    
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
    
    data.barWidth = 0.3f;
    self.barChartView.data = data ;
}



@end
