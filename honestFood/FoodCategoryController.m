//
//  FoodCategoryController.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//



#import "FoodCategoryController.h"
#import "FoodCategoryCollectionCell.h"
#import "FoodController.h"
#import "RACollectionViewReorderableTripletLayout.h"

@interface FoodCategoryController ()<RACollectionViewDelegateReorderableTripletLayout, RACollectionViewReorderableTripletLayoutDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (assign , nonatomic) FoodCategoryControllerType type;
@property (strong, nonatomic) LGPlusButtonsView *plusButtonsViewMain;
@end

@implementation FoodCategoryController
{
    NSString *_foodCategoryId ;
    KRLCollectionViewGridLayout *layout;
    CarbonSwipeRefresh *refresh;
    
}

static NSString *foodCategoryCellId  = @"foodCategoryCellId";

-(id)initWithCategoryID:(NSString*)categoryId andType:(FoodCategoryControllerType)type
{
    self = [super init];
    if (self) {
        _foodCategoryId = categoryId;
        _type = type;
    }
    
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self settingCollectionLayout];
    
    [self.collection setShowsVerticalScrollIndicator:NO];
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadingData];



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

-(void)loadingData
{
    [self.data removeAllObjects];
    [API getWithUrl:kAPIGetListFoodCat param:@{@"catid":_foodCategoryId} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self addingDataByReponse:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)addingDataByReponse:(id)responseObject
{
    for (NSDictionary *dict in responseObject) {
        FoodCategory *foodCategory = [FoodCategory foodCategoryWithDictionary:dict];
        [self.data addObject:foodCategory];
    }
    [_collection reloadData];
    
    NSLog(@"count :%lu",(unsigned long)self.data.count);
    
    
    
    [_collection reloadData];
    
    
}




-(void)settingCollectionLayout
{

    self.collection.dataSource = self;
    self.collection.delegate = self;
    [_collection registerNib:[UINib nibWithNibName:@"FoodCategoryCollectionCell" bundle:nil] forCellWithReuseIdentifier:foodCategoryCellId];
    
    refresh = [[CarbonSwipeRefresh alloc] initWithScrollView:self.collection];
    [refresh setColors:@[
                         [UIColor blueColor],
                         [UIColor redColor],
                         [UIColor orangeColor],
                         [UIColor greenColor]]
     ];
    [self.view addSubview:refresh];
    int64_t delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [refresh endRefreshing];
        
    });
//    [refresh addTarget:self action:@selector(loadingData) forControlEvents:UIControlEventValueChanged];
}

-(void)refresh:(id)sender
{
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
 
    
    FoodCategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:foodCategoryCellId forIndexPath:indexPath];
    
    FoodCategory *fc = self.data[indexPath.item];
    [cell displayWithFoodCategory:fc];



    
    return cell;
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    FoodCategory *fc = self.data[indexPath.item];
    FoodController *foodController = [[FoodController alloc]initWithFoodCategoryID:fc.foodCategoryId];
    NavigationController *naviFood = [[NavigationController alloc]initWithRootViewController:foodController];
    [self presentViewController:naviFood animated:NO completion:nil];
    
}

#pragma mark float Button Action

//-(void)hiddenFloatButton
//{
//    
//    [self.plusButtonsViewMain hideAnimated:YES completionHandler:nil];
//}
//
//-(void)reShowFloatButton
//{
//    [self.plusButtonsViewMain showAnimated:YES completionHandler:nil];
//
//
//    
//}


#pragma mark - FM

- (CGFloat)sectionSpacingForCollectionView:(UICollectionView *)collectionView
{
    return 1.f;
}

- (CGFloat)minimumInteritemSpacingForCollectionView:(UICollectionView *)collectionView
{
    return 1.f;
}

- (CGFloat)minimumLineSpacingForCollectionView:(UICollectionView *)collectionView
{
    return 1.f;
}

- (UIEdgeInsets)insetsForCollectionView:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(1.f, 0, 1.f, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForLargeItemsInSection:(NSInteger)section
{
 
    return RACollectionViewTripletLayoutStyleSquare; //same as default !
}

- (UIEdgeInsets)autoScrollTrigerEdgeInsets:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(50.f, 0, 50.f, 0); //Sorry, horizontal scroll is not supported now.
}

- (UIEdgeInsets)autoScrollTrigerPadding:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(64.f, 0, 0, 0);
}

- (CGFloat)reorderingItemAlpha:(UICollectionView *)collectionview
{
    return .3f;
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collection reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath
{

}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    if (toIndexPath.section == 0) {
        return NO;
    }
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}
@end
