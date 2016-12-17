//
//  HistoryController.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "HistoryController.h"

@interface HistoryController ()<CarbonTabSwipeNavigationDelegate>
{
    NSMutableArray *items;
    CarbonTabSwipeNavigation *carbonTabSwipeNavigation;

}

@property (nonatomic , strong) NSMutableArray *listFoodHistory;


@end

@implementation HistoryController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listFoodHistory = [NSMutableArray new];
    items = [NSMutableArray new];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self getItems];
    
    
}

-(void)setupSegmentTimeLine
{
    carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:items delegate:self];
    [carbonTabSwipeNavigation insertIntoRootViewController:self];
    [self style];
}

-(void)getItems
{
    [items removeAllObjects];
    [_listFoodHistory removeAllObjects];
    [API getWithUrl:kAPIGetHistoryOrder param:@{@"ownerid":@98} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        for (NSDictionary *dict  in responseObject) {
            
            [items addObject:[Utils stringDateFormatFrom:dict[@"createTime"]]];
            
            NSDictionary *foodListDict = dict[@"foodList"];
            NSMutableArray *foodList = [NSMutableArray new];
            [foodList removeAllObjects];
            for (NSDictionary *dict in foodListDict) {
                Food *food = [[Food alloc]initWithDictionary:dict];
                [foodList addObject:food];
            }
            [_listFoodHistory addObject:foodList];

        }
        [self setupSegmentTimeLine];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)style {
    
    carbonTabSwipeNavigation.toolbar.translucent = NO;
    carbonTabSwipeNavigation.carbonTabSwipeScrollView.backgroundColor = kNavigationBarColor;
    [carbonTabSwipeNavigation setNormalColor:[UIColor whiteColor]];
    [carbonTabSwipeNavigation setSelectedColor:kAppColor];
    
    [carbonTabSwipeNavigation setIndicatorColor:[UIColor whiteColor]];
    [carbonTabSwipeNavigation setTabExtraWidth:kGalleryTabExtraWidth];
    for (int i = 0; i < items.count; i++) {
        [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:kGallerySegmentWidth forSegmentAtIndex:i];
    }
    
}
- (nonnull UIViewController *)carbonTabSwipeNavigation:
(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index;
{
    return [[CartController alloc]initWithFoodList:_listFoodHistory[index] andType:CartControllerTypeHistory];
    
}


@end
