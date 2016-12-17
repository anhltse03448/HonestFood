//
//  FoodCell.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "FoodCell.h"


@interface FoodCell ()

@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *lblFoodName;
@property (weak, nonatomic) IBOutlet UILabel *lblFoodPrice;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToCart;


@end

@implementation FoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _stepper.hidden = YES;
    [_stepper setValue:[_food_.quantity integerValue]];
    
    
    
    
    // Initialization code
}


-(void)displayWithFood:(Food*)food
{
    _food_ = food;
    [_foodImage sd_setImageWithURL:[NSURL URLWithString:food.imgUrl] placeholderImage:nil];
    _lblFoodName.text = food.foodName;
    _lblFoodPrice.text = [food.quantity stringValue];
}
- (IBAction)addToCartButtonDidTap:(id)sender {
    
//    _btnAddToCart.hidden = YES;
    _stepper.hidden = NO;
    [_food_ setQuantity:@1];
   _lblFoodPrice.text = [_food_.quantity stringValue];
    if (![[[GlobalVar getInstance] foodList] containsObject:_food_]) {
        [[[GlobalVar getInstance] foodList] addObject:_food_];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotifyAddFoodToCartName object:nil];
    
    NSLog(@"globar list food %@",[[GlobalVar getInstance] foodList] );
    
    
}
- (IBAction)stepperChangeValue:(UIStepper *)sender {
    
    [_food_ setQuantity:@(sender.value)];
    _lblFoodPrice.text = [_food_.quantity stringValue];
    NSInteger index = [[[GlobalVar getInstance] foodList] indexOfObject:_food_];
    [[[GlobalVar getInstance] foodList] replaceObjectAtIndex:index withObject:_food_];
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
