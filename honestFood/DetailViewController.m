//
//  DetailViewController.m
//  honestFood
//
//  Created by Anh Tuan on 12/17/16.
//  Copyright © 2016 tuanvu. All rights reserved.
//

#import "DetailViewController.h"
#import "CommentTableViewCell.h"
#import "CommentObject.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView *btnBack;
@property (weak, nonatomic) IBOutlet EMEmojiableBtn *emojiBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UITableView *tbl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *commentList;
@end

@implementation DetailViewController 

- (void)viewDidLoad {
    _commentList = [[NSMutableArray alloc]init];
    [super viewDidLoad];
    self.tbl.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [ self initEmoji];
    [self.navigationController setNavigationBarHidden:true];
    _btnBack.userInteractionEnabled = true;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_btnBack addGestureRecognizer:gesture];
    [_lblTitle setText:_food.foodName];
    NSString *price = [[NSString alloc]initWithFormat:@"%.0f", _food.price.doubleValue];
    [_lblPrice setText:price];
    [self initChart];
    self.tbl.delegate = self ;
    self.tbl.dataSource = self ;
    
}

- (void)viewWillAppear:(BOOL)animated;
{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    NSString *foodID = [[ NSString alloc]initWithFormat:@"%@",_food.foodId];
    
    [API getWithUrl:@"getcomment" param:@{@"foodid" : foodID} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        for (NSDictionary *dict in responseObject) {
            NSLog(@"res :%@",dict[@"owner"]);
            CommentObject *commentObejct = [[ CommentObject alloc]initWithDictionary:dict];
            [tmp addObject:commentObejct];
        }
        _lblComment.text = [[NSString alloc]initWithFormat:@"Comment ( %lu )", (unsigned long)self.commentList.count];
        self.commentList = tmp ;
        [ self.tbl reloadData] ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error) ;
    } ];
}

- (void)initEmoji ;
{
    EMEmojiableBtn *button = [[EMEmojiableBtn alloc] initWithFrame:CGRectMake(20, 340, 30, 30)];
    button.delegate = self;
    button.dataset = @[
                       [[EMEmojiableOption alloc] initWithImage:@"img_1" withName:@"dislike"],
                       [[EMEmojiableOption alloc] initWithImage:@"img_2" withName:@"broken"],
                       [[EMEmojiableOption alloc] initWithImage:@"img_3" withName:@"he he"],
                       [[EMEmojiableOption alloc] initWithImage:@"img_4" withName:@"ooh"],
                       [[EMEmojiableOption alloc] initWithImage:@"img_5" withName:@"meh !"],
                       [[EMEmojiableOption alloc] initWithImage:@"img_6" withName:@"ahh !"]
                       ];
    [button setImage:[UIImage imageNamed:@"img_1"] forState:UIControlStateNormal];
    [self.scrollView addSubview:button];
}

- (void)EMEmojiableBtn:(EMEmojiableBtn *)button selectedOption:(NSUInteger)index;
{
    NSString *str = [[NSString alloc]initWithFormat:@"img_%lu",(unsigned long)(index + 1)];
    [button setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
}

-(void)tap:(UITapGestureRecognizer *)gesture ;
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initChart ;
{
    
    
    self.barChartView.userInteractionEnabled = false ;
    self.barChartView.xAxis.drawLabelsEnabled = false ;
    self.barChartView.leftAxis.drawGridLinesEnabled = false ;
    self.barChartView.leftAxis.drawLabelsEnabled = false ;
    self.barChartView.leftAxis.drawAxisLineEnabled = false;
    
    self.barChartView.rightAxis.enabled = true ;
    self.barChartView.rightAxis.gridColor = [UIColor grayColor];
    self.barChartView.rightAxis.gridLineDashLengths  = @[@3 , @0.2 , @0.1];
    self.barChartView.rightAxis.labelTextColor = [UIColor grayColor];
    
    self.barChartView.xAxis.drawGridLinesEnabled = true;
    self.barChartView.xAxis.gridLineDashLengths = @[@3 , @0.2 , @0.1];
    self.barChartView.xAxis.drawAxisLineEnabled = true ;
    self.barChartView.xAxis.labelPosition = XAxisLabelPositionBottom ;
    self.barChartView.descriptionText = @"" ;
    
    
    
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    [yVals addObject:[[BarChartDataEntry alloc] initWithX:(double)0 y:_food.nutrition.fat.doubleValue]];
    
    
    BarChartDataSet *set1 = nil;
    
    set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"Fat"];
    [set1 setColors:ChartColorTemplates.material];
    set1.axisDependency = AxisDependencyRight ;
    
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    [yVals2 addObject:[[BarChartDataEntry alloc] initWithX:(double)1 y:_food.nutrition.protein.integerValue]];
    
    BarChartDataSet *set2 = nil;
    
    set2 = [[BarChartDataSet alloc] initWithValues:yVals2 label:@"Protein"];
    [set2 setColors:ChartColorTemplates.material];
    set2.axisDependency = AxisDependencyRight ;
    
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    [yVals3 addObject:[[BarChartDataEntry alloc] initWithX:(double)2 y:_food.nutrition.carbohydrate.integerValue]];
    
    BarChartDataSet *set3 = nil;
    
    set3 = [[BarChartDataSet alloc] initWithValues:yVals3 label:@"Carbonhydrate"];
    [set3 setColors:ChartColorTemplates.material];
    set3.axisDependency = AxisDependencyRight ;
    
    
    
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
    
    data.barWidth = 0.3f;
    self.barChartView.data = data ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return  self.commentList.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *cellIdentify = @"CommentTableViewCell" ;
    CommentTableViewCell *cell = [self.tbl dequeueReusableCellWithIdentifier:cellIdentify] ;
    
    if (!cell) {
        //[_foodImage sd_setImageWithURL:[NSURL URLWithString:food.imgUrl] placeholderImage:nil];
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CommentTableViewCell" owner:nil options:nil];
        cell = nib[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    CommentObject *cmo = self.commentList[indexPath.row];
    cell.lblname.text = [[NSString alloc]initWithFormat:@"%@ %@",cmo.owner.lastName,cmo.owner.firstName ];
    cell.lblComment.text = cmo.content ;
//    cell.img.layer.masksToBounds = true ;
//    cell.img.layer.cornerRadius = cell.img.layer.frame.size.width / 2 ;
    NSURL *url = [[NSURL alloc]initWithString:cmo.owner.imgUrl];
    [cell.img sd_setImageWithURL:url];
    return  cell ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 100 ;
}

@end
