//
//  FoodCell.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "FoodCell.h"
#import "FacebookAPI.h"


@interface FoodCell ()<SWTableViewCellDelegate,EMEmojiableBtnDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *lblFoodName;
@property (weak, nonatomic) IBOutlet UILabel *lblFoodPrice;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToCart;
@property (weak, nonatomic) IBOutlet UILabel *lblQuanity;
@property (weak, nonatomic) IBOutlet UILabel *lblUnit;


@end

@implementation FoodCell
{
    NSInteger oldValue;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _stepper.hidden = YES;
//    [_stepper setValue:[_food_.quantity integerValue]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.delegate = self;
    oldValue = _stepper.value;
    
    [_btnAddToCart setImage:[[UIImage imageNamed:@"Icon_My Cart.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    _btnAddToCart.layer.borderColor = kAppColor.CGColor;
    _btnAddToCart.layer.borderWidth = 1.0f;
    _btnAddToCart.layer.cornerRadius = 2.0f;
    _btnAddToCart.layer.masksToBounds = YES;
    
    
    
    

    
    
    
    
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
    _lblFoodPrice.text = [NSString stringWithFormat:@"VNĐ %@",[self priceFormat:food.price]];
    _lblUnit.text = food.unit;
    
    if ([food.quantity integerValue] <= 0) {
        
        _lblQuanity.text = @"";
    }else
    {
        _lblQuanity.text = [NSString stringWithFormat:@"x%ld",(long)[food.quantity integerValue]];
        _btnAddToCart.hidden = YES;
        _stepper.hidden = NO;
        [_stepper setValue:[food.quantity doubleValue]];
    }
}


-(NSString*)priceFormat:(NSNumber*)price
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *result = [numberFormatter stringFromNumber:price];
    return result;
}


- (IBAction)addToCartButtonDidTap:(id)sender {
    

    _stepper.hidden = NO;
    _btnAddToCart.hidden = YES;
    [_food_ setQuantity:@1];
//   _lblFoodPrice.text = [_food_.price stringValue];
    if (![[[GlobalVar getInstance] foodList] containsObject:_food_]) {
        [[[GlobalVar getInstance] foodList] addObject:_food_];
    }
    
    _lblQuanity.text = @"x1";
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotifyAddFoodToCartName object:nil];
    
    NSLog(@"globar list food %@",[[GlobalVar getInstance] foodList] );
    
    
}
- (IBAction)stepperChangeValue:(UIStepper *)sender {
    
    
    
//    _btnAddToCart.hidden = YES;
    if (sender.value > oldValue) {
        oldValue = oldValue+1;
        [_food_ setQuantity:@([_food_.quantity integerValue] + 1)];
    }else
    {
        oldValue=oldValue -1;
        if ([_food_.quantity integerValue] > 0) {
            [_food_ setQuantity:@([_food_.quantity integerValue] - 1)];
        }
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotifyAddFoodIncreaseCount object:nil];
    
//    _lblFoodPrice.text = [_food_.price stringValue];
    NSInteger index = [[[GlobalVar getInstance] foodList] indexOfObject:_food_];
    [[[GlobalVar getInstance] foodList] replaceObjectAtIndex:index withObject:_food_];
    _lblQuanity.text = [NSString stringWithFormat:@"x%ld",(long)[_food_.quantity integerValue]];
    
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    
    
    if (_type == FoodCellTypeFavorite) {
        
        [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f] icon:[UIImage xImage]];
        [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor hx_colorWithHexRGBAString:@"#3b5998"] icon:[UIImage fbImage]];
        
//        
//        [rightUtilityButtons sw_addUtilityButtonWithColor:
//         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
//                                                    title:@"Xóa"];
//        [rightUtilityButtons sw_addUtilityButtonWithColor:
//        [UIColor hx_colorWithHexRGBAString:@"#3b5998"]
//                                                    title:@"Share"];
        

    }else if(_type == FoodCellTypeInCart)
    {
        [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f] icon:[UIImage heartImage]];
        [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor hx_colorWithHexRGBAString:@"#3b5998"] icon:[UIImage fbImage]];
    }
    
    
    
    
    return rightUtilityButtons;
}

#pragma SWCELL DELEGATE

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    
    
    if (index == 0) {
        if (_delegate1 != nil) {
            [_delegate1 tap:self];
        }
        NSNumber *flag = [[NSNumber alloc]init];
        
        if (_type == FoodCellTypeFavorite) {
            
            flag = @0;
        }else
        {
            flag = @1;
        }
        
        [API postWithUrl:kAPIFoodActionFavorite param:@{@"userId":[globarVar userId],
                                                        @"foodId":_food_.foodId,
                                                        @"flag":flag}
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     NSLog(@"food action fav %@",responseObject);
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     NSLog(@"error :%@",error);
                 }];
        
//        _utilsDidTap(_food_);
    }
    if (index ==1) {
        
        [[FacebookAPI sharedManager] shareFood:_food_ On:_ownerController];
        
        
    }
    
    

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
