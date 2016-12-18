//
//  MenuController.m
//  Amazing
//
//  Created by Tuan Vu on 11/30/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "MenuController.h"
#import "MenuCell.h"

@interface MenuController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSMutableArray *listMenu;

@end

@implementation MenuController
{
    NSNumber* cartCount;
    NSNumber* historyCount;
    NSNumber* favCount;
    
}

static NSString *menuCellID = @"MenuCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerView.backgroundColor = [UIColor clearColor];
    
    
    [_userAvatr sd_setImageWithURL:[NSURL URLWithString:[[[GlobalVar getInstance] user] imgUrl]] placeholderImage:nil];
    _lblUserName.text = [NSString stringWithFormat:@"%@ %@",[[globarVar user] firstName], [[globarVar user] lastName]];
    
    NSLog(@"app %@",[[[GlobalVar getInstance] user] imgUrl]);
    
    UIImage *fav = [UIImage imageNamed:@"Favorite"];
    UIImage *cart = [UIImage imageNamed:@"Cart"];
    UIImage *offer = [UIImage imageNamed:@"Offer"];
    UIImage *history = [UIImage imageNamed:@"History"];
    _listMenu = [NSMutableArray array];
    _tblMenu.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listMenu addObject:[Menu menuWithTitle:@"Menu" icon:offer navi:[Menu naviGallery]]];
    [_listMenu addObject:[Menu menuWithTitle:@"Giỏ Hàng" icon:cart navi:[Menu naviCart]]];
    [_listMenu addObject:[Menu menuWithTitle:@"Lịch Sử" icon:history navi:[Menu naviHistory]]];
    [_listMenu addObject:[Menu menuWithTitle:@"Ưa Thích" icon:fav navi:[Menu naviFav]]];
    [_listMenu addObject:[Menu menuWithTitle:@"Biểu Đồ" icon:[UIImage barChartImage] navi:[Menu navProfile]]];
    
    _tblMenu.rowHeight = 50.0f;
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight)];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = [UIImage imageNamed:@"BG_Image.png"];
    self.tblMenu.backgroundView  = imgView;
//    self.tblMenu.backgroundColor = [UIColor clearColor];
//    self.view.backgroundColor = [UIColor clearColor];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    _userAvatr.layer.cornerRadius = _userAvatr.layer.frame.size.height / 2 ;
    _userAvatr.layer.masksToBounds = true ;
    [self getAllCount];
    [_tblMenu reloadData];
}

-(void)getAllCount
{
    [API getWithUrl:@"getcounthistoryorder" param:@{@"ownerid":[globarVar userId]} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        historyCount = responseObject[@"counter"] ;
                        [_tblMenu reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    [API getWithUrl:@"getcountfavoriteofuser" param:@{@"ownerid":[globarVar userId]} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        favCount = responseObject[@"counter"];
        [_tblMenu reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _listMenu.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellID];
    if (!cell) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MenuCell" owner:nil options:nil];
        cell = nib[0];
    }
    Menu *item = _listMenu[indexPath.row];
    cell.lblTitle.text = item.title;
    cell.icon.image = item.icon;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (indexPath.row == 0) {
        
        cell.lblNumberIndicator.hidden = YES;
    }
    
    if (indexPath.row == 1) {
        
        cell.lblNumberIndicator.text = [@([[[GlobalVar getInstance] foodList] count]) stringValue];
        
    }
    if (indexPath.row == 2) {
        
        cell.lblNumberIndicator.text = [historyCount stringValue];
        
    }
    if (indexPath.row == 3) {
        
        cell.lblNumberIndicator.text = [favCount stringValue];
        
    }
    if (indexPath.row == 4) {
        
        cell.lblNumberIndicator.hidden = YES;
    }

    
    
    
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 99.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Menu *selectedMenu = _listMenu[indexPath.row];
    [self.mm_drawerController setCenterViewController:selectedMenu.navi withCloseAnimation:YES completion:nil];
}



@end
