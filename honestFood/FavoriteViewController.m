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
@interface FavoriteViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tbl;
@property (nonatomic,strong) NSMutableArray *foodList;

@end
int check = 0;
@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tbl.delegate = self ;
    self.tbl.dataSource = self ;
    self.tbl.separatorStyle = UITableViewCellSeparatorStyleNone ;
}

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    [self initData];
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
    FavoriteTableViewCell *cell = [self.tbl dequeueReusableCellWithIdentifier:cellIdentify] ;
    
    if (!cell) {
        //[_foodImage sd_setImageWithURL:[NSURL URLWithString:food.imgUrl] placeholderImage:nil];
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FavoriteTableViewCell" owner:nil options:nil];
        cell = nib[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.delegate = self ;
        
    }
    
    Food *food = _foodList[indexPath.row] ;
    NSString *link = food.imgUrl ;
    
    [cell.img_food sd_setImageWithURL:[NSURL URLWithString: link] placeholderImage : nil];
    [cell setFood:_foodList[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.delegate = self ;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 150 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath ;
{
    
}
- (void)img2_tap:(UITableViewCell *)cell ;
{
    //NSLog(@"2") ;
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
}

@end


