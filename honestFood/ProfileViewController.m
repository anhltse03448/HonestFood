//
//  ProfileViewController.m
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProjectObject.h"
@import Charts ;
@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;
@property (nonatomic,strong) NSMutableArray *dataList;
@property (weak, nonatomic) IBOutlet UIButton *btnProtein;
@property (weak, nonatomic) IBOutlet UIButton *btnCar;

@property (weak, nonatomic) IBOutlet UIButton *btnFat;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataList = [[NSMutableArray alloc]init];
    [self initChart];
    [self loadData];
    
}

-(void)loadData;
{
    [API getWithUrl:@"getnutritioninweek" param:@{@"ownerid" : @"98"} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        for (NSDictionary *dict in responseObject) {
            ProjectObject *obj = [[ProjectObject alloc]initWithDictionary:dict];
            [_dataList addObject:obj];
        }
        [self performSelector:@selector(btnTouchUp:) withObject:self.btnFat afterDelay:0];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error) ;
    } ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnTouchUp:(id)sender {
    UIButton *but = (UIButton *) sender ;
    NSMutableArray *xVals = [[NSMutableArray alloc]init];
    NSMutableArray *data = [[NSMutableArray alloc]init];
    
    if (but == self.btnFat) {
        [self.btnFat setBackgroundImage:[UIImage imageNamed:@"Choose"] forState:UIControlStateNormal];
        [self.btnProtein setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        [self.btnCar setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        for (ProjectObject *obj in _dataList) {
            [xVals addObject:obj.date];
            [data addObject:@(obj.fat.doubleValue)];
        }
    } else if (but == self.btnCar) {
        [self.btnFat setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        [self.btnProtein setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        [self.btnCar setBackgroundImage:[UIImage imageNamed:@"Choose"] forState:UIControlStateNormal];
        for (ProjectObject *obj in _dataList) {
            [xVals addObject:obj.date];
            [data addObject:@(obj.carbohydrate.doubleValue)];
        }
    } else if (but == self.btnProtein) {
        [self.btnFat setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        [self.btnProtein setBackgroundImage:[UIImage imageNamed:@"Choose"] forState:UIControlStateNormal];
        [self.btnCar setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        for (ProjectObject *obj in _dataList) {
            [xVals addObject:obj.date];
            [data addObject:@(obj.protein.doubleValue)];
        }
    }
    self.lineChartView.data = [self generateLineStockChartDatax:xVals :data];
    self.lineChartView.notifyDataSetChanged ;
}

- (void)initChart;
{
    self.lineChartView.rightAxis.enabled = true ;
    self.lineChartView.rightAxis.gridColor = [UIColor grayColor];
    self.lineChartView.rightAxis.gridLineDashLengths  = @[@3 , @0.2 , @0.1];
    self.lineChartView.rightAxis.labelTextColor = [UIColor grayColor];
    self.lineChartView.leftAxis.enabled = false;
    self.lineChartView.leftAxis.drawLabelsEnabled = false ;
    
    self.lineChartView.xAxis.drawGridLinesEnabled = true;
    self.lineChartView.xAxis.gridLineDashLengths = @[@3 , @0.2 , @0.1];
    self.lineChartView.xAxis.drawAxisLineEnabled = true ;
    self.lineChartView.xAxis.labelPosition = XAxisLabelPositionBottom ;
    self.lineChartView.xAxis.drawLabelsEnabled = false ;
    
    self.lineChartView.descriptionText = @"" ;
    self.lineChartView.userInteractionEnabled = false ;
    self.lineChartView.legend.enabled = false;
    
}
-(LineChartData *)generateLineStockChartDatax:(NSMutableArray *)xValsWithObject:(NSMutableArray *)objs;
{
    LineChartData *d = [[LineChartData alloc]init];
    NSMutableArray *lineVals = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < objs.count; i ++) {
        NSNumber *obj = objs[i] ;
        ChartDataEntry *entry = [[ChartDataEntry alloc]initWithX:i y:obj.doubleValue];
        [lineVals addObject:entry];
    }
    
    
    LineChartDataSet *lineChartDataSet = [[LineChartDataSet alloc]initWithValues:lineVals];
    lineChartDataSet.axisDependency = AxisDependencyRight ;
    lineChartDataSet.lineWidth = 1.0 ;
    lineChartDataSet.mode = LineChartModeCubicBezier ;
    
    lineChartDataSet.drawValuesEnabled = false ;
    lineChartDataSet.drawCirclesEnabled = false ;
    lineChartDataSet.drawFilledEnabled = true ;
    
    lineChartDataSet.axisDependency = AxisDependencyRight ;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat gradientLocations[] = {1.0, 0};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)[UIColor hx_colorWithHexRGBAString:@"#2dcc70"].CGColor, (id)UIColor.clearColor.CGColor], gradientLocations);
    lineChartDataSet.fill = [[ChartFill alloc]initWithLinearGradient:gradient angle:90.0];
    lineChartDataSet.drawFilledEnabled = true;
    
    [d addDataSet:lineChartDataSet];
    return  d ;
}


@end
