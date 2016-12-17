//
//  UIButton+VerticalLayout.m
//  AppBliss
//
//  Created by Tuan Vu on 11/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "UIButton+VerticalLayout.h"

@implementation UIButton (VerticalLayout)



- (void)setImage:(UIImage*)img andTitle:(NSString*)title and:(ButtonLayout)layout;
{

    if (self) {
        
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:img forState:UIControlStateNormal];
        [self setTintColor:[UIColor whiteColor]];
        
        if (layout == ButtonLayoutVertical) {
            [self centerVerticallyWithPadding:10.0f];
        }
        if (layout == ButtonLayoutLeftRight) {
            
            self.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            self.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            self.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        }
        
    }
}

-(void)leftRight
{
   
    self.titleEdgeInsets = UIEdgeInsetsMake(0, self.imageView.frame.size.width, 0, self.imageView.frame.size.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.frame.size.width, 0, self.titleLabel.frame.size.width);
}

- (void)centerVerticallyWithPadding:(float)padding
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
                                            0.0f,
                                            0.0f,
                                            - titleSize.width);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            - imageSize.width,
                                            - (totalHeight - titleSize.height),
                                            0.0f);
    
}


- (void)centerVertically
{
    const CGFloat kDefaultPadding = 6.0f;
    
    [self centerVerticallyWithPadding:kDefaultPadding];
}

@end
