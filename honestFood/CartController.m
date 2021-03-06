//
//  CartController.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/16/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "CartController.h"

@interface CartController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblCart;
@property (strong , nonatomic) NSMutableArray *foodList;
@property (assign , nonatomic) CartControllerType type;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@property (weak, nonatomic) IBOutlet UIView *actionView;

@property (weak, nonatomic) IBOutlet UIButton *btnChart;
@end

@implementation CartController

-(id)initWithFoodList:(NSMutableArray*)otherFoodList andType:(CartControllerType)type
{
    self = [super init];
    if (self) {
        _type = type;
        _foodList = otherFoodList;
        
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Giỏ hàng"];
    self.tblCart.rowHeight = 100.f;
    _tblCart.emptyDataSetDelegate = [EmptyDataSourceDelegate sharedInstance];
    _tblCart.emptyDataSetSource = [EmptyDataSourceDelegate sharedInstance];
    
    _actionView.backgroundColor = kAppColor;
    
    [_btnChart setImage:[UIImage barChartImage] forState:UIControlStateNormal];
    [self.tblCart setShowsVerticalScrollIndicator:NO];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // only setting up button bar item with type New
    if (_type == CartControllerTypeNew) {
        [self settingLeftMenuBars];
        [self settingRightMenuBars];
    }
    
    _lblPrice.text = [NSString stringWithFormat:@"VNĐ %@",[Utils totalPriceWithListFood:_foodList]];
    if (_type == CartControllerTypeHistory) {
        
        [_btnBuy setTitle:@"Đặt lại" forState:UIControlStateNormal];
    }
    
    [self.tblCart reloadData];
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
    
    rightDrawerButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[rightDrawerButton];
}

-(void)cartViewDidTap:(UIBarButtonItem*)item
{

    ListItemInCartView *listItemInCartView = [ListItemInCartView sharedInstance];
    
    listItemInCartView.frame = CGRectMake(0, 0, kscreenWidth - 20, kscreenHeight - 130);
    listItemInCartView.layer.cornerRadius = 10.0f;
    listItemInCartView.layer.masksToBounds = YES;
    
     listItemInCartView.moveToWindow = ^()
    {
        [_tblCart reloadData];
    };
    
    KLCPopup* popup =  [KLCPopup popupWithContentView:listItemInCartView showType:KLCPopupShowTypeFadeIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    
    
    
    [popup show];
    
}

- (IBAction)btnChartDidTap:(id)sender {
    
    CGRect frame = CGRectMake(0, 0, kscreenWidth -60, 350) ;
    UIView *view = [Utils chartViewWithFoodList:_foodList AndFrame:frame];
    [Utils showChartWiewWithChart:view];
}



-(void)settingLeftMenuBars
{
    FAKFontAwesome* bars = [FAKFontAwesome barsIconWithSize:20];
    UIImage* barImg = [bars imageWithSize:CGSizeMake(20, 20)];
    UIBarButtonItem* leftDrawerButton = [[UIBarButtonItem alloc] initWithImage:barImg style:UIBarButtonItemStylePlain target:self action:@selector(leftDrawerButtonPress:)];
    leftDrawerButton.tintColor = [UIColor whiteColor];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)leftDrawerButtonPress:(UIBarButtonItem*)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (_foodList.count == 0) {
        return 0 ;
    }
    return 1 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *foodCellCartId = @"foodCellCartId";
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:foodCellCartId];
    if (!cell) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FoodCell" owner:nil options:nil];
        cell = nib[0];

    }
    Food *food = _foodList[indexPath.section];
    
    [cell displayWithFood:food];
    if (_type == CartControllerTypeHistory) {
        
        
        cell.type = FoodCellTypeHistory;
        [cell hiddenActionButton];
    }
    if (_type == CartControllerTypeNew) {
        
        cell.type = FoodCellTypeInCategory;
        
    }
    
    
    
    return cell;
}
- (IBAction)btnBuyDidTap:(id)sender {
    
    if (_type == CartControllerTypeNew) {
        
        OrderController *orderController = [[OrderController alloc]initWithNibName:@"OrderController" bundle:nil];
        NavigationController *nav = [[NavigationController alloc]initWithRootViewController:orderController];
        
        [self presentViewController:nav animated:NO completion:nil];
        
        
    }
    if (_type == CartControllerTypeHistory) {
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return _foodList.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 5.0f;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
