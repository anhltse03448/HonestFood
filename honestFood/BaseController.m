//
//  BaseController.m
//  Amazing
//
//  Created by Tuan Vu on 11/30/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self settingLeftMenuBars];
    [self settingRightMenuBars];
    
}


-(void)settingRightMenuBars
{
    

    CartView *cart = [CartView sharedInstance];
    cart.frame = CGRectMake(0, 0, 40, 40);

    
    UIBarButtonItem* rightDrawerButton = [[UIBarButtonItem alloc]initWithCustomView:cart];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(cartViewDidTap:)];
    [cart addGestureRecognizer:singleFingerTap];

    
    
//    [rightDrawerButton setTarget:self];
//    [rightDrawerButton setAction:@selector(cartViewDidTap:)];
    
    rightDrawerButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[rightDrawerButton];
}


-(void)settingLeftMenuBars
{
    FAKFontAwesome* bars = [FAKFontAwesome barsIconWithSize:20];
    UIImage* barImg = [bars imageWithSize:CGSizeMake(20, 20)];
    UIBarButtonItem* leftDrawerButton = [[UIBarButtonItem alloc] initWithImage:barImg style:UIBarButtonItemStylePlain target:self action:@selector(leftDrawerButtonPress:)];
    leftDrawerButton.tintColor = [UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}



-(void)cartViewDidTap:(UIBarButtonItem*)item
{

    ListItemInCartView *listItemInCartView = [ListItemInCartView sharedInstance];
    listItemInCartView.ownerController = self;
    
    listItemInCartView.moveToWindow = ^()
    {
        [self performSelector:@selector(reloadScrollView) withObject:nil];
    };
    
    KLCPopup* popup =  [KLCPopup popupWithContentView:listItemInCartView showType:KLCPopupShowTypeFadeIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    
    
    
    [popup show];
    
    listItemInCartView.buttonBuyDidTap = ^()
    {
        [popup dismiss:YES];
        OrderController *order = [[OrderController alloc]initWithNibName:@"OrderController" bundle:nil];
        NavigationController *navi = [[NavigationController alloc]initWithRootViewController:order];
        [self presentViewController:navi animated:NO completion:nil];
    };
    
    listItemInCartView.frame = CGRectMake(0, 0, kscreenWidth - 20, kscreenHeight - 130);
    listItemInCartView.layer.cornerRadius = 10.0f;
    listItemInCartView.layer.masksToBounds = YES;
    
    
    
}

-(void)reloadScrollView
{
    NSLog(@"hihhiih");
}

-(void)leftDrawerButtonPress:(UIBarButtonItem*)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}




-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
//    [Utils removeCacheImage];
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
