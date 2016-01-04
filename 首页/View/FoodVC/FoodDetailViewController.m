//
//  FoodDetailViewController.m
//  LoveLife
//
//  Created by 小破夕 on 16/1/4.
//  Copyright © 2016年 xiaopoxi. All rights reserved.
//

#import "FoodDetailViewController.h"

#import "FoodDetailModel.h"
#import "FoodDetailTableViewCell.h"

@interface FoodDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
    UIView * _mainBgView;
    //背景大图
    UIImageView * _mainImageView;
    //菜品名称
    UILabel * _titleLabel;
    //详情描述
    UILabel * _detailLabel;
    
    
    //矢量
    UILabel * _levelLabel;
    UILabel * _timeLabel;
    UILabel * _tasteLabel;
    
    
}
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong) FoodDetailModel * model;

@end

@implementation FoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    
    [self createUI];
    
    [self createHeaderView];
    
    [self getData];
    

}



-(void)getData{
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"dishes_id": self.dataId, @"methodName": @"DishesView"};
    [manger POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0)
        {
            NSDictionary * detailDic = responseObject[@"data"];
            _model = [[FoodDetailModel alloc]init];
            _model.image = detailDic[@"image"];
            _model.dishes_name= detailDic[@"dishes_name"];
            _model.material_desc = detailDic[@"material_desc"];
            _model.step = detailDic[@"step"];
           
            [self refreshUI:_model];

            [_tableView reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 刷新UI
-(void)refreshUI:(FoodDetailModel *)model
{
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = model.dishes_name;
    _detailLabel.text = model.material_desc;
    
}

-(void)createHeaderView{
    
    _mainBgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H + 64)];
    _mainBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainBgView];
    
    //背景
    _mainImageView = [FactoryUI createImageViewWithFrame:CGRectMake(0, 0, SCREEN_W, (SCREEN_H + 64) / 3 * 2) imageName:nil];
    _mainImageView.userInteractionEnabled = YES;
    [_mainBgView addSubview:_mainImageView];
    
    //返回按钮
    UIButton * backButton = [FactoryUI createButtonWithFrame:CGRectMake(10, 10, 30, 30) title:nil titleColor:nil imageName:@"iconfont-back" backgroundImageName:nil target:self selector:@selector(leftButtonClick)];
    [_mainImageView addSubview:backButton];
    
    //名称
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _mainImageView.frame.size.height + 15, SCREEN_W - 20, 20) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:20]];
    [_mainBgView addSubview:_titleLabel];
    
    //详情描述
    _detailLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _titleLabel.frame.size.height + _titleLabel.frame.origin.y + 10, SCREEN_W - 20, 50) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14]];
    _detailLabel.numberOfLines = 0;
    _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_mainBgView addSubview:_detailLabel];
    
}


-(void)createUI{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
#pragma mark - 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    FoodDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[FoodDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}



-(void)initDataSource{
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
}



#pragma mark - 设置导航
-(void)setingNav
{
    self.titleLabel.text = self.NavTitle;
    [self setleftButtonClick:@selector(leftButtonClick)];
}

#pragma mark - 按钮响应函数
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/









@end
