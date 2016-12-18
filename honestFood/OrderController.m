//
//  OrderController.m
//  honestFood
//
//  Created by Tuan Vu on 12/18/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "OrderController.h"
#import <CoreLocation/CoreLocation.h>

@interface OrderController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPay;
@property (weak, nonatomic) IBOutlet UIButton *btnPickLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (nonatomic ,assign) CLLocationCoordinate2D userLocation;

@end

@implementation OrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.map.delegate = self;
    self.map.showsUserLocation = YES;
    
    [self setTitle:@"Đặt hàng"];
    
    NSString *pay = [Utils totalPriceWithListFood:[globarVar foodList]];
    
    _lblTotalPay.text = [NSString stringWithFormat:@"VNĐ %@",pay];
    [_btnPickLocation setImage:[UIImage locationImage] forState:UIControlStateNormal];
    [_btnPickLocation setTintColor:[UIColor whiteColor]];
    [_btnPay setImage:[UIImage cartImage] forState:UIControlStateNormal];
    [_btnPay setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated;
{
    [super viewDidAppear:animated];
}
- (IBAction)btnPayDidTap:(id)sender {
    
    if ([[globarVar foodList] count] > 0) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:@{@"userId":[globarVar userId]} forKey:@"owner"];
        [dict setObject:@(_userLocation.longitude) forKey:@"longitude"];
        [dict setObject:@(_userLocation.latitude) forKey:@"latitude"];
        
        NSMutableArray *listFood = [NSMutableArray new];
        
        for (Food *food  in [globarVar foodList]) {
            
            [listFood addObject:@{@"foodId":food.foodId , @"quantity":food.quantity}];
            
            
        }
        [dict setObject:listFood forKey:@"foodList"];
        [dict setObject:@([Utils totalPayWithListFood:[globarVar foodList]]) forKey:@"billAmount"];
        
        
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Nhập Số Điện Thoại"
                                                                       message:@"Gửi số điện thoại của bạn để xác nhận đơn hàng"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *submit = [UIAlertAction actionWithTitle:@"Đặt Hàng" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           
                                                           if (alert.textFields.count > 0) {
                                                               
                                                               UITextField *textField = [alert.textFields firstObject];
                                                               if ([textField.text length] >= 10) {
                                                                   
                                                                   [dict setObject:textField.text forKey:@"mobile"];
                                                                   
                                                                   
                                                                   NSLog(@"param :%@",dict);
                                                                   
                                                                   
                                                                   [API postWithUrl:@"requestorder" param:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                       
                                                                       NSLog(@"res : %@",responseObject);
                                                                       
                                                                       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                                                       hud.mode = MBProgressHUDModeText;
                                                                       hud.label.text = @"Bạn đã đặt hàng thành công !";
                                                                       
                                                                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                                                           [hud hideAnimated:YES];
                                                                           
                                                                       });
                                                                       
                                                                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                       
                                                                   }];
                                                                   
                                                                   
                                                                   
                                                                   
                                                               }else
                                                               {
                                                                   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                                                   hud.mode = MBProgressHUDModeText;
                                                                   hud.label.text = @"Vui lòng nhập lại số điện thoại";
                                                    
                                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                                                       [hud hideAnimated:YES];
                                                                       
                                                                   });
                                                               }
                                                               
                                                               
                                                           }
                                                           
                                                       }];
        
        [alert addAction:submit];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Số điện thoại"; // if needs
            textField.keyboardType = UIKeyboardTypePhonePad;
        }];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}





-(void)settingLeftMenuBars
{
    
    UIBarButtonItem* leftDrawerButton = [[UIBarButtonItem alloc] initWithImage:[UIImage backImage] style:UIBarButtonItemStylePlain target:self action:@selector(leftDrawerButtonPress:)];
    leftDrawerButton.tintColor = [UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}


-(void)leftDrawerButtonPress:(UIBarButtonItem*)item
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.map setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.005f, 0.005f)) animated:YES];
    _userLocation = userLocation.coordinate;
    
    
}

-(void)updateNewLocation
{
    [_map setRegion:MKCoordinateRegionMake(_userLocation, MKCoordinateSpanMake(0.005f, 0.005f)) animated:YES];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:_userLocation];
    [self.map addAnnotation:annotation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
