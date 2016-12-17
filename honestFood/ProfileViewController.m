//
//  ProfileViewController.m
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "ProfileViewController.h"
@import Charts ;
@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initChart;
{
    self.lineChartView.rightAxis.enabled = true ;
    self.lineChartView.rightAxis.gridColor = [UIColor grayColor];
    self.lineChartView.rightAxis.gridLineDashLengths  = @[@3 , @0.2 , @0.1];
    self.lineChartView.rightAxis.labelTextColor = [UIColor grayColor];
    
    self.lineChartView.xAxis.drawGridLinesEnabled = true;
    self.lineChartView.xAxis.gridLineDashLengths = @[@3 , @0.2 , @0.1];
    self.lineChartView.xAxis.drawAxisLineEnabled = true ;
    self.lineChartView.xAxis.labelPosition = XAxisLabelPositionBottom ;
    self.lineChartView.descriptionText = @"" ;
}

@end
