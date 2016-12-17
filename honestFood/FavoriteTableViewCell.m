//
//  FavoriteTableViewCell.m
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "FavoriteTableViewCell.h"
#import "Food.h"


@implementation FavoriteTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    [self.img2 setUserInteractionEnabled:true] ;
    UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(img2_tap:)];
    [self.img2 addGestureRecognizer:gesture2] ;
    
    
    [self.img1 setUserInteractionEnabled:true] ;
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(img1_tap:)];
    [self.img1 addGestureRecognizer:gesture1] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)img2_tap:(UITapGestureRecognizer *)recognize;
{
    if (self.delegate != nil) {
        [self.delegate img2_tap:self] ;
    }
}

- (void)img1_tap:(UITapGestureRecognizer *)recognize;
{
    if (self.delegate != nil) {
        [self.delegate img1_tap:self] ;
    }
}

- (void)setFood:(Food*)food;
{
    [self.lblName setText:food.foodName ] ;
    if (food.note != NULL) {
      //[self.lblType setText:food.note ] ;
    } else {
        
    }
    //[self.lblType setText:food.note ] ;
    if (food.quantity.integerValue != 0) {
        _img1.hidden = false ;
        _img2.image = [ UIImage imageNamed:@"img_add"] ;
        NSString *str = [NSString stringWithFormat:@"%@  x %@" , food.price , food.quantity] ;
        [self.lblPrice setText:str] ;
    } else {
        NSString *str = [NSString stringWithFormat:@"%@" , food.price] ;
        _img1.hidden = true ;
        _img2.image = [ UIImage imageNamed:@"img_cart"] ;
        [self.lblPrice setText:str] ;
    }
}

@end
