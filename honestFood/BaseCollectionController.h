//
//  AppDelegate.m
//  honestFood
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionController.h"
#import "BaseController.h"

@interface BaseCollectionController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic ,strong) NSMutableArray *data;

@end
