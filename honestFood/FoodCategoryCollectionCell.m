//
//  FoodCategoryCollectionCell.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "FoodCategoryCollectionCell.h"

@interface  FoodCategoryCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;
@property (weak, nonatomic) IBOutlet UILabel *lblFoodCategoryName;

@end

@implementation FoodCategoryCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _categoryImage.layer.masksToBounds = YES;
    // Initialization code
}

-(void)displayWithFoodCategory:(FoodCategory*)foodCategory
{
    [_categoryImage sd_setImageWithURL:[NSURL URLWithString:foodCategory.imgUrl] placeholderImage:nil];
    
    _lblFoodCategoryName.text = foodCategory.foodCategoryName;
}

@end
