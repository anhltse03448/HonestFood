//
//  LoginViewController.m
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) FBSDKProfile* profile;

@end

@implementation LoginViewController
{
     MBProgressHUD* hud ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
- (IBAction)btnLoginTouchUp:(id)sender {
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             if ([FBSDKAccessToken currentAccessToken]) {
                 
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, first_name, last_name,name"}]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection* connection, id result, NSError* error) {
                      if (!error) {
                          _profile = [FBSDKProfile currentProfile];
                          
                          NSLog(@"fb user info %@",(NSDictionary*)result);
                          
                          NSString *imgUrl = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",result[@"id"]];
                          
                          NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
                          [param setObject:[FBSDKAccessToken currentAccessToken].tokenString forKey:@"accessToken"];
                          
                          if (result[@"first_name"]) {
                              [param setObject:result[@"first_name"] forKey:@"firstName"];
                          }else
                          {
                              [param setObject:@"" forKey:@"firstName"];
                          }
                          if (result[@"last_name"]) {
                              [param setObject:result[@"last_name"] forKey:@"lastName"];
                          }else
                          {
                              [param setObject:result[@"name"] forKey:@"lastName"];
                          }
                          
                          
                          [param setObject:result[@"id"] forKey:@"id"];
                          [param setObject:imgUrl forKey:@"imgUrl"];
          
                          hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                          
                          [API postWithUrl:kApiLogin param:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              [hud hideAnimated:YES];
                              [FBSDKAccessToken setCurrentAccessToken:nil];
                              NSLog(@"res :%@ ",responseObject);
                              
                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              [hud hideAnimated:YES];
//                              []
                          }];
//                          [API loginFacebookWithParams:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                              [self progressAfterRequestLoginWithResponse:responseObject];
//                              [hud hideAnimated:YES];
//                              [FBSDKAccessToken setCurrentAccessToken:nil];
//                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                              [hud hideAnimated:YES];
//                              
//                          }];
                          
                      }
                  }];
             };
             
         }
     }];
    
    
    
    
    
}

@end
