//
//  FoodController.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "FoodController.h"
#import "FoodCell.h"
#import "Food.h"

@interface FoodController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblFood;
@property (nonatomic,strong) NSMutableArray *foodList;
@property (nonatomic,strong) NSString *foodCatID;


@end

@implementation FoodController

-(id)initWithFoodCategoryID:(NSString*)foodCatID
{
    self = [super init];
    if (self) {
        _tblFood.delegate = self;
        _tblFood.dataSource = self;
        _foodList = [NSMutableArray new];
        _foodCatID = foodCatID;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    // Do any additional setup after loading the view from its nib.
}

//-(void)reloadScrollView
//{
//    [self getData];
//}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getData];
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



-(void)getData
{
    //[self.foodList removeAllObjects];
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    
    [API getWithUrl:kAPIGetListFood param:@{@"foodcatid":_foodCatID} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"rres :%@",responseObject);
//        
//        NSArray *ar = (NSArray*)responseObject;
//        
//      
//        
//        for (int i = 0; i < ar.count; i++) {
//            
//            
//            
//            NSDictionary *dict = ar[i];
//            NSLog(@"dict :%@",dict);
//            Food *f = [[Food alloc]initWithDictionary:dict];
//            NSLog(@"foood name :%@",f.foodName);
//            [tmp addObject:f];
//        }
//        

        
        for (NSDictionary*dict in responseObject) {
            
            Food *food = [[Food alloc]initWithDictionary:dict];
            
            if ([[[GlobalVar getInstance] foodList] containsFood:food] != nil) {
                [tmp addObject:[[[GlobalVar getInstance] foodList] containsFood:food]];
                
            }else
            {
                [tmp addObject:food];
            }
            

  
        }
        
        
        
        
        _foodList = tmp ;
        [_tblFood reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (_foodList.count == 0) {
        return 0;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _foodList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellID = @"CellID";
    
    FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FoodCell" owner:nil options:nil];
        cell = nib[0];
        
    }
    
    Food *selFood = _foodList[indexPath.section];
    
    [cell displayWithFood:selFood];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5.0f;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
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
