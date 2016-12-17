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
    [self loadingData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hiddenFloatButton) name:kNotifyCarbonKitWillBeginTransition object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reShowFloatButton) name:kNotifyCarbonKitDidFinishTransition object:nil];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)dealloc
{
   
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotifyCarbonKitWillBeginTransition object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotifyCarbonKitDidFinishTransition object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//     _plusButtonsViewMain = [[LGPlusButtonsView alloc]initWithNumberOfButtons:4 firstButtonIsPlusButton:YES showAfterInit:YES];
//    _plusButtonsViewMain.observedScrollView = self.collection;
//    _plusButtonsViewMain.coverColor = [UIColor colorWithWhite:1.f alpha:0.7];
//    _plusButtonsViewMain.position = LGPlusButtonsViewPositionBottomRight;
//    _plusButtonsViewMain.plusButtonAnimationType = LGPlusButtonAnimationTypeRotate;
//    
//    [_plusButtonsViewMain setButtonsTitles:@[@"+", @"", @"", @""] forState:UIControlStateNormal];
//    [_plusButtonsViewMain setDescriptionsTexts:@[@"", @"Take a photo", @"Choose from gallery", @"Send a message"]];
//    [_plusButtonsViewMain setButtonsImages:@[[NSNull new], [UIImage imageNamed:@"Camera"], [UIImage imageNamed:@"Picture"], [UIImage imageNamed:@"Message"]]
//                                  forState:UIControlStateNormal
//                            forOrientation:LGPlusButtonsViewOrientationAll];
//    
//    [_plusButtonsViewMain setButtonsAdjustsImageWhenHighlighted:NO];
//    [_plusButtonsViewMain setButtonsBackgroundColor:[UIColor colorWithRed:0.f green:0.5 blue:1.f alpha:1.f] forState:UIControlStateNormal];
//    [_plusButtonsViewMain setButtonsBackgroundColor:[UIColor colorWithRed:0.2 green:0.6 blue:1.f alpha:1.f] forState:UIControlStateHighlighted];
//    [_plusButtonsViewMain setButtonsBackgroundColor:[UIColor colorWithRed:0.2 green:0.6 blue:1.f alpha:1.f] forState:UIControlStateHighlighted|UIControlStateSelected];
//    [_plusButtonsViewMain setButtonsSize:CGSizeMake(44.f, 44.f) forOrientation:LGPlusButtonsViewOrientationAll];
//    [_plusButtonsViewMain setButtonsLayerCornerRadius:44.f/2.f forOrientation:LGPlusButtonsViewOrientationAll];
//    [_plusButtonsViewMain setButtonsTitleFont:[UIFont boldSystemFontOfSize:24.f] forOrientation:LGPlusButtonsViewOrientationAll];
//    [_plusButtonsViewMain setButtonsLayerShadowColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.f]];
//    [_plusButtonsViewMain setButtonsLayerShadowOpacity:0.5];
//    [_plusButtonsViewMain setButtonsLayerShadowRadius:3.f];
//    [_plusButtonsViewMain setButtonsLayerShadowOffset:CGSizeMake(0.f, 2.f)];
//    [_plusButtonsViewMain setButtonAtIndex:0 size:CGSizeMake(56.f, 56.f)
//                            forOrientation:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? LGPlusButtonsViewOrientationPortrait : LGPlusButtonsViewOrientationAll)];
//    [_plusButtonsViewMain setButtonAtIndex:0 layerCornerRadius:56.f/2.f
//                            forOrientation:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? LGPlusButtonsViewOrientationPortrait : LGPlusButtonsViewOrientationAll)];
//    [_plusButtonsViewMain setButtonAtIndex:0 titleFont:[UIFont systemFontOfSize:40.f]
//                            forOrientation:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? LGPlusButtonsViewOrientationPortrait : LGPlusButtonsViewOrientationAll)];
//    [_plusButtonsViewMain setButtonAtIndex:0 titleOffset:CGPointMake(0.f, -3.f) forOrientation:LGPlusButtonsViewOrientationAll];
//    [_plusButtonsViewMain setButtonAtIndex:1 backgroundColor:[UIColor colorWithRed:1.f green:0.f blue:0.5 alpha:1.f] forState:UIControlStateNormal];
//    [_plusButtonsViewMain setButtonAtIndex:1 backgroundColor:[UIColor colorWithRed:1.f green:0.2 blue:0.6 alpha:1.f] forState:UIControlStateHighlighted];
//    [_plusButtonsViewMain setButtonAtIndex:2 backgroundColor:[UIColor colorWithRed:1.f green:0.5 blue:0.f alpha:1.f] forState:UIControlStateNormal];
//    [_plusButtonsViewMain setButtonAtIndex:2 backgroundColor:[UIColor colorWithRed:1.f green:0.6 blue:0.2 alpha:1.f] forState:UIControlStateHighlighted];
//    [_plusButtonsViewMain setButtonAtIndex:3 backgroundColor:[UIColor colorWithRed:0.f green:0.7 blue:0.f alpha:1.f] forState:UIControlStateNormal];
//    [_plusButtonsViewMain setButtonAtIndex:3 backgroundColor:[UIColor colorWithRed:0.f green:0.8 blue:0.f alpha:1.f] forState:UIControlStateHighlighted];
//    
//    [_plusButtonsViewMain setDescriptionsBackgroundColor:[UIColor whiteColor]];
//    [_plusButtonsViewMain setDescriptionsTextColor:[UIColor blackColor]];
//    [_plusButtonsViewMain setDescriptionsLayerShadowColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.f]];
//    [_plusButtonsViewMain setDescriptionsLayerShadowOpacity:0.25];
//    [_plusButtonsViewMain setDescriptionsLayerShadowRadius:1.f];
//    [_plusButtonsViewMain setDescriptionsLayerShadowOffset:CGSizeMake(0.f, 1.f)];
//    [_plusButtonsViewMain setDescriptionsLayerCornerRadius:6.f forOrientation:LGPlusButtonsViewOrientationAll];
//    [_plusButtonsViewMain setDescriptionsContentEdgeInsets:UIEdgeInsetsMake(4.f, 8.f, 4.f, 8.f) forOrientation:LGPlusButtonsViewOrientationAll];
//    
//    for (NSUInteger i=1; i<=3; i++)
//        [_plusButtonsViewMain setButtonAtIndex:i offset:CGPointMake(-6.f, 0.f)
//                                forOrientation:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? LGPlusButtonsViewOrientationPortrait : LGPlusButtonsViewOrientationAll)];
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//        [_plusButtonsViewMain setButtonAtIndex:0 titleOffset:CGPointMake(0.f, -2.f) forOrientation:LGPlusButtonsViewOrientationLandscape];
//        [_plusButtonsViewMain setButtonAtIndex:0 titleFont:[UIFont systemFontOfSize:32.f] forOrientation:LGPlusButtonsViewOrientationLandscape];
//    }
//    
//    [self.collection addSubview:_plusButtonsViewMain];

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
    NSLog(@"count :%d",self.data.count);
    [_collection reloadData];
    
    
}




-(void)settingCollectionLayout
{

    self.collection.dataSource = self;
    self.collection.delegate = self;
    
    
    [_collection registerNib:[UINib nibWithNibName:@"FoodCategoryCollectionCell" bundle:nil] forCellWithReuseIdentifier:foodCategoryCellId];
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

-(void)hiddenFloatButton
{
    
    [UIView transitionWithView:_plusButtonsViewMain
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                    }
                    completion:NULL];
    
 
//    [self.plusButtonsViewMain hideButtonsAnimated:YES completionHandler:nil];
}

-(void)reShowFloatButton
{
    [UIView transitionWithView:_plusButtonsViewMain
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        _plusButtonsViewMain.hidden = NO;
                    }
                    completion:NULL];
//    [self.plusButtonsViewMain showAnimated:YES completionHandler:nil];
}


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
