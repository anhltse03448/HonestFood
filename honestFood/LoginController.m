//
//  LoginController.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/14/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UIImageView *appicon;
@property (weak, nonatomic) IBOutlet UIButton *btnFbLogin;


@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnLoginDidTap:(id)sender {
    
    [Menu settingSlideMenuController];
    
    
    
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
