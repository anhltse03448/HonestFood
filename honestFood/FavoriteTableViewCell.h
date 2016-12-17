//
//  FavoriteTableViewCell.h
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@protocol SomethingDelegate <NSObject>
@optional
- (void)img2_tap:(UITableViewCell *)cell ;
- (void)img1_tap:(UITableViewCell *)cell ;
@end

@interface FavoriteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView *img_food;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UIImageView *check;
@property (nonatomic,weak) id <SomethingDelegate> delegate;


- (void)setFood:(Food*)food;
- (void)setEditting:(BOOL )check ;
@end
