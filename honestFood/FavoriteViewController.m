//
//  FavoriteViewController.m
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "FavoriteViewController.h"
#import "FavoriteTableViewCell.h"
#import "Food.h"
#import "DetailViewController.h"
#import "FacebookAPI.h"
@import FBSDKCoreKit ;
@import FBSDKShareKit;
@interface FavoriteViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tbl;
@property (weak, nonatomic) IBOutlet UIView *viewDelete;
@property (weak, nonatomic) IBOutlet UILabel *lblDelete;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBottomConstrain;

@property (nonatomic,strong) NSMutableArray *foodList;
@property (nonatomic,strong) NSMutableArray *listCheck;
@end

int check = 0;


@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tbl.delegate = self ;
    self.tbl.dataSource = self ;
    self.tbl.emptyDataSetSource = [EmptyDataSourceDelegate sharedInstance];
    self.tbl.emptyDataSetDelegate = [EmptyDataSourceDelegate sharedInstance];
    self.tbl.separatorStyle = UITableViewCellSeparatorStyleNone ;
    _listCheck = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    [self initData];
    [self.navigationController setNavigationBarHidden:false];
}

- (void)initData;
{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    [API getWithUrl:@"getfavoritefood" param:@{@"userid" : @"96"} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dict in responseObject) {
            Food *food = [[ Food alloc]initWithDictionary:dict];
            [tmp addObject:food];
        }
        self.foodList = tmp ;
        [ self.tbl reloadData] ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error) ;
    } ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section ;
{
    return _foodList.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *cellIdentify = @"FavoriteTableViewCell" ;
    FoodCell *cell = [self.tbl dequeueReusableCellWithIdentifier:cellIdentify] ;
    
    if (!cell) {
        //[_foodImage sd_setImageWithURL:[NSURL URLWithString:food.imgUrl] placeholderImage:nil];
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FoodCell" owner:nil options:nil];
        cell = nib[0];
        cell.type = FoodCellTypeFavorite;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
//        cell.delegate = self ;
        
    }
    
    Food *food = _foodList[indexPath.row] ;
    [cell displayWithFood:food];
//    NSString *link = food.imgUrl ;
//    
//    [cell.img_food sd_setImageWithURL:[NSURL URLWithString: link] placeholderImage : nil];
//    [cell setFood:_foodList[indexPath.row]];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
//    cell.delegate = self ;
//    if (check == 1) {
//        BOOL isHas = [_listCheck containsObject:@(indexPath.row)];
//        [cell setEditting:isHas];
//    } else {
//        
//    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath ;
{
    //[_viewDelete layoutIfNeeded];
    if (check == 0) {
        _viewBottomConstrain.constant = 0 ;
        DetailViewController *detailViewController = [[ DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil] ;
        detailViewController.food = _foodList[indexPath.row] ;
        [self.navigationController pushViewController:detailViewController animated:true];
        
    } else {
        BOOL isHas = [_listCheck containsObject:@(indexPath.row)];
        if (isHas == true) {
            [_listCheck removeObject:@(indexPath.row)];
        } else {
            [_listCheck addObject:@(indexPath.row)];
            if (_listCheck.count == 1) {
                //add len
                _viewBottomConstrain.constant = -50 ;
            }
        }
        if( _listCheck.count == 0 ) {
            //hidden
            _viewBottomConstrain.constant = 0 ;
            
        }
        [UIView animateWithDuration:0.3 animations:^{
           // [_viewDelete layoutIfNeeded];
            [self.view layoutIfNeeded];
            [_lblDelete setText:[NSString stringWithFormat:@"Xóa %lu món ăn", (unsigned long)_listCheck.count]];
        }];
        
    }
    [self.tbl reloadData];
}
- (void)img2_tap:(UITableViewCell *)cell ;
{
    NSIndexPath *indexPath = [self.tbl indexPathForCell:cell] ;
    Food *food = _foodList[indexPath.row] ;
    food.quantity = @(food.quantity.integerValue + 1 );
    [self.tbl reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)img1_tap:(UITableViewCell *)cell ;
{
    NSIndexPath *indexPath = [self.tbl indexPathForCell:cell] ;
    Food *food = _foodList[indexPath.row] ;
    if (food.quantity.integerValue >= 1 ) {
        food.quantity = @(food.quantity.integerValue - 1 );
    } else {
        
    }
    
    [self.tbl reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)cartViewDidTap:(UIBarButtonItem*)item
{
    check = ( check + 1) % 2 ;
    [self.tbl reloadData];
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


