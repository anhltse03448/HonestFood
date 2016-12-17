//
//  CommentTableViewCell.h
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblname;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;

@end
