//
//  GalleryController.m
//  Amazing
//
//  Created by Tuan Vu on 11/30/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "GalleryController.h"


@interface GalleryController ()<CarbonTabSwipeNavigationDelegate>
{
    NSArray *items;
    CarbonTabSwipeNavigation *carbonTabSwipeNavigation;
}

@property (strong, nonatomic) NSMutableArray *listCategoryId;


@end

@implementation GalleryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Menu"];
    _listCategoryId = [NSMutableArray array];
    _listCategoryId = [@[@"1",@"2",@"3",@"4"] mutableCopy];
    items = [Menu segment];
    carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:items delegate:self];
    [carbonTabSwipeNavigation insertIntoRootViewController:self];
    [self style];
    
 }

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    return [[FoodCategoryController alloc]initWithCategoryID:_listCategoryId[index] andType:index];
}


- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
    willBeginTransitionFromIndex:(NSUInteger)index;
{

    
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotifyCarbonKitWillBeginTransition object:nil];
    
}


- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                  didMoveAtIndex:(NSUInteger)index;
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyCarbonKitDidFinishTransition object:nil];
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
