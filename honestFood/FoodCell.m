//
//  FoodCell.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "FoodCell.h"


@interface FoodCell ()<SWTableViewCellDelegate,EMEmojiableBtnDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *lblFoodName;
@property (weak, nonatomic) IBOutlet UILabel *lblFoodPrice;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToCart;
@property (weak, nonatomic) IBOutlet UILabel *lblQuanity;


@end

@implementation FoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _stepper.hidden = YES;
    [_stepper setValue:[_food_.quantity integerValue]];
    
    self.delegate = self;
    

    
    
    
    
    // Initialization code
}

-(void)setType:(FoodCellType)type
{
    _type = type;
    self.rightUtilityButtons = [self rightButtons];
    
    
}

-(void)hiddenActionButton
{
    _btnAddToCart.hidden = YES;
    _stepper.hidden = YES;
}


-(void)displayWithFood:(Food*)food
{
    _food_ = food;
    [_foodImage sd_setImageWithURL:[NSURL URLWithString:food.imgUrl] placeholderImage:nil];
    _lblFoodName.text = food.foodName;
    _lblFoodPrice.text = [food.price stringValue];
    
    if ([food.quantity integerValue] <= 0) {
        
        _lblQuanity.text = @"";
    }else
    {
        _lblQuanity.text = [NSString stringWithFormat:@"x%d",[food.quantity integerValue]];
        _btnAddToCart.hidden = YES;
        _stepper.hidden = NO;
        [_stepper setValue:[food.quantity doubleValue]];
    }
}
- (IBAction)addToCartButtonDidTap:(id)sender {
    

    _stepper.hidden = NO;
    [_food_ setQuantity:@1];
   _lblFoodPrice.text = [_food_.price stringValue];
    if (![[[GlobalVar getInstance] foodList] containsObject:_food_]) {
        [[[GlobalVar getInstance] foodList] addObject:_food_];
    }
    
    _lblQuanity.text = @"x1";
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotifyAddFoodToCartName object:nil];
    
    NSLog(@"globar list food %@",[[GlobalVar getInstance] foodList] );
    
    
}
- (IBAction)stepperChangeValue:(UIStepper *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotifyAddFoodIncreaseCount object:nil];
    
    _btnAddToCart.hidden = YES;
    [_food_ setQuantity:@(sender.value)];
    _lblFoodPrice.text = [_food_.price stringValue];
    NSInteger index = [[[GlobalVar getInstance] foodList] indexOfObject:_food_];
    [[[GlobalVar getInstance] foodList] replaceObjectAtIndex:index withObject:_food_];
    _lblQuanity.text = [NSString stringWithFormat:@"x%d",[@(sender.value) integerValue]];
    
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    
    
    if (_type == FoodCellTypeFavorite) {
        
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                    title:@"Delete"];
        

    }else if(_type == FoodCellTypeInCart)
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                    title:@"Favorite"];
    }
    
    
    
    
    return rightUtilityButtons;
}

#pragma SWCELL DELEGATE

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    
    
    NSNumber *flag = [[NSNumber alloc]init];
    
    if (_type == FoodCellTypeFavorite) {
        
        flag = @0;
    }else
    {
        flag = @1;
    }
    
    [API postWithUrl:kAPIFoodActionFavorite param:@{@"userId":@"96",
                                                    @"foodId":_food_.foodId,
                                                    @"flag":flag}
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 
                 NSLog(@"food action fav %@",responseObject);
                 
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"error :%@",error);
             }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
