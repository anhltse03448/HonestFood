//
//  ListItemInCartView.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "ListItemInCartView.h"


@interface ListItemInCartView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblItems;
@property (weak, nonatomic) IBOutlet UIView *viewCartInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@property (weak, nonatomic) IBOutlet UIButton *btnChart;

@end

@implementation ListItemInCartView


+ (instancetype)sharedInstance
{
    static ListItemInCartView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [self shared];
       
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}


-(void)willMoveToWindow:(UIWindow *)newWindow
{
    [self.tblItems reloadData];
    [self updateLabel];
    self.moveToWindow();
}


- (IBAction)btnChartDidTap:(id)sender {
    CGRect frame = CGRectMake(0, 0, kscreenWidth -60, 300) ;
    UIView *view = [Utils chartViewWithFoodList:[[GlobalVar getInstance] foodList] AndFrame:frame];
    //UIView * view = [Utils chartViewWithFoodList:[[GlobalVar getInstance] foodList] AndFrame:];
    [Utils showChartWiewWithChart:view];
    
    
}




- (IBAction)btnBuyDidTap:(id)sender {
    
    
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    self.tblItems.dataSource = self;
    self.tblItems.delegate = self;
    self.tblItems.rowHeight = 80.f;
    

    self.tblItems.emptyDataSetSource = [EmptyDataSourceDelegate sharedInstance];
    self.tblItems.emptyDataSetDelegate  = [EmptyDataSourceDelegate sharedInstance];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateLabel) name:kNotifyAddFoodToCartName object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateLabel) name:kNotifyAddFoodIncreaseCount object:nil];
    
    [_btnChart setImage:[UIImage barChartImage] forState:UIControlStateNormal];
    
    _viewCartInfo.backgroundColor = kAppColor;
    
    
}


-(void)updateLabel
{
    _lblPrice.text = [Utils totalPriceWithListFood:[[GlobalVar getInstance]foodList]];
}

+(ListItemInCartView*)shared
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ListItemInCartView" owner:nil options:nil];
    ListItemInCartView *sharedInstance = nib[0];
    return sharedInstance;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [[[GlobalVar getInstance]foodList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *foodCellCartId = @"foodCellCartId";
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:foodCellCartId];
    if (!cell) {
       
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FoodCell" owner:nil options:nil];
        cell = nib[0];
        cell.type = FoodCellTypeInCart;
    }
    

    Food *food = [[GlobalVar getInstance]foodList][indexPath.row];
   [cell displayWithFood:food];
    return cell;
}


@end
