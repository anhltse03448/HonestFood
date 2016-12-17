//
//  UIButton+VerticalLayout.h
//  AppBliss
//
//  Created by Tuan Vu on 11/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ButtonLayout) {
    
    ButtonLayoutVertical,
    ButtonLayoutLeftRight
    
};

@interface UIButton (VerticalLayout)


- (void)setImage:(UIImage*)img andTitle:(NSString*)title and:(ButtonLayout)layout;
- (void)centerVerticallyWithPadding:(float)padding;
- (void)centerVertically;

@end
