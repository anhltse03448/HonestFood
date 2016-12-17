//
//  CartView.m
//  HackathonFacebook
//
//  Created by Tuan Vu on 12/15/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "CartView.h"


@interface CartView ()
@property (weak, nonatomic) IBOutlet UIImageView *imvCart;
@property (weak, nonatomic) IBOutlet UILabel *lblIndicator;



@end

@implementation CartView

+ (instancetype)sharedInstance
{
    static CartView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray  *nib = [[NSBundle mainBundle]loadNibNamed:@"CartView" owner:nil options:nil];
        sharedInstance = nib[0];

        // Do any other initialisation stuff here
    });
    return sharedInstance;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    _lblIndicator.layer.cornerRadius = 10.0f;
    _lblIndicator.layer.masksToBounds = YES;
    _lblIndicator.adjustsFontSizeToFitWidth = YES;
    _imvCart.image = [_imvCart.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate ];
    _imvCart.tintColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateLabelIndicator) name:kNotifyAddFoodToCartName object:nil];
    
}

-(void)updateLabelIndicator
{
    _lblIndicator.text = [@([[[GlobalVar getInstance]foodList] count]) stringValue];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
