//
//  DetailViewController.h
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts ;

@interface DetailViewController : UIViewController<EMEmojiableBtnDelegate , UITableViewDataSource , UITableViewDelegate>
@property (weak , nonatomic) Food *food;
@property (weak, nonatomic) IBOutlet BarChartView *barChartView;

@end
