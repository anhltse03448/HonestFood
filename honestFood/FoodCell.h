//
//  FoodCell.h
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"
#import "FavoriteTableViewCell.h"


typedef NS_ENUM(NSInteger , FoodCellType)
{
    FoodCellTypeInCategory = 0,
    FoodCellTypeFavorite,
    FoodCellTypeHistory,
    FoodCellTypeInCart
    
};

@protocol DelegateFood<NSObject>
@optional
- (void)tap:(UITableViewCell *)cell ;
@end


typedef void (^utilsButtonDidTap) ();

//typedef void(^AddToCart)();
//typedef void (^StepperChangeValue) (UIStepper *stepper);

@interface FoodCell : SWTableViewCell

//@property AddToCart addtoCart;
//@property StepperChangeValue stepperChangeValue;
@property (nonatomic , strong) Food *food_;
@property (nonatomic ,assign) FoodCellType type;
@property UIViewController *ownerController;
@property (nonatomic,weak) id <DelegateFood> delegate1;
-(void)displayWithFood:(Food*)food;
-(void)hiddenActionButton;


//@property utilsButtonDidTap utilsDidTap;
//-(void)addFoodToCart:(AddToCart)addToCart andStepperChangeValue:(StepperChangeValue)stepperChangeValue;




@end
