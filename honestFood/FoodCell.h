//
//  FoodCell.h
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"


//typedef void(^AddToCart)();
//typedef void (^StepperChangeValue) (UIStepper *stepper);

@interface FoodCell : UITableViewCell

//@property AddToCart addtoCart;
//@property StepperChangeValue stepperChangeValue;
@property (nonatomic , strong) Food *food_;
-(void)displayWithFood:(Food*)food;

//-(void)addFoodToCart:(AddToCart)addToCart andStepperChangeValue:(StepperChangeValue)stepperChangeValue;




@end
