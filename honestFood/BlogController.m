//
//  BlogController.m
//  honestFood
//
//  Created by Tuan Vu on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "BlogController.h"
#import "BlogCell.h"

@interface BlogController ()<UITableViewDelegate , UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblBlog;
@property (strong , nonatomic) NSMutableArray *blogList;

@end

@implementation BlogController

- (void)viewDidLoad {
    [super viewDidLoad];
    _blogList  = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return  _blogList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellId = @"BlogCellID";
    
    BlogCell *cell = (BlogCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BlogCell" owner:nil options:nil];
        cell = nib[0];
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
