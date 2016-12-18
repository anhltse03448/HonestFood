//
//  ProfileViewController.m
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProjectObject.h"
#import "FacebookAPI.h"
@import FBSDKShareKit ;
@import Charts ;
@interface ProfileViewController () <FBSDKSharingDelegate, FBSDKAppInviteDialogDelegate>
@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;
@property (nonatomic,strong) NSMutableArray *dataList;
@property (weak, nonatomic) IBOutlet UIButton *btnProtein;
@property (weak, nonatomic) IBOutlet UIButton *btnCar;

@property (weak, nonatomic) IBOutlet UIButton *btnFat;

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Biểu đồ"];
    _dataList = [[NSMutableArray alloc]init];
    [self initChart];
//    [self loadData];
    
    _lblUserName.text = [NSString stringWithFormat:@"%@ %@",[[globarVar user] firstName] , [[globarVar user] lastName]];
    [_userAvatar sd_setImageWithURL:[NSURL URLWithString:[[globarVar user] imgUrl] ] placeholderImage:nil];
    _userAvatar.layer.cornerRadius = _userAvatar.frame.size.height/2;
    _userAvatar.layer.masksToBounds = YES;
    [self performSelector:@selector(btnTouchUp:) withObject:self.btnFat afterDelay:0];
    
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData:0];
}

-(void)loadData:(int)typeChart;
{
    [_dataList removeAllObjects];
    NSMutableArray *xVals = [[NSMutableArray alloc]init];
    NSMutableArray *data = [[NSMutableArray alloc]init];
    if (typeChart == 0 ) {
        [API getWithUrl:@"getnutritioninweek" param:@{@"ownerid" : [globarVar userId]} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            for (NSDictionary *dict in responseObject) {
                ProjectObject *obj = [[ProjectObject alloc]initWithDictionary:dict];
                [xVals addObject:obj.date];
                [data addObject:@(obj.fat.doubleValue)];
//                [_dataList addObject:obj];
            }
            self.lineChartView.data = [self generateLineStockChartDatax:xVals :data];
            [self.lineChartView notifyDataSetChanged];
            //[self performSelector:@selector(btnTouchUp:) withObject:self.btnFat afterDelay:0];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error) ;
        } ];
    } else if (typeChart == 1 ) {
        [API getWithUrl:@"getnutritioninmonth" param:@{@"ownerid" : [globarVar userId]} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            for (NSDictionary *dict in responseObject) {
                ProjectObject *obj = [[ProjectObject alloc]initWithDictionary:dict];
                [xVals addObject:obj.date];
                [data addObject:@(obj.fat.doubleValue)];
//                [_dataList addObject:obj];
            }
            self.lineChartView.data = [self generateLineStockChartDatax:xVals :data];
            [self.lineChartView notifyDataSetChanged];
            //[self performSelector:@selector(btnTouchUp:) withObject:self.btnFat afterDelay:0];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error) ;
        } ];
    } else {
        [API getWithUrl:@"getnutritioninyear" param:@{@"ownerid" : [globarVar userId]} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            for (NSDictionary *dict in responseObject) {
                ProjectObject *obj = [[ProjectObject alloc]initWithDictionary:dict];
                [xVals addObject:obj.date];
                [data addObject:@(obj.fat.doubleValue)];
                //[_dataList addObject:obj];
            }
            self.lineChartView.data = [self generateLineStockChartDatax:xVals :data];
            [self.lineChartView notifyDataSetChanged];
            //[self performSelector:@selector(btnTouchUp:) withObject:self.btnFat afterDelay:0];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error) ;
        } ];
    }
    

}

-(void)settingRightMenuBars
{
    
    UIBarButtonItem* rightDrawerButton = [[UIBarButtonItem alloc]initWithImage:[UIImage shareImage] style:UIBarButtonItemStyleDone target:self action:@selector(invite)];
    
    
    rightDrawerButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[rightDrawerButton];
}
- (void)invite;
{
    [[FacebookAPI sharedManager]inviteFriends:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnTouchUp:(id)sender {
    UIButton *but = (UIButton *) sender ;
    
    
    if (but == self.btnFat) {
        [self.btnFat setBackgroundImage:[UIImage imageNamed:@"Choose"] forState:UIControlStateNormal];
        [self.btnProtein setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        [self.btnCar setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        [self loadData:0];
        
    } else if (but == self.btnCar) {
        [self loadData:2];
        [self.btnFat setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        [self.btnProtein setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        [self.btnCar setBackgroundImage:[UIImage imageNamed:@"Choose"] forState:UIControlStateNormal];
        
    } else if (but == self.btnProtein) {
        [self loadData:1];
        [self.btnFat setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        [self.btnProtein setBackgroundImage:[UIImage imageNamed:@"Choose"] forState:UIControlStateNormal];
        [self.btnCar setBackgroundImage:[UIImage imageNamed:@"notChoose"] forState:UIControlStateNormal];
        
    }
    
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

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results;
{
    
}

/**
 Sent to the delegate when the sharer encounters an error.
 - Parameter sharer: The FBSDKSharing that completed.
 - Parameter error: The error.
 */
- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error;
{
    
}

/**
 Sent to the delegate when the sharer is cancelled.
 - Parameter sharer: The FBSDKSharing that completed.
 */
- (void)sharerDidCancel:(id<FBSDKSharing>)sharer;
{
    
}

- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results;
{
    
}
/**
 Sent to the delegate when the app invite encounters an error.
 - Parameter appInviteDialog: The FBSDKAppInviteDialog that completed.
 - Parameter error: The error.
 */
- (void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error;
{
    
}

@end
