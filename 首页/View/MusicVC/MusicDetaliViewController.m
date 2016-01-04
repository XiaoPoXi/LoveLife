//
//  MusicDetaliViewController.m
//  LoveLife
//
//  Created by 小破夕 on 16/1/4.
//  Copyright © 2016年 xiaopoxi. All rights reserved.
//

#import "MusicDetaliViewController.h"

//活动指示器
#import "MBProgressHUD.h"

#import "MusicListCell.h"

@interface MusicDetaliViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    int _page;
    
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong) MBProgressHUD *hub;

@end

@implementation MusicDetaliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingNav];
    _page = 0;
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
    [self createUI];
    
    [self refreshUI];
}

-(void)refreshUI{
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [_tableView.header beginRefreshing];
    
}


-(void)loadNewData{
    
    _page ++;
    [self getData];
}
-(void)getData{
    
    
    //让活动指示器显示
    [_hub show:YES];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [manager GET:self.urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dic in responseObject[@"data"]) {
            MusicModel *model = [[MusicModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        
       //数据请求成功--停止刷新结束活动指示器----刷新界面
        
        [_tableView.footer endRefreshing];
        
        [_hub hide:YES];
        
        [_tableView reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)createUI{
 
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    _hub = [[MBProgressHUD alloc] initWithView:self.view];
    //设置家在文字
    _hub.labelText = @"正在玩命加载...";
    //s设置加载文字的大小
    _hub.labelFont = [UIFont systemFontOfSize:30];
    //设置加载文字的额颜色
    _hub.labelColor = [UIColor redColor];
    //设置背景业内色
    _hub.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    //设置指示器的颜色
    _hub.activityIndicatorColor = [UIColor whiteColor];
    
    [self.view addSubview:_hub];
    
    
    
}

#pragma mark - 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MusicListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[MusicListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    if (_dataArray) {
        MusicModel *model = _dataArray[indexPath.row];
        [cell refreshUI:model];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}





#pragma mark - 导航栏
-(void)settingNav{
    self.titleLabel.text = _typeString;
    
    [self.leftButton setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [self setleftButtonClick:@selector(click)];
}

-(void)click{
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
