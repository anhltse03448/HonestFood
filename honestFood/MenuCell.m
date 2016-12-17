//
//  MenuCell.m
//  Amazing
//
//  Created by Tuan Vu on 12/8/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "MenuCell.h"



@implementation MenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lblNumberIndicator.layer.cornerRadius = 10.0f;
    _lblNumberIndicator.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
